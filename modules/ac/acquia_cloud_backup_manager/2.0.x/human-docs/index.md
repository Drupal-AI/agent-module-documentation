# Acquia Cloud - Backup Manager — manual setup guide

**Acquia Cloud - Backup Manager** (`acquia_cloud_backup_manager`) applies a
retention policy to the **on-demand** (manual) backups on an Acquia Cloud
environment and deletes the ones that have aged out, automatically, on cron. Acquia
manages its scheduled backups on its own schedule, but on-demand backups — the ones
someone takes by hand before a risky deployment — pile up until a human removes
them. This module is that human: point it at an application and environment, choose
a retention rule, enable cron, and it prunes the rest through the Acquia Cloud API.

You choose one of two retention rules: **keep for N days** (delete on-demand backups
older than a set age) or **keep the newest N** (retain a fixed number of the most
recent on-demand backups and delete the rest). Cron-driven deletion is opt-in, so
installing the module does not start removing anything until you enable it.

Because it talks to the Acquia Cloud API, it needs Cloud API credentials — and those
credentials are not limited to this site. The Cloud API controls environments,
databases, deployments and environment variables for the **whole application**, so
they are among the highest-value secrets your site can hold. Supply them as
**environment variables**, never through the settings form — this is covered in
detail in [Configuration](configuration/index.md), and it matters.

> On Acquia Cloud Site Factory (ACSF), use the `acsf_backup_manager` module instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — supply credentials the safe way, pick
   a retention rule, and turn on cron.

## Where it lives in the admin menu

The settings form sits at **Configuration → Web services → Acquia Cloud → Backup
Manager** (`/admin/config/services/acquia-cloud/backup-manager`) and is gated by the
**Administer site configuration** permission.
