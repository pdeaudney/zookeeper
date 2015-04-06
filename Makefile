test:
	#docker run -v ${PWD}:/etc/ansible/roles/role -d playlist/infrastructure /etc/ansible/roles/role/tests/run.sh
	./tests/run.sh

.PHONY: test
