# Nextcloud WebDAV Mount — manual setup guide (2.0.x)

**Nextcloud WebDAV Mount** (`nextcloud_webdav_mount`) brings a **Nextcloud (or
generic WebDAV) share** into Drupal's file system using **rclone**, so IMCE and any
module that reads `private://` or `public://` can browse and use those files. This
page covers the **2.0.x** branch.

A global admin form picks the **operation mode**:

- **Mount** — PHP spawns `rclone mount` (FUSE), so remote files appear locally in
  real time. Needs `/dev/fuse` (often `SYS_ADMIN` in Docker) — best on bare metal.
- **Sync** — PHP runs `rclone sync` / `bisync` on demand or on cron. No FUSE, so
  it is safe in unprivileged containers. Sync direction can be pull, push, or
  bidirectional (bisync).
- **External** — *new in 2.0* — passive: something outside Drupal (a host FUSE
  process, a Kubernetes/Docker sidecar, a bind‑mount) mounts Nextcloud at
  `external_mount_path` (default `private://nextcloud`), and the module only reports
  status. It stores **no credentials** and spawns **no rclone**.

Compared with the 1.x line, 2.0 makes **External** mode a first‑class option (ideal
for containerised hosting where PHP must stay unprivileged) and adds optional
**OpenID Connect** integration that auto‑fills a user's Nextcloud login and app
password from SSO claims on login. Global settings (server URL, WebDAV path
template, mode, cron interval) are **admin‑only**; per‑user settings (login name,
app password/token, mount path, remote subpath) live at `/user/{uid}/nextcloud`. It
also adds a "Nextcloud" admin‑toolbar tray, IMCE integration, and eight Drush
commands.

> **Security posture (from the module's own docs).** WebDAV runs over the
> admin‑configured **HTTPS** URL with **TLS verification on** — both the Guzzle
> status checks and rclone use default certificate validation (no `verify => false`
> / `--no-check-certificate`). rclone credentials are passed via obscured
> `RCLONE_CONFIG_*` environment variables rather than a config file. Only admins can
> set the server URL, so there is no lower‑privilege SSRF surface. You still must
> keep **per‑user Nextcloud credentials** secret, and choose the destination scheme
> deliberately — syncing into **public** files makes content web‑accessible, so use
> **private** and restrict download for non‑public content. This project is **not
> covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, install rclone,
   set the private files path, and enable the module.
2. [Configuration](configuration/index.md) — the global and per‑user settings,
   config keys, Drush commands, permissions, path safety, and OpenID Connect.

## Where it lives in the admin menu

Global settings are at **Configuration → Web Services → Nextcloud WebDAV Mount**
(`/admin/config/services/nextcloud-webdav-mount`, route
`nextcloud_webdav_mount.settings`). Each user's settings live at
**`/user/{uid}/nextcloud`**. A "Nextcloud" tray is added to the admin toolbar for
users who may use it. The module provides its own permissions and Drush commands.
