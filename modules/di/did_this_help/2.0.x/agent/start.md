<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Did this help? (did_this_help) — agent index

A "Did this help?" Yes/No feedback block. Visitors answer Yes or No on any page; "No" reveals
a configurable reason list plus an "Other" option and a short free-text message. Responses are
stored per-page and reported through a Views page.

- **Machine name:** `did_this_help` · **Package:** Technocrat · **License:** GPL-2.0-or-later
- **Core:** `^10.1 || ^11 || ^12` · **Version dir:** 2.0.x (installed 2.0.8)
- **Dependencies:** Drupal core `views` (report View is shipped config). No Composer requirements.
- **Configure:** `did_this_help.settings` → `/admin/config/did_this_help/settings`

## What it provides
- **Block plugin** `did_this_help` (`src/Plugin/Block/DidThisHelpBlock.php`) — renders the AJAX
  feedback form; block build sets `#cache max-age 0`.
- **AJAX form** `DidThisHelpForm` (`src/Form/DidThisHelpForm.php`, form id `did_this_help_form`)
  — Yes / No / Send buttons; AJAX callback `sendAjaxForm()` writes a response row.
- **Settings form** `DidThisHelpSettingsForm` (ConfigFormBase) — edits `question` and `no_answers`.
- **Storage table** `did_this_help` (`did_this_help.install` `hook_schema`) — columns id, path,
  title, uid, choice, choice_no, message, created, ip_address. Not an entity; raw DB API.
- **Store helpers** in `did_this_help.module`: `_did_this_help_send_info()` (escapes + dedupes),
  `_did_this_help_row_exist/_update/_save()`.
- **Permissions** (`did_this_help.permissions.yml`): `administer did this help` (restricted),
  `view did this help reports`.
- **Views integration:** `DidThisHelpViewsHooks::viewsData()` (base table + fields), filter plugin
  `did_this_help` (`src/Plugin/views/filter/DidThisHelp.php`, extends `InOperator`), and the shipped
  report View `views.view.did_this_help` (page `/admin/reports/did-this-help`).
- **Hook services** (`did_this_help.services.yml`, autowired): `DidThisHelpHooks` (help, views_api),
  `DidThisHelpViewsHooks` (views_data). `.module`/`.views.inc` are `#[LegacyHook]` shims.
- **Library** `did_this_help/did_this_help` — `js/did-this-help.js` (jQuery/once toggle of the "No"
  panel) + `css/did-this-help.css`.

## Solution docs
- [Configuration & settings](agent/config/settings.md) — settings form, config object, schema, install defaults.
- [Feedback block & AJAX submit flow](agent/plugins/block-and-form.md) — block, form, buttons, storage.
- [Views integration & the feedback report](agent/views/views-integration.md) — report View, views data, filter plugin, permissions.
