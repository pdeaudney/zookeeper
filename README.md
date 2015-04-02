# Ansible Zookeeper Role

[![Circle CI](https://circleci.com/gh/playlist-ansible/zookeeper.svg?style=shield)](https://circleci.com/gh/playlist-ansible/zookeeper)
[![Galaxy](https://img.shields.io/badge/galaxy-playlist.zookeeper-blue.svg)](https://galaxy.ansible.com/list#/roles/3242)

Installs and configures Zookeeper (managed with Exhibitor).

## Requirements and Dependencies

Depends on a JRE (`playlist.java`).

## Installation

Using `ansible-galaxy`:

```
$ ansible-galaxy install playlist.zookeeper
```

## Role Variables

```yaml

```

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
$ make
```
