# Remote File Importer — manual setup guide

**Remote File Importer** (`remote_file_importer`) automates pulling files from a
remote storage system into your Drupal site. You define one or more remote data
sources — each with its own connection details and schedule — and the module
scans them and downloads new files into Drupal's file storage. It's built for
organizations that need regular, automated ingestion of assets or documents from
an FTP (or, via a companion module, SFTP) server.

The core module ships an FTP/FTPS data source in its `remote_file_importer_ftp`
submodule. **SFTP support lives in a separate module**,
[Remote File Importer — SFTP](https://www.drupal.org/project/remote_file_importer_sftp),
which plugs into this one. The data-source system is pluggable, so different
protocols are added as plugins.

You can run imports **manually from the admin UI** or **from the command line with
Drush**, and the module offers intelligent handling options such as checking file
modification dates and deleting files, so only relevant, updated files are
imported. It runs on Drupal 10 and 11.

Because this module reaches out to remote servers with stored credentials and
brings **external files** into your site, there are real security considerations —
credential storage, egress, and treating imported files as untrusted. Those are
covered in [Configuration](configuration/index.md); please read them before
pointing it at a production source.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the FTP submodule (or the separate SFTP module).
2. [Configuration](configuration/index.md) — add a remote data source, set the
   schedule and destination, and handle credentials safely.

## How to use it

After enabling the module and a data-source plugin (FTP submodule or the SFTP
module), add a data source with its connection details in the admin UI, then let
the schedule run imports automatically — or trigger an import on demand from the
UI or with `drush`. See [Configuration](configuration/index.md) for the full
walkthrough.
