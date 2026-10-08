<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Remote File Importer imports files from remote data storages.

---

Remote File Importer **imports files from remote data storages** into Drupal — pulling files from a remote
source (via pluggable data-source plugins such as FTP/SFTP) into managed files/media, for automated content/
asset ingestion. It ships an `remote_file_importer_ftp` submodule (SFTP is a separate module), in the Web
services package.

Use it to ingest files from a remote server. It is an integration/import feature run by admins. Security/data
handling: it connects to a **remote server with stored credentials** — treat the source as trusted, and note
that connection **credentials are stored in the data-source configuration** (see the SFTP submodule's caveat:
credentials live in config, which can export to version control — restrict config access and avoid committing
them, or manage secrets out of band); it imports **remote files** (untrusted content — files land in Drupal, so
apply the usual file-type/validation and don't auto-serve them unsanitized). It has no access-control role.
Configure the data source and import.

---

- Import files from remote storages.
- Pull files via data-source plugins.
- Support FTP/SFTP sources.
- Ingest into managed files/media.
- Serve automated ingestion.
- Run as an admin.
- Connect with STORED credentials (in config).
- Restrict config access / avoid committing credentials.
- Treat imported remote files as untrusted.
- Apply file-type validation on import.
- Have no access-control role.
- Configure the data source + import.
- Handle remote imports.
- Import files.
- Configure the source.
- Pull files.
- Handle the integration.
- Ingest files.
- Secure the credentials.
- Provide remote file import.
