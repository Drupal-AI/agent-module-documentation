<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transifex Connector (tmgmt_transifex) — agent index

TMGMT translator plugin for the **Transifex** localization platform. Version **2.1.0**. Core `^10.3 || ^11`. Depends on `tmgmt` (`>=1.19`, also declared in composer.json as `drupal/tmgmt:^1.19`).

Pushes one Transifex resource per TMGMT job item and pulls translations back through two entry points: a **Check for updates** button (reads resource stats) and a webhook route `/tmgmt_transifex_callback` (`TransifexController::callback`). The callback verifies the request against the translator's stored webhook secret and the expected `event`/`resource`/`language` payload shape before calling `updateJobWithTranslations`; it also gates on the event type and the *only reviewed* setting. Settings (`api` token, `project` URL, `secret`, `onlyreviewed`) live on the TMGMT translator entity; the API host defaults to `https://rest.api.transifex.com` and is overridable via `$settings['tmgmt_transifex.endpoint']`. See `ARCHITECTURE.md` in the module for the slug/key encoding and push/pull details.
