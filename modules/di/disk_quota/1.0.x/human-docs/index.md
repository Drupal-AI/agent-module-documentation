# Disk Quota — manual setup guide

**Disk Quota** (`disk_quota`) puts a cap on how much file storage each user can
consume by uploading through your site. You set a maximum total upload size — either
per user role, or as an override on an individual user — and the module keeps a
running total of the file sizes each user has uploaded via Drupal forms. Once a
user reaches their limit, further uploads are blocked.

The problem it solves is uncontrolled storage growth. On any site where users can
upload files — profile images, documents, media — a handful of heavy users (or a
misbehaving one) can quietly fill the disk. Disk Quota gives you a fair, per‑user
or per‑role ceiling so storage stays predictable.

It is a modernised fork of the older *User Disk Quota* module, rewritten for
Drupal 10/11 (and 12) with PHP 8.3 support. One scope limitation is important to
understand up front: **only files uploaded through Drupal forms are counted.** Files
placed on the server by other means (FTP, direct copy, other tools) do not count
toward a user's quota. The module depends on Drupal core's **User** and **File**
modules, and it defines its own permissions for viewing and managing quotas.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set role‑based limits, grant
   permissions, and add per‑user overrides.

## Where it lives in the admin menu

Role‑based quota limits are configured at **Configuration → People → Account
settings → Disk Quota** (`/admin/config/people/accounts/disk-quota`). Permissions
live at **People → Permissions** (`/admin/people/permissions`), and per‑user
overrides are set on each user's edit page. See
[Configuration](configuration/index.md) for the details.
