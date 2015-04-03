test:
	docker run -v ${PWD}:/etc/ansible/roles/role -t --rm playlist/ansible /etc/ansible/roles/role/tests/run.sh

.PHONY: all
