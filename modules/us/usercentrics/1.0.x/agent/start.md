<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Usercentrics Consent Management Platform (usercentrics) — agent index

Integrates the hosted **Usercentrics CMP** (commercial consent platform) and, more importantly,
**defers scripts/attachments/libraries until consent**. Version **1.0.2**. Package *User interface*.
Core `^10.1 || ^11`. No non-core module dependencies (`suggests` Media oEmbed Provider Markup).
Configure route: `usercentrics.admin`.

## What it provides

- **1 config entity type** `usercentrics_app` (a "Data Processing Service" / DPS) —
  `src/Entity/UsercentricsApp.php`. Each app lists the `javascripts` (src substrings),
  `attachments` (page-attachment ids) and `libraries` (asset-library names) it gates, plus
  `uc_id`, `status`, `weight`. Ships 5 disabled defaults: `google_analytics`,
  `google_analytics_4`, `google_tag_manager`, `matomo`, `matomo_self_hosted`.
- **1 config object** `usercentrics.settings` (settings_id, enabled, SDP, TCF, toggle button,
  exclude/disable URL regexes, the three `auto_decorate_*` switches, debug). Schema in
  `config/schema/usercentrics.schema.yml`.
- **1 service** `usercentrics.helper` → `Utility/UsercentricsHelper` (enabled/access checks,
  loads apps, URL-pattern matching, debug logging).
- **1 service override**: `UsercentricsServiceProvider` swaps core's `asset.js.collection_renderer`
  for `UsercentricsJsCollectionRenderer` — this is what actually stamps `type="text/plain"` +
  `data-usercentrics` onto aggregated/library JS. **Read it before assuming a script is gated.**
- **Hooks** in `usercentrics.module`: `hook_page_attachments` (injects the CMP + SDP loader
  scripts), `hook_js_alter`, `hook_page_attachments_alter`, `hook_library_info_alter`,
  `hook_module_implements_alter` (forces its alters to run last).
- **2 routes**, both `_permission: 'administer usercentrics'`:
  `usercentrics.admin.order_form` (`/admin/config/user-interface/usercentrics`, DPS ordering table)
  and `usercentrics.admin` (`/admin/config/user-interface/usercentrics/settings`, `SettingsForm`).
  Plus core entity routes for `usercentrics_app` (collection/add/edit/delete under
  `/admin/config/user-interface/usercentrics/apps`).
- **2 permissions**: `administer usercentrics` (**`restrict access: true`**) and `use usercentrics`
  (lets a visitor operate the consent UI; grant to `anonymous` for public sites).
- **1 asset library** `usercentrics/ui` (floating "Manage consents" button, `js/usercentrics.js`).

## Solution docs

- **Settings form + `usercentrics.settings` config keys, URL patterns, enable/access logic, CMP
  script injection** → [config/settings.md](config/settings.md)
- **The `usercentrics_app` DPS config entity: fields, forms, ordering, shipped apps** →
  [entities/dps-app.md](entities/dps-app.md)
- **How consent gating actually works (the 4 hooks + renderer swap + SDP)** →
  [api/consent-gating.md](api/consent-gating.md)

## Scope boundary worth stating to users

Only scripts modelled by an enabled `usercentrics_app` (matched by library name, src substring or
attachment id), or auto-blocked by Smart Data Protection, are deferred. A tag hard-coded in a
theme template, or added by a module in a way none of the four match paths catch, is emitted and
executed normally. Adding a tracker without a matching DPS yields a banner that claims more than
it enforces — verify with the browser inspector / debug mode.
