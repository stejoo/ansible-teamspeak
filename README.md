# TeamSpeak 3 Server

Role to deploy a TeamSpeak 3 server.  
Inspired by [dharmab/ansible-playbooks/roles/teamspeak](https://github.com/dharmab/ansible-playbooks/tree/master/roles/teamspeak).

This role defaults to setting up a basic TeamSpeak 3 Server without special configuration. It downloads, extracts, sets up and runs a TeamSpeak 3 Server without any bells and whistles. But in case you want to, you can have it configure TeamSpeak 3 Server for you in multiple ways (and more to come). The aim is to make this role usable for the simplest of deployments, e.g. "I just want a TeamSpeak 3 Server plain and simple", to more complex deployments making use of alternate ports, licenses and external databases.

Once installed with this role TeamSpeak 3 Servers can also be updated to newer versions using this role.
By incrementing the TeamSpeak 3 version number, and assigning the appropriate SHA256 checksum string, this role will copy your currently installed TeamSpeak 3 server and update it to the new version.  

The upgrade mechanism can also be used for restoring TeamSpeak 3 servers from a backup using the following steps:

1. Extract your old Teamspeak 3 server files to a directory called `{teamspeak.home}/oldts/teamspeak3-server_linux_amd64/` 
2. Create the `current` symlink in `{teamspeak.home}` to point to `oldts`. For example: `cd /opt/teamspeak && ln -s oldts current`
3. Run this Ansible role and the updater mechanism should find it and use it.

## Requirements

Tested on Ubuntu 16.04.1.

## Role Variables

For simple installations, the defaults do not need to be changed. But in case you want to or you need more complex deployment, here's an overview:

### Basics

These variables define properties for the user thats going to run the TeamSpeak 3 Server, which version of TeamSpeak 3 Server will be installed and at what location on the disk. 

* `teamspeak.user`: User to run the teamspeak server. Defaults to "teamspeak".
* `teamspeak.comment`: User comment field. Defaults to "Teamspeak 3 user".
* `teamspeak.home`: Home directory for the teamspeak user. Will also be used to install the teamspeak server in. Defaults to "/opt/teamspeak".
* `teamspeak.shell`: Shell for the teamspeak user. Defaults to "/usr/sbin/nologin".
* `teamspeak.symlink`: Name of symlink to point to current TeamSpeak 3 server directory. Defaults to "current".
* `teamspeak.version`: Version of Teamspeak 3 Server to install. Defaults to "3.11.0".
* `teamspeak.checksum`: SHA256 checksum of archive of TeamSpeak 3 server version for verification purposes. Example: "sha256:18c63ed4a3dc7422e677cbbc335e8cbcbb27acd569e9f2e1ce86e09642c81aa2"
* `teamspeak.keep`: Amount of TeamSpeak 3 server versions to keep installed, includes the currently installed version. A setting of "3" keeps the current and two previous version installed, which is the default. In case an upgrade goes wrong, you simply rewind the `teamspeak.version` and `teamspeak.checksum` to the older version and run the role again to downgrade back to a known good.

### Further configuraton
To configure TeamSpeak 3 Server a INI-style configuration file is used. If you require detailed configuration, enable creation of such a file by setting the `teamspeak_ini_enabled` to `yes`. For example by defining it that way in host or group vars in your playbook. A INI file containing your configuration will be created.  

* `teamspeak_ini_enabled`: Set to `yes` if you want use the configuration options listed below. It will create INI-style configuration file for the TeamSpeak 3 Server to use. Defaults to `no`.
* `teamspeak_ini_filename`: Name of the INI-style configuration file. Defaults to `ts3server.ini`.

#### License file

If you have a TeamSpeak 3 Server license, you can have this role install it for you. Place your license file called `licensekey.dat` in the `files/` directory of this role. Tip: if you use Git, add that path to your `.gitignore` to make sure you do not push it somewhere by accident. 

* `teamspeak_use_license`: Set to `yes` to have your license set up. Default is `no`.
* `teamspeak_license_srcfile`: TeamSpeak 3 Server license file on Ansible host to copy to target. Default searches for the license file at `files/licensekey.dat`
* `teamspeak_licensepath`: Used to specify a directory where your license should be located on the target host. If a non-existent directory is specified it will be created for you. Make sure you enable the use of a INI configuration file, otherwise this option will be ineffective. The default is to leave this variable empty, which will place the license file in the same directory as the TeamSpeak 3 Server is installed in.  

#### Network configuration

The network configuration block can be used to configure the TeamSpeak 3 Server as you please. Make sure to define the configuration block in full as it contains nested properties. Most reliable way would be to copy a block from the `defaults/main.yml` into your own definitions file and edit accordingly. 

Description of the `teamspeak_network` configuration block and it's options:

* `teamspeak_network.voice`: Empty. Contains nested properties of the voice server. 
* `teamspeak_network.voice.default_port`: UDP port for voice clients to connect to. Default at UDP port 9987.
* `teamspeak_network.voice.ip`: IP address to listen on for incoming voice connections. Default at 0.0.0.0, which binds any IP address.
* `teamspeak_network.filetransfer`: Empty. Contains nested properties of the file transfer server.
* `teamspeak_network.filetransfer.port`: TCP port to use for file transfers. Default at TCP port 30033.
* `teamspeak_network.filetransfer.ip`: IP address where file transfers are bound to. Default to 0.0.0.0, which binds any IP address.
* `teamspeak_network.query`: Empty. Contains nested properties for the ServerQueries part of the server.
* `teamspeak_network.query.port`: TCP port used for ServerQuery connections. Default at TCP port 10011.
* `teamspeak_network.query.ip`: IP address where to listen for inbound ServerQuery connections. Default at 0.0.0.0, which binds any IP address.

#### Other options

* `teamspeak_ini_machine_id`: Teamspeak server machine ID. Used for running provide multiple instances on the same database with a unique ID. Default is empty.
* `teamspeak_create_default_virtualserver`: Defaults to `yes`. Normally one virtual server is created automatically when the TeamSpeak 3 Server process is started. If you set this to `no` a virtual server will not be started upon startup and you would have to start one manually using the ServerQuery interface. 

#### OS-dependent variables

Variables that differ across different Linux distributions have been set in `vars/{debian,redhat}.yml`:

* `systemd_service_file_path`: Path where Systemd service files are installed.

## Dependencies

rsync should be installed on the host to perform TeamSpeak 3 Server upgrades, used by the "synchronize" module.

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: ts3servers
      roles:
         - { role: ansible-teamspeak, tags: teamspeak }

## License

MIT

## Author Information

* Stefan Joosten `<stefan•ɑƬ•sjoosten•ɖɵʈ•nl>`
* Egbert Verhage `<egbert•ɑƬ•eggiecode•ɖɵʈ•org>`
