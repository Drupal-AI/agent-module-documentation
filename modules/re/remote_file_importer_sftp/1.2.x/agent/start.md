<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remote File Importer — SFTP — agent index

An **SFTP data-source plugin for Remote File Importer** (host/user/password/remote dir). Depends on
`remote_file_importer`. Version **1.2.0**. Core `^10||^11`.

Integration/import (admin) — the SFTP **password is stored in the data-source config** (exports to YAML —
restrict config access, avoid committing; use a least-privilege scoped account). Drupal's password element does
not re-render the stored value into the form. Encrypted in transit (SSH). No access role.
