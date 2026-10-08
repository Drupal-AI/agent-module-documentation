<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Business Identity (business_identity) — agent index

Central admin config for an organization's identity — name, contact, address, legal/VAT,
opening hours, social links — plus a display **block** and **tokens**. Package `Business`.
Depends only on core **`system`** and **`config`**. Core `^11 || ^12`. PHP 8.1. License
GPL-2.0-or-later. Version 1.0.2. All data lives in one config object,
**`business_identity.settings`** (config_object; schema in `config/schema/`, install defaults
in `config/install/`). No entities, no database tables, no external HTTP.

- **The settings form, routes, permission, config keys** → [config/settings.md](config/settings.md)
- **The display block + Twig template** → [block/business-identity-block.md](block/business-identity-block.md)
- **Manager service, Twig extension, tokens, tab plugin type, hooks** → [api/services-and-extension.md](api/services-and-extension.md)
- Country submodules: [../modules/business_identity_local_de/1.0.x/agent/start.md](../modules/business_identity_local_de/1.0.x/agent/start.md) ·
  [../modules/business_identity_local_it/1.0.x/agent/start.md](../modules/business_identity_local_it/1.0.x/agent/start.md)

## What it actually is (from source)

- **Two routes** (`business_identity.routing.yml`), both requiring permission
  **`administer business identity`** (`business_identity.permissions.yml`, `restrict access: true`):
  - `business_identity.settings` → `/admin/config/business/identity` → `Form\BusinessIdentityForm`
    (the real, large config form; `configure` route in the .info.yml).
  - `business_identity.test_form` → `/admin/config/system/business-identity/test` → `Form\TestForm`
    (a trivial scratch form).
- **One block plugin**: `business_identity_block` (`Plugin\Block\BusinessIdentityBlock`), category
  *Business*, rendered by `templates/block--business-identity.html.twig`.
- **One plugin type**: `business_identity_tab` — manager `plugin.manager.business_identity_tab`
  (annotation `Annotation\BusinessIdentityTab`, interface `Plugin\BusinessIdentityTabInterface`,
  base `Plugin\BusinessIdentityTabBase`); one plugin ships, `BasicInfoTab`. This plugin type is
  **not** actually consumed by `BusinessIdentityForm` (which builds its own tabs) — it is scaffolding.
- **Services** (`business_identity.services.yml`): the tab plugin manager and
  `business_identity.tab_manager` (`Service\TabManager`, a large legacy form-builder helper not
  called by the shipped form).
- **Two country submodules** under `modules/` add a "Local Laws" tab through the hooks
  `hook_business_identity_local_laws`, `_fields`, `_tokens`, `_validate` (invoked by
  `BusinessIdentityForm`), documented in their own trees.

## Notable caveats (grounded in source, not security issues)

- There is **no top-level `.module` file**. `business_identity.tokens.yml` declares a `business`
  token type but the base module ships **no working `hook_tokens` implementation**; the
  `BusinessIdentityServiceProvider` tags `Token\BusinessIdentityToken` as `token_info`, and the
  `Twig\BusinessIdentityTwigExtension` / `BusinessIdentityManager` are **not registered in
  services.yml** — so base-module tokens and `business_*()` Twig functions are effectively
  inert unless separately wired. (The DE/IT submodules DO implement real `hook_tokens`.)
- `business_identity.libraries.yml` is **empty**, yet the form/block attach libraries like
  `business_identity/vertical_tabs`, `business_identity/block`, `business_identity/parking-map` —
  those references resolve to nothing.
- `Controller\BusinessIdentityController::jsonLd()` builds schema.org `LocalBusiness` JSON-LD but
  is **not referenced by any route** — dead code.
- The shipped form reads/writes many keys (e.g. `legal_legal_name`, `address_business_address_address`,
  `reviews_*`) that **do not match** the keys the block/manager/config-schema read
  (`legal_name`, `address`, …); much of the persisted data is not what the block displays.

## Access & data model

Both routes are admin-only (`administer business identity`, restricted). The form is a
`ConfigFormBase` editing `business_identity.settings` (and mirroring, read-only, some
`system.site` / `system.date` values). The block publicly renders admin-entered identity values
through an autoescaping Twig template — that public display is the module's intended purpose.
