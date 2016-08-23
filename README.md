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

Available variables to set for the TeamSpeak 3 Server installation:

* `teamspeak.user`: User to run the teamspeak server. Defaults to "teamspeak".
* `teamspeak.comment`: User comment field. Defaults to "Teamspeak 3 user".
* `teamspeak.home`: Home directory for the teamspeak user. Will also be used to install the teamspeak server in. Defaults to "/opt/teamspeak".
* `teamspeak.shell`: Shell for the teamspeak user. Defaults to "/usr/sbin/nologin".
* `teamspeak.symlink`: Name of symlink to point to current TeamSpeak 3 server directory. Defaults to "current".
* `teamspeak.version`: Version of Teamspeak 3 Server to install. Defaults to "3.0.12.4".
* `teamspeak.checksum`: SHA256 checksum of archive of TeamSpeak 3 server version for verification purposes. Example: "sha256:6bb0e8c8974fa5739b90e1806687128342b3ab36510944f576942e67df7a1bd9"
* `teamspeak.keep`: Amount of TeamSpeak 3 server versions to keep installed, includes current version. A setting of "2" keeps the current and one previous version installed, which is the default.

If you need further configuration a INI file can be created for you. In such a case you should override the `teamspeak_ini_enabled` to `yes`. For example by defining it that way in host or group vars in your playbook.

* `teamspeak_ini_enabled`: Set to `yes` if you want use the configuration options listed below. It will create INI-style configuration file for the TeamSpeak 3 Server to use. Defaults to `no`.
* `teamspeak_ini_filename`: Name of the INI-style configuration file. Defaults to `ts3server.ini`.

The following configuration blocks can be used to configure the TeamSpeak 3 Server as you please. Make sure to override the complete blocks in full as they contain nested properties. Most reliable way is to copy a block from the `defaults/main.yml` into your own definitions file and edit accordingly.

* `teamspeak_network.voice`: Contains nested properties of the voice server. 
* `teamspeak_network.voice.default_port`: UDP port for voice clients to connect to. Default at UDP port 9987.
* `teamspeak_network.voice.ip`: IP address to listen on for incoming voice connections. Default at 0.0.0.0, which binds any IP address.
* `teamspeak_network.filetransfer`: Contains nested properties of the file transfer server.
* `teamspeak_network.filetransfer.port`: TCP port to use for file transfers. Default at TCP port 30033.
* `teamspeak_network.filetransfer.ip`: IP address where file transfers are bound to. Default to 0.0.0.0, which binds any IP address.
* `teamspeak_network.query`: Contains nested properties for the ServerQueries part of the server.
* `teamspeak_network.query.port`: TCP port used for ServerQuery connections. Default at TCP port 10011.
* `teamspeak_network.query.ip`: IP address where to listen for inbound ServerQuery connections. Default at 0.0.0.0, which binds any IP address.

Other TeamSpeak 3 Server options:

* `teamspeak_ini_machine_id`: Teamspeak server machine ID. Used for running provide multiple instances on the same database with a unique ID. Default is empty.
* `teamspeak_create_default_virtualserver`: Defaults to `yes`. Normally one virtual server is created automatically when the TeamSpeak 3 Server process is started. If you set this to `no` a virtual server will not be started upon startup and you would have to start one manually using the ServerQuery interface. 

Variables that differ across different Linux distributions have been set in `vars/{debian,redhat}.yml`:

* `systemd_service_file_path`: Path where Systemd service files are installed.

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
