TeamSpeak 3 Server
==================

Role that deploys a TeamSpeak 3 server.
Inspired by [dharmab/ansible-playbooks/roles/teamspeak](https://github.com/dharmab/ansible-playbooks/tree/master/roles/teamspeak).

Requirements
------------

Tested on Ubuntu 16.04.1.

Role Variables
--------------

defaults/main.yml:

* teamspeak.user: User to run the teamspeak server. Defaults to "teamspeak".
* teamspeak.comment: User comment field. Defaults to "Teamspeak 3 user".
* teamspeak.home: Home directory for the teamspeak user. Will also be used to install the teamspeak server in. Defaults to "/opt/teamspeak".
* teamspeak.shell: Shell for the teamspeak user. Defaults to "/usr/sbin/nologin".
* teamspeak.version: Version of Teamspeak 3 Server to install. Defaults to "3.0.12.4".
* teamspeak.checksum: "sha256:6bb0e8c8974fa5739b90e1806687128342b3ab36510944f576942e67df7a1bd9"

vars/{debian,redhat}.yml:

* systemd_service_file_path: Path where Systemd service files are installed.

Dependencies
------------

No other dependencies I am aware of.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: ts3servers
      roles:
         - teamspeak

License
-------

MIT

Author Information
------------------

Stefan Joosten <stefan@sjoosten.nl>
