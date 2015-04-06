#!/bin/bash -ex

# Setup
CONTAINER_HOST="127.0.0.1"
if [[ $OSTYPE == darwin* ]]; then
  CONTAINER_HOST="$(boot2docker ip)"
fi
sed "s/HOST/$CONTAINER_HOST/" tests/inventory.template > tests/inventory
chmod 600 tests/insecure.key

# Install role
tar czf tests/role .
cd tests
ansible-galaxy install -f role
rm role

# Test syntax
ansible-playbook -i inventory playbook.yml --syntax-check

# Kill existing running container
docker inspect ansible-test >/dev/null && (docker kill ansible-test || true) && docker rm ansible-test

# Run new test container
docker run --name=ansible-test -d -p 2201:22 playlist/infrastructure /sbin/init

# Auto-remove the container on exit
function finish {
  echo "Killing docker container"
  (docker kill ansible-test && docker rm ansible-test) || true
}
trap finish EXIT

# Wait for SSH
echo "Waiting for ssh..."
while ! echo exit | nc "$CONTAINER_HOST" 2201; do sleep 1; done
echo "Got SSH"

# Provision with ansible
ansible-playbook -i inventory playbook.yml --sudo

# Perform idempotence test
(ansible-playbook -i inventory playbook.yml --sudo \
  | grep -q 'changed=0.*failed=0' \
  && (echo 'Idempotence test: pass' && exit 0)) \
  || (echo 'Idempotence test: fail' && exit 1)

# Clean up
rm -rf .ansible inventory
