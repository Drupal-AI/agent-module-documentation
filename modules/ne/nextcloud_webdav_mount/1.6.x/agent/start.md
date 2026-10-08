<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nextcloud WebDAV Mount — agent index

Mounts/syncs **Nextcloud WebDAV shares into Drupal's files via rclone** (FUSE + FUSE-free/Docker-safe sync;
IMCE integration; per-user credentials; cron sync; Drush). Provides permissions + Drush. Version **1.6.0**.
Core `^10||^11`.

**Security:** stores **per-user Nextcloud credentials** — keep secret (never plaintext); choose the
**destination scheme deliberately** — syncing into **public** files makes content web-accessible, so use the
**private** FS + restrict download for non-public content; rclone least privilege; WebDAV over HTTPS.
