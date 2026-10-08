<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remote File Importer — agent index

**Imports files from remote data storages (FTP/SFTP/…) into Drupal** via pluggable data sources
(`remote_file_importer_ftp` submodule; SFTP is a separate module). Version **1.3.0**. Core `^10||^11`.

Integration/import (admin) — connects with **stored credentials** (in data-source config — can export to VCS;
restrict/avoid committing); imports **untrusted remote files** (validate file types). No access role.
