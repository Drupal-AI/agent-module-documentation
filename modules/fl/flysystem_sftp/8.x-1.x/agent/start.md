<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flysystem SFTP (flysystem_sftp) — agent index
**An `sftp` Flysystem adapter plugin wrapping `League\Flysystem\Sftp\SftpAdapter`; configured via `$settings['flysystem']`.**

- **Version:** 8.x-1.x
- **Core:** ^9 || ^10 · **Depends:** flysystem
- **Plugin:** `src/Flysystem/Sftp.php` (`@Adapter(id = "sftp")`), `getAdapter()` + `ensure()`.
- **Config source:** `$settings['flysystem'][<scheme>]['config']` = host, username, password / privateKey, root, optional port, timeout.
- **Security:** no routes/permissions/UI — configuration is deployment-level in `settings.php`. Two review notes: (1) credentials (password or private key) are stored in plaintext settings; (2) the module passes config straight to `SftpAdapter` and does **not** set/require `hostFingerprint`, so SSH host-key verification is not enforced by default. Add a `hostFingerprint` to the scheme config to pin the host.

See [configure/scheme.md](configure/scheme.md).