<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flysystem SFTP registers an `sftp` Flysystem adapter so a Drupal stream wrapper scheme can read and write files on a remote SFTP server.
---
The module is a thin plugin (`src/Flysystem/Sftp.php`, `@Adapter(id = "sftp")`) that wraps `League\Flysystem\Sftp\SftpAdapter`. It receives the scheme's `config` array (host, username, password and/or privateKey, root, optional port/timeout) directly from the site's `$settings['flysystem']` in `settings.php`, connects, and returns the adapter (or a `MissingAdapter` on failure). The `ensure()` health check attempts a connection and reports login/root errors to the Flysystem status report. All heavy lifting is done by Flysystem and the League SFTP adapter; this module only supplies the adapter id and configuration passthrough.

Operationally, credentials live in `settings.php` (or a settings override) as part of the Flysystem scheme definition — a password or a private key path/contents. This is deployment-level configuration, not a request-driven form, so there is no UI, route, or permission in this module. Security review note: the module passes configuration straight to `SftpAdapter` and does not set or require an SSH host-key fingerprint, so host-key/`hostFingerprint` verification is not enforced by default (connections trust whatever host answers), and credentials are stored in plaintext settings — see the security notes below.
---
- Define an `sftp` Flysystem scheme in `$settings['flysystem']`.
- Store public files on a remote SFTP server.
- Serve a private file scheme backed by SFTP.
- Authenticate to the SFTP server with a password.
- Authenticate with an SSH private key (path or contents).
- Set a custom port and connection timeout.
- Point the adapter at a specific remote root directory.
- Enable Flysystem metadata caching for the scheme.
- Offload media/uploads to external SFTP storage.
- Check connectivity via the Flysystem status report (ensure()).
- Migrate an existing scheme's files to SFTP with Flysystem tools.
- Use SFTP storage for backups or exports.
- Pin the SSH host fingerprint (add `hostFingerprint` to the scheme config) to harden connections.
- Keep SFTP credentials out of VCS by using a settings override.
- Share files between Drupal and an external system over SFTP.
- Define multiple SFTP schemes for different remote servers.
- Verify an SFTP scheme is healthy before going live.
- Combine SFTP storage with Drupal's private file access checks.