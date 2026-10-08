<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Toolbar Messages (admin_toolbar_messages) — agent index

Splits Drupal's status/warning/error messages out of the page's message region and displays them in
the **classic Toolbar** or the **Navigation top bar** (Drupal 11) — but only messages raised **while
on an admin route**, and only once the user is on a **non-admin (front-end)** page. Version
**1.0.4** (dir `1.0.x`), core `^10.3 || ^11`, PHP `>=8.1`. No config, no permissions, no routes,
no Drush commands, no config schema. Pure service decoration.

## What it provides

- **Service decorator** `Drupal\admin_toolbar_messages\AdminAwareMessenger` — decorates the core
  `messenger` service. See `agent/api/messenger-decorator.md`.
- **Trusted lazy-builder** `AdminToolbarMessagesBuilder::build()` (`#[TrustedCallback]`) — renders
  the queued admin messages into the toolbar/top-bar placeholder.
- **Hook services** (OOP `#[Hook]` attributes, wired in `services.yml`): `Hook\ToolbarHooks`
  (`hook_toolbar` — right-aligned tab, weight 1100), `Hook\ThemeHooks` (`hook_theme` +
  `hook_library_info_alter`).
- **Navigation plugin** `Plugin/TopBarItem/AdminMessagesTopBarItem` — Drupal 11 `#[TopBarItem]`
  (`region: Actions`, label "Administrative Status Messages").
- **Theme hook** `status_messages__admin_toolbar_messages` (base hook `status_messages`) +
  `templates/status-messages--admin-toolbar-messages.html.twig` (collapsible pure-CSS drawer).
- **Libraries** `admin_toolbar_messages/toolbar` and `admin_toolbar_messages/navigation` (CSS only).

## Dependencies / relationships

- **No hard dependency** in `.info.yml` — `toolbar` and `navigation` are **test** dependencies
  only; `composer.json` requires just `drupal/core`. No dependency on `admin_toolbar`.
- Renders nothing unless the classic **Toolbar** or the core **Navigation** module is present.
  Works well alongside `admin_toolbar` and `gin_toolbar`.

## Solution docs

- `agent/api/messenger-decorator.md` — the `AdminAwareMessenger` API, the admin/non-admin split,
  the builder, and the toolbar/navigation integration points.

## Notes for agents

- The whole point is the admin-route → non-admin-route split; "moves all status messages to the
  toolbar" is an oversimplification. On admin pages the messages still print inline.
- No settings form and no `configure` route — nothing to point a user at in the admin UI.
- Accessibility caveat: relocating messages into a collapsible drawer can weaken the `aria-live`
  announcement and separate an error from the field that caused it.
