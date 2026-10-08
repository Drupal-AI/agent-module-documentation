<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Remote File Importer SFTP provides an SFTP data source.

---

Remote File Importer — SFTP provides an **SFTP data-source plugin for Remote File Importer** — connecting to
an SFTP server (host/user/password/remote dir) to pull files into Drupal. It depends on the Remote File Importer
module, in the Web services package.

Use it to import files over SFTP. It is an integration/import feature run by admins. Security/data handling to
be aware of: the SFTP **password is stored in the data-source config entity** (the settings config), so it lands
in exported config YAML — **restrict who can access/export config and avoid committing that config to version
control** (or manage the credential out of band); prefer a dedicated, least-privilege SFTP account scoped to the
import directory. (Note: Drupal's password form element does not re-render the stored value, so the credential
isn't echoed back into the admin form HTML — but it is still in config.) It connects over SSH/SFTP (encrypted in
transit). It has no access-control role. Configure the SFTP connection.

---

- Provide an SFTP data source.
- Connect to an SFTP server.
- Pull files over SFTP.
- Depend on Remote File Importer.
- Serve file ingestion.
- Import over SSH/SFTP.
- STORE the SFTP password in data-source config.
- Restrict config access / avoid committing it.
- Use a least-privilege scoped SFTP account.
- Know the form doesn't re-render the stored password.
- Have no access-control role.
- Configure the SFTP connection.
- Handle SFTP import.
- Import via SFTP.
- Configure the source.
- Pull over SFTP.
- Handle the integration.
- Connect via SFTP.
- Secure the credential.
- Provide SFTP file import.
