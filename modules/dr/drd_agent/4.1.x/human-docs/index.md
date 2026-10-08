<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD Agent — manual setup guide

**DRD Agent** (`drd_agent`) is the piece you install on a remote Drupal site so a
central **Drupal Remote Dashboard (DRD)** can manage it. Once installed and
authorized, the dashboard can securely run maintenance and monitoring tasks on the
site over encrypted HTTP — running cron, flushing caches, toggling maintenance
mode, applying core/contrib and translation updates, collecting project and
available-update information, pulling error logs, and more — without anyone needing
SSH access to each site.

The agent is designed to be driven by the DRD portal, not clicked through by a
human. It exposes a small set of endpoints the dashboard calls; every request is
encrypted (OpenSSL or TLS) and authenticated (shared secret or username/password).
When a dashboard authorizes itself, its credentials are stored in Drupal's State
system, not in exported configuration. It can also reach sites hosted on
**Acquia**, **Pantheon**, and **Platform.sh** through built-in provider
authentication plugins, and developers can add support for other hosts.

On the site itself there is almost nothing to configure — just a single **Debug
mode** toggle and the one-time step of authorizing your dashboard. To get more out
of it, the module suggests also installing **Monitoring**, **Security Review**, and
**Hacked!**, whose data the agent can then surface to the dashboard.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — authorize your DRD dashboard, the
   Debug mode setting, and the Drush setup command.

## Where it lives in the admin menu

The (very small) settings form is at **Configuration → System → DRD Agent**
(`/admin/config/system/drd`), which requires the **Administer site configuration**
permission. The dashboard-facing endpoints (`/drd-agent`, `/drd-agent-authorize`,
and related) are called by DRD, not visited by hand.

## How to use it

1. Install and enable the module on the site you want to manage (see
   [Installation](installation/index.md)).
2. Add the site in your DRD portal, then authorize the connection — either through
   the authorize form or with the `drush drd:agent:setup <token>` command (see
   [Configuration](configuration/index.md)).
3. From then on, manage the site from the DRD dashboard.
