TeamSpeak 3 Server
==================

Role to deploy a TeamSpeak 3 server.  
Inspired by [dharmab/ansible-playbooks/roles/teamspeak](https://github.com/dharmab/ansible-playbooks/tree/master/roles/teamspeak).

TeamSpeak 3 servers installed with this role can also be updated to newer versions with this role.  
By incrementing the TeamSpeak 3 version number, and assigning the appropriate SHA256 checksum string, this role will copy your currently installed TeamSpeak 3 server and update it to the new version.  

The upgrade mechanism can also be used for restoring TeamSpeak 3 servers from a backup. 

1. Extract your old Teamspeak 3 server files to a directory called `{teamspeak.home}/oldts/teamspeak3-server_linux_amd64/` 
2. Create the `current` symlink in `{teamspeak.home}` to point to `oldts`. For example: `cd /opt/teamspeak && ln -s oldts current`
3. Now run this Ansible role and the updater mechanism should find it and use it.

Requirements
------------

Tested on Ubuntu 16.04.1.

Role Variables
--------------

<tt>defaults/main.yml</tt>:

* <tt>teamspeak.user</tt>: User to run the teamspeak server. Defaults to "teamspeak".
* <tt>teamspeak.comment</tt>: User comment field. Defaults to "Teamspeak 3 user".
* <tt>teamspeak.home</tt>: Home directory for the teamspeak user. Will also be used to install the teamspeak server in. Defaults to "/opt/teamspeak".
* <tt>teamspeak.shell</tt>: Shell for the teamspeak user. Defaults to "/usr/sbin/nologin".
* <tt>teamspeak.symlink</tt>: Name of symlink to point to current TeamSpeak 3 server directory. Defaults to "current".
* <tt>teamspeak.version</tt>: Version of Teamspeak 3 Server to install. Defaults to "3.0.12.4".
* <tt>teamspeak.checksum</tt>: SHA256 checksum of archive of TeamSpeak 3 server version for verification purposes. Example: "sha256:6bb0e8c8974fa5739b90e1806687128342b3ab36510944f576942e67df7a1bd9"
* <tt>teamspeak.keep</tt>: Amount of TeamSpeak 3 server versions to keep installed, includes current version. A setting of "2" keeps the current and one previous version installed.

* <tt>teamspeak_ini.machine_id</tt>: Teamspeak server machine ID, used for multiple instances on the save database.
* <tt>teamspeak.voice</tt>: Properties of the voice server
* <tt>teamspeak.voice.ip</tt>: Voice server bind IP
* <tt>teamspeak.voice.create_default</tt>: Let teamspeak3 server on first start create default server (TODO #7)
* <tt>teamspeak.voice.default_port</tt>: Default voice server port (TODO #7)
* <tt>teamspeak.filetransfer</tt>: Properties of the file transfer server
* <tt>teamspeak.filetransfer.ip</tt>: File transfer server bind IP
* <tt>teamspeak.filetransfer.port</tt>: File transfer server listen port
* <tt>teamspeak.query</tt>: Properties of the server query
* <tt>teamspeak.query.ip</tt>: Server query bind IP
* <tt>teamspeak.query.port</tt>: Server query listen port
* <tt>teamspeak.db_plugin</tt>: Teamspeak database system (TODO #4) 
* <tt>teamspeak.logpath</tt>: Teamspeak logpath. Must be absolute 
* <tt>teamspeak.logquerycommand</tt>: Teamspeak log all query command


<tt>vars/{debian,redhat}.yml</tt>:

* <tt>systemd_service_file_path</tt>: Path where Systemd service files are installed.

Dependencies
------------

rsync should be installed on the host to perform TeamSpeak 3 Server upgrades, used by the "synchronize" module.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: ts3servers
      roles:
         - { role: teamspeak, tags: teamspeak }

License
-------

MIT

Author Information
------------------

Stefan Joosten <stefan@sjoosten.nl>
