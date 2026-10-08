<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eulerian (eulerian) — agent index

Adds the **Eulerian** analytics JavaScript tag to the pages you choose and builds a
`drupalSettings.eulerian.datalayer` that the tag pushes to Eulerian with `EA_push()`. Package
`Statistics`. Depends only on core **`path_alias`**. Core `^10.3 || ^11`. License GPL-2.0-or-later.
Version 1.1.0. Everything runs client-side; the module makes **no server-side outbound HTTP calls**.

## Solution docs

- **Install, the settings form, config object + schema, permissions, visibility, custom parameters,
  site search** → [config/settings.md](config/settings.md)
- **The datalayer, page attachments, events JS, `data-eulerian-*` link tracking, Colorbox** →
  [api/datalayer.md](api/datalayer.md)
- **The Views display extender (search keys + Search API facets)** →
  [plugins/views_display_extender.md](plugins/views_display_extender.md)
- **The three Commerce submodules** → documented in their own trees:
  `eulerian_commerce_product`, `eulerian_commerce_cart`, `eulerian_commerce_checkout`
  (under `modules/eu/eulerian_commerce_*/1.1.x/`).

## What it provides

- **Config object** `eulerian.settings` (schema `config/schema/eulerian.schema.yml`, defaults in
  `config/install/eulerian.settings.yml`).
- **Route** `eulerian.settings_form` → `/admin/config/system/eulerian`, permission
  `administer eulerian` (`\Drupal\eulerian\Form\SettingsForm`, `ConfigFormBase`).
- **Permissions** (`eulerian.permissions.yml`): `administer eulerian`;
  `use php for eulerian tracking visibility` (`restrict access: true`).
- **Services**: `eulerian.helper` (`Services\EulerianHelper` — `cleanString()`,
  `generateUserIdentifierHash()`), `eulerian.visibility` (`Services\EulerianVisibility` —
  `isEnabledOnCurrentPage()`), and the OOP hook class `Hook\EulerianHooks`.
- **Hooks** (attribute-based, `Hook\EulerianHooks`): `help`, `page_attachments` (builds the
  datalayer + attaches libraries), `views_post_render` (delegated to
  `HookHandler\ViewsPostRenderHookHandler`). `hook_install`/`hook_uninstall`/`hook_requirements`
  in `eulerian.install` register/remove the `eulerian` Views display extender and warn when no
  domain is configured.
- **Views plugin**: display extender `Eulerian` (id `eulerian`,
  `Plugin/views/display_extender/Eulerian.php`).
- **JS libraries** (`eulerian.libraries.yml`): `init`, `events`, `tools`, `colorbox`
  (`js/*.js`). Interface constants in `EulerianInterface` (`ATTR_PREFIX = 'data-eulerian-'`,
  tracking-mode constants `all`/`listed`/`php`).

## Key facts

- The Eulerian **domain** (`track.domain`) is not a secret — it is embedded in the client tag and
  visible to every visitor. It is stored as plain config (no Key/env/getenv involved, and none is
  needed).
- `generateUserIdentifierHash()` returns `Crypt::hmacBase64($uid, privateKey . hashSalt)` — a
  stable, non-reversible, non-PII identifier.
- The settings form maintains a **forbidden-token blocklist** (`TOKEN_FORBIDDEN_LIST`) that rejects
  PII tokens (`:mail]`, `:uid]`, `user:name]`, `:ip-address]`, …) in custom parameters.
- Standard analytics/consent caveat: it sends visitor/search/behaviour data to Eulerian — obtain
  consent and integrate a cookie-consent solution as your policy requires.
