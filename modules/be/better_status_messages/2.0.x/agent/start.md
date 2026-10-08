<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Status Messages (better_status_messages) — agent index

Restyles Drupal core's status/warning/error messages on **front-end (non-admin) pages** and adds a
per-message **close button**. Purely presentational — does not alter message text, generation, or access.
Version 2.0.2 (dir `2.0.x`). Core `^8 || ^9 || ^10 || ^11`. No non-core dependencies.

## What it provides
- **Theme hook** `status_messages__better` (`better_status_messages_theme()`, template
  `templates/status-messages--better.html.twig`) — a copy of core's status-messages template plus a close
  button and inline color styles.
- **Theme suggestion** `better_status_messages_theme_suggestions_status_messages_alter()` adds the
  `status_messages__better` suggestion **only when not an admin page** (helper
  `_better_status_messages_is_admin_page()`, which also treats `node/N/edit` and `taxonomy/term/N/edit` as admin).
- **Preprocess** `better_status_messages_preprocess_status_messages__better()` reads the 5 color values from
  config `better_status_messages.settings` (with hardcoded defaults) and passes them to the template.
- **Library** `better_status_messages/library` (`better_status_messages.libraries.yml`) — `css/better-status-messages.css`
  + `js/better-status-messages.js`; deps `core/jquery`, `core/drupal`. Attached from the template via `attach_library`.
- **JS behavior** `Drupal.behaviors.betterStatusMessages` — click on `#js-close-status-message` removes
  `#js-status-message` (the whole message wrapper).
- **Settings form** `Drupal\better_status_messages\Form\BetterStatusMessagesConfigForm` (`ConfigFormBase`).
- **Route** `better_status_messages.config` → `/admin/config/better_status_messages/config`,
  permission `administer site configuration`; menu link under Configuration > Development
  (`better_status_messages.links.menu.yml`).
- **Config object** `better_status_messages.settings` with 5 keys (no config/schema shipped, no config/install defaults).
- `hook_help()` for `help.page.better_status_messages`.

No permissions defined, no services, no plugins, no Drush, no submodules, no config schema.

## Solution docs
- Settings & config object → [agent/config/settings.md](config/settings.md)
- Rendering pipeline (theme hook, suggestion, template, JS/CSS) → [agent/theming/messages.md](theming/messages.md)
