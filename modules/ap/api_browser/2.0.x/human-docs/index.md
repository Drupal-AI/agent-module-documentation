<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Project Browser API Browser — manual setup guide

**Project Browser API Browser** (`api_browser`) extends Drupal core's **Project
Browser** so that a Project Browser can list and install items sourced from
arbitrary external API endpoints — not just from drupal.org. That makes it useful
for private module registries or curated in-house catalogs: you point a browser at
your own API, and its items show up in the familiar Project Browser interface.

The external API endpoints and any credentials they need are configured by an
administrator and should be stored securely (ideally backed by environment
variables rather than committed to config). Administration is gated by the
**`administer api_browser_service`** permission, so only trusted roles can add or
change the API-backed sources.

The module depends on core's **Project Browser** and targets Drupal 11.2 and
newer (it also declares support for Drupal 12). It is a fairly new, beta-stage
project, so the documentation available for it is thin — the notes here describe
what the module is for; consult the project page for the current UI specifics.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   Project Browser module) and enable it.

## How to use it

Once enabled, the module adds external-API-backed sources to Project Browser. An
administrator with the `administer api_browser_service` permission configures the
external endpoint(s) and credentials, after which those sources appear as
selectable Project Browsers alongside the default drupal.org source. Keep any API
credentials in environment variables or another secure store rather than in
exported configuration, and grant the administration permission only to trusted
roles.
