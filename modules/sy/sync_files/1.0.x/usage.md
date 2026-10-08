<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sync Files synchronizes files from a remote server.

---

Sync Files **synchronizes files from a remote server** into the local (public/managed) file system — pulling
files from a configured remote source so a local environment mirrors another site's files (e.g. sync production
files to staging). It is in the Administration package.

Use it to mirror files from a remote environment. It is an administration/devops tool run by privileged users.
Security/data handling: it connects to a **remote server with configured credentials** (store them securely, use
a trusted source over an encrypted channel), and it imports **remote files** (treat as content coming from
elsewhere — apply your file hygiene, and don't sync into an environment where untrusted files could be served
unsanitized). It has no access-control role. Configure the remote source and sync.

---

- Sync files from a remote server.
- Mirror another environment's files.
- Pull files to local storage.
- Serve devops/administration.
- Support prod→staging file sync.
- Run as an admin.
- Connect with configured credentials (store securely).
- Use a trusted source over an encrypted channel.
- Treat imported remote files as untrusted.
- Have no access-control role.
- Configure the source and sync.
- Handle file sync.
- Sync files.
- Configure the source.
- Mirror files.
- Handle the transfer.
- Import files.
- Pull files.
- Secure the credentials.
- Provide remote file sync.
