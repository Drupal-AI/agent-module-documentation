# Config Preview Deploy — manual setup guide

**Config Preview Deploy** (`config_preview_deploy`) lets a team review configuration
differences on a **preview** environment and push the approved changes to **production**
as unified diff files — without needing console access on production. It builds on Drupal's
core **configuration checkpoint** API to produce a diff of the changes and applies that diff
to production safely, with the option to roll back to a checkpoint.

The typical flow: on the preview site you open a dashboard, inspect the pending
configuration changes, view a per‑config unified diff, optionally download the diff, and then
initiate a deployment to production. A **rebase** workflow lets you update the preview
environment's configuration with the latest production changes first, so you are deploying a
clean set. Production exposes an authenticated API that receives the diff and applies it.

Security is central to how it works. Trust between preview and production is established with
an **OAuth 2.0 authorization‑code flow** (via [Simple OAuth](https://www.drupal.org/project/simple_oauth)),
and inbound deploy payloads are additionally verified with a **hash and timestamp**. The
config‑reading and config‑writing endpoints on production are gated by a restricted
permission *and* OAuth2. It depends on core **System**, **Simple OAuth**, and
**[Key](https://www.drupal.org/project/key)** (Key stores the OAuth client secret), and works
on Drupal `^10.3 || ^11`.

Two things to keep in mind. The project is **under heavy development and testing** and its
code was largely AI‑authored (then reviewed and tested by the maintainer), so treat it as
young software and test thoroughly. And there is one intentionally **public** endpoint —
`GET /api/config-preview-deploy/status` — which returns only deployment *status*
information (low sensitivity) and never reads or writes configuration; the endpoints that
actually move configuration are properly locked down.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (with its
   Simple OAuth and Key dependencies).
2. [Configuration](configuration/index.md) — set up the settings, the OAuth trust between
   preview and production, and the permissions.

## Where it lives in the admin menu

The main dashboard is at **Configuration → Development → Config Preview Deploy**
(`/admin/config/development/config-preview-deploy`), with a settings form at
`/admin/config/development/config-preview-deploy/settings`
(`config_preview_deploy.settings`). Deploy, rebase, changes, per‑config diff, and download
actions live under the dashboard. Access is governed by the module's permissions — see
[Configuration](configuration/index.md).
