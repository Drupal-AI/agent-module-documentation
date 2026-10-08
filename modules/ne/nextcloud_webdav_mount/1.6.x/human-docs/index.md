# Nextcloud WebDAV Mount — manual setup guide (1.6.x)

**Nextcloud WebDAV Mount** (`nextcloud_webdav_mount`) brings a **Nextcloud WebDAV
share** into Drupal's file system using **rclone**, so IMCE and any module that
reads `private://` or `public://` can browse and use those files. This page covers
the **1.6.x** branch.

It supports three operation modes so you can match your hosting:

- **Mount** — Drupal runs `rclone mount` (FUSE), and remote files appear locally in
  real time. This needs `/dev/fuse` (and typically elevated capabilities in
  Docker), so it suits bare‑metal or privileged environments.
- **Sync** — Drupal runs `rclone sync` / `bisync` to copy files on demand or via
  cron. No FUSE is involved, which makes it safe in unprivileged containers.
- **External** — the mount is provided outside Drupal (a host process, sidecar, or
  bind‑mount) at a fixed path; the module only reports status, runs no rclone, and
  stores no Nextcloud credentials.

Settings are split between a **global admin form** (operation mode, server URL,
sync options) and a **per‑user form** (each user's Nextcloud login and app
password, plus their mount path — in Mount/Sync modes; External mode is
status‑only). It integrates with **IMCE** (an IMCE profile folder can be the
mount/sync target), supports Drupal tokens in paths (like `[user:name]`), runs
scheduled **cron sync**, and ships **Drush commands** for configuring, mounting,
syncing, and checking status.

> **Security matters here.** Per‑user Nextcloud credentials authenticate to your
> WebDAV share, so keep them secret and never in plaintext exports or logs. Choose
> the destination scheme deliberately — syncing into the **public** files directory
> makes the content web‑accessible, so use the **private** file system for anything
> non‑public and restrict download access. Run rclone with least privilege and
> operate WebDAV over HTTPS. This project is **not covered by Drupal's security
> advisory policy** — review it before production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, install rclone,
   set the private files path, and enable the module.
2. [Configuration](configuration/index.md) — choose an operation mode, set the
   global server URL, enter per‑user credentials, and mount or sync.

## Where it lives in the admin menu

Global settings are at **Configuration → Web Services → Nextcloud WebDAV Mount**
(`/admin/config/services/nextcloud-webdav-mount`). Each user's credentials and
mount path live at **`/user/{uid}/nextcloud`**. The module provides its own
permissions and Drush commands.
