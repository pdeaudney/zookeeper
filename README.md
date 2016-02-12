# Ansible Zookeeper Role

[![Travis CI](https://travis-ci.org/playlist-ansible/zookeeper.svg?branch=master)](https://travis-ci.org/playlist-ansible/zookeeper)
[![Galaxy](https://img.shields.io/badge/galaxy-playlist.zookeeper-blue.svg)](https://galaxy.ansible.com/list#/roles/3317)

Installs and configures Zookeeper (managed with Exhibitor).

## Requirements and Dependencies

Depends on a JRE ([playlist.java](https://github.com/playlist-ansible/java)).

## Installation

Using `ansible-galaxy`:

```
$ ansible-galaxy install playlist.zookeeper
```

## Role Variables

```yaml
zookeeper_version: 3.4.6
zookeeper_url: "http://www.apache.org/dist/zookeeper/zookeeper-{{zookeeper_version}}/zookeeper-{{zookeeper_version}}.tar.gz"

zookeeper_password: ""

zookeeper_data_dir: /var/lib/zookeeper
zookeeper_install_dir: "/opt/zookeeper-{{zookeeper_version}}"
zookeeper_log_dir: /var/log/zookeeper

exhibitor_version: 1.5.5
exhibitor_install_dir: "/opt/exhibitor-{{exhibitor_version}}"
exhibitor_log_dir: "{{zookeeper_log_dir}}"
exhibitor_port: 8181

exhibitor_s3_bucket: mybucket
exhibitor_s3_prefix: zookeeper
exhibitor_s3_region: us-east-1
#exhibitor_s3_access_key_id: mykey
#exhibitor_s3_access_secret_key: mysecret

exhibitor_log_index_directory: "{{zookeeper_log_dir}}"
exhibitor_zookeeper_install_directory: "{{zookeeper_log_dir}}"
exhibitor_zookeeper_data_directory: "{{zookeeper_data_dir}}"
exhibitor_zookeeper_log_directory: "{{zookeeper_log_dir}}"
exhibitor_servers_spec: ""
exhibitor_backup_extra: "throttle\\=&bucket-name\\={{exhibitor_s3_bucket}}&key-prefix\\={{exhibitor_s3_prefix}}&max-retries\\=4&retry-sleep-ms\\=30000"
exhibitor_zoo_cfg_extra: "tickTime\\=2000&initLimit\\=10&syncLimit\\=5&quorumListenOnAllIPs\\=true"
exhibitor_java_environment: ""
exhibitor_log4j_properties: ""
exhibitor_client_port: 2181
exhibitor_connect_port: 2888
exhibitor_election_port: 3888
exhibitor_check_ms: 30000
exhibitor_cleanup_period_ms: 43200000 # 12 hours
exhibitor_cleanup_max_files: 3
exhibitor_backup_max_store_ms: 86400000 # 1 day
exhibitor_backup_period_ms: 60000 # 1 minute
exhibitor_auto_manage_instances: 1
exhibitor_auto_manage_instances_settling_period_ms: 180000 # 3 minutes
exhibitor_observer_threshold: 999
exhibitor_auto_manage_instances_fixed_ensemble_size:
exhibitor_auto_manage_instances_apply_all_at_once: 1
```

If you want to use [key pair authentication](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
when accessing `exhibitor_s3_bucket` define:

```yaml
exhibitor_s3_access_key_id: mykey
exhibitor_s3_access_secret_key: mysecret
```

otherwise exhibitor will use [IAM role authentication](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html).

## Example Playbook

```yaml
- hosts: servers
  roles:
    - playlist.zookeeper
```

## Testing

```
$ git clone https://github.com/playlist-ansible/zookeeper.git
$ cd zookeeper
$ vagrant up
$ vagrant provision
```
