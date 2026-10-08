<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Badgr Badge (badgr_badge) — agent index

Bridge between Drupal and the badgr.com (Badgr / Open Badges) API. An admin connects
one Badgr account (email + password → OAuth tokens), imports its issuers and badge
classes into Drupal nodes, and logged-in users add earned badges to their Badgr Backpack.

- **Core**: `^10 || ^11`. **Dependencies**: `node`, `file` (core). No composer deps, no submodules.
- **Package**: Badgr Badge. **License**: GPL-2.0-or-later. **Configure route**: `badgr_badge.badgr_config_form`.
- Status on drupal.org: unsupported / obsolete, not security-advisory-covered.

## What it provides

- **Content types** (created at install): `badgr_account` (holds tokens + email), `badgr_issuer`
  (imported organizations), `badgr_badges` (imported badge classes). Plus their fields, form/view
  displays, and the `views.view.badgr_badges` view (page at `/badgr-badges`).
- **Config object**: `badgr_badge.badgrconfig` (single key `badgr_email`; schema in
  `config/schema/badgr_badge.schema.yml`). The password is never persisted.
- **Services**: `badgr_badge.service` (`BadgrService` — all Badgr REST calls) and
  `badgr_badge.helpers` (`BadgrHelpers` — maps API data ↔ nodes, image handling).
- **Routes**: `badgr_badge.badgr_config_form` (`/admin/config/system/badgr-badge`, perm
  `administer badgr badge`) and `badgr_badge.addtobackpack`
  (`/badgr/addtobackpack/{badge}/{acheived_date}/{nojs}`, perm `access content`).
- **Permissions**: `administer badgr badge`, `create badgr badge`
  (`badgr_badge.permissions.yml`).
- **Hooks** (`badgr_badge.module`): `hook_node_view()` adds the AJAX "Add to Backpack" link to
  `badgr_badges` teasers; `hook_theme()` (`badgr_badge` element); `hook_preprocess_node()`;
  `hook_help()`.

## Solution docs

- [Configuration & connecting an account](config/settings.md) — config form, tokens, import flow.
- [Badgr API service](api/service.md) — `BadgrService` methods, endpoints, token refresh.
- [Content model & backpack award flow](content/model.md) — the three node types, fields, the
  `addtobackpack` route/controller, and `BadgrHelpers`.
