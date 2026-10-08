<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confirm Unpublish (confirm_unpublish) — agent index

Shows a JavaScript confirmation dialog when an editor un-checks **Published** on a node edit form,
so taking a page offline is a deliberate act rather than a stray checkbox. Mechanism:
`confirm_unpublish_form_node_form_alter()` (a `hook_form_node_form_alter` in the `.module`) attaches
the `confirm_unpublish/confirm_unpublish` library and a `drupalSettings.confirm_unpublish` payload to
every node form. `js/confirm_unpublish.js` (`Drupal.behaviors.confirmUnpublish`) watches the
`status[value]` checkbox; when it goes checked→unchecked it opens a core jQuery-UI dialog
(`core/drupal.dialog`) with Cancel/Confirm. **Cancel re-checks the box; Confirm just closes the
dialog** — the guard is advisory, it never blocks the actual form submit. On Confirm, if logging is
on, the JS `POST`s `uid`/`nid` to the controller route `confirm_unpublish.log`
(`/confirm-unpublish/log`) which writes a `notice` to the `confirm_unpublish` logger channel (dblog).

The only admin surface is one settings form at `/admin/config/content/confirm-unpublish`
(`ConfirmUnpublishSettingsForm`): the dialog message (a text_format field), a logging toggle, and a
per-content-type exclusion list. **Note the real behavior of the exclusion list**: the dialog only
attaches when the exclusion list is **non-empty** and the current bundle is **not** in it — with the
default empty list the dialog is attached to **no** content type (see configure/settings.md). Node
entities only; no other entity type is covered.

- Depends on: `drupal:node` (core). No other module dependencies, no composer `require`.
- Core: `^10.2 || ^11`. Package: `Other`. Version **1.0.6**.
- Has a settings page / `configure` route: **yes** — `confirm_unpublish.settings`.
- Permissions: **yes** — one: `administer confirm unpublish settings` (gates the settings form only).
- Drush: none. Plugin types: none. Config schema: **none shipped** (only `config/install` defaults).
- No hook_help, no update hooks, no `.install`, no services file, no tests.

## What you'd do → where

- **Change the confirmation message, the logging toggle, or exclude content types** →
  [configure/settings.md](configure/settings.md)
- **Understand how the dialog is wired, what `drupalSettings` it uses, and the `/confirm-unpublish/log`
  endpoint / logger** → [api/mechanism.md](api/mechanism.md)

## Key facts (real machine names)

- Routes: `confirm_unpublish.settings` (`/admin/config/content/confirm-unpublish`, `_permission:
  administer confirm unpublish settings`, form `ConfirmUnpublishSettingsForm`);
  `confirm_unpublish.log` (`/confirm-unpublish/log`, `_access: 'TRUE'`, controller
  `Drupal\confirm_unpublish\Controller\ConfirmUnpublishController::log`).
- Hook: `confirm_unpublish_form_node_form_alter()` — implements `hook_form_node_form_alter`.
- Form: `Drupal\confirm_unpublish\Form\ConfirmUnpublishSettingsForm` (form id
  `confirm_unpublish_settings_form`, extends `ConfigFormBase`).
- Permission: `administer confirm unpublish settings`.
- Config object: `confirm_unpublish.settings` — keys `alert_text` (string, HTML), `alert_text_format`
  (filter format, default `basic_html`), `logging` (int/bool, default `1`), `allowed_content_types`
  (map, default empty; semantically an *exclusion* list).
- Library: `confirm_unpublish/confirm_unpublish` (`js/confirm_unpublish.js`; deps `core/drupal`,
  `core/drupal.dialog`, `core/drupalSettings`, `core/jquery`).
- `drupalSettings.confirm_unpublish`: `message`, `logging`, `user_id`, `node_id`.
- JS: `Drupal.behaviors.confirmUnpublish`, watches `input[name="status[value]"]`.
- Menu link: `confirm_unpublish.settings` (parent `system.admin_config_content`).
- Logger channel: `confirm_unpublish`.
