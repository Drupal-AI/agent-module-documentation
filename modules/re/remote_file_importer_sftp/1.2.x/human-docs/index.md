# Remote File Importer — SFTP — manual setup guide

**Remote File Importer — SFTP** (`remote_file_importer_sftp`) adds an **SFTP data
source** to the
[Remote File Importer](https://www.drupal.org/project/remote_file_importer)
module. Where the base module handles the scheduling, downloading, and file
management, this plugin teaches it how to connect to an **SFTP server** — over SSH,
so the transfer is encrypted in transit — and pull files from a remote directory
into Drupal. It currently authenticates with a **username and password**.

You use it exactly as you use any Remote File Importer data source: install it,
then create a data source of the SFTP type with the host, username, password, and
remote directory. It depends on the Remote File Importer base module and runs on
Drupal 10 and 11.

The one thing to internalize before you configure it: the **SFTP password is
stored in the data-source configuration entity**, which means it lands in exported
config YAML. That has direct consequences for how you handle the credential, all
covered in [Configuration](configuration/index.md). Please read that section
before connecting to a production server.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   base module) and enable it.
2. [Configuration](configuration/index.md) — create an SFTP data source and handle
   the password safely.

## How to use it

Once installed, this module simply makes "SFTP" available as a data-source type in
Remote File Importer. Add a data source of that type, enter the connection
details, and the base module handles the rest — scheduling, downloading, and
storing files. See [Configuration](configuration/index.md).
