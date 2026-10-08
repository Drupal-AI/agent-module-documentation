<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nextcloud WebDAV Mount mounts or syncs Nextcloud WebDAV shares into Drupal private/public files via rclone, with FUSE and FUSE-free modes, IMCE integration, per-user credentials, cron sync and Drush commands.

---

Nextcloud WebDAV Mount mounts or syncs Nextcloud WebDAV shares into Drupal's file system using rclone —
supporting a FUSE mount or a FUSE-free sync mode (safe in Docker), IMCE integration, per-user credentials,
cron sync and Drush commands. This brings Nextcloud-stored files into Drupal for browsing/use. It provides
its own permissions and Drush commands, in the Custom package.

Use it to integrate Nextcloud storage with Drupal. Several security points matter: it stores **Nextcloud
credentials (per-user)** to authenticate to WebDAV — these must be stored securely (encrypted/secret, never
plaintext in config or logs) since they grant access to the user's Nextcloud; choose the **destination
scheme deliberately** — mounting/syncing into the **public** files directory would make the Nextcloud content
web-accessible, so use the **private** file system for anything non-public and ensure download access is
restricted; run rclone with least privilege; and operate WebDAV over HTTPS. IMCE integration exposes the
files to the file browser (per permissions). Configure the mount/sync, credentials and destination
carefully.

---

- Mount/sync Nextcloud WebDAV into Drupal.
- Use rclone (FUSE or FUSE-free sync).
- Support Docker-safe sync mode.
- Integrate with IMCE.
- Use per-user credentials.
- Provide cron sync and Drush commands.
- Store Nextcloud credentials securely (never plaintext).
- Choose the destination scheme deliberately.
- Use the private file system for non-public content.
- Not sync sensitive files into public files.
- Restrict download access.
- Run rclone with least privilege.
- Operate WebDAV over HTTPS.
- Provide its own permissions.
- Configure the mount/sync.
- Handle credentials securely.
- Mount cloud storage.
- Sync Nextcloud files.
- Configure the destination.
- Integrate Nextcloud storage.
