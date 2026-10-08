<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Kit Redirect (decoupled_kit_redirect) — agent index

Submodule of **Decoupled Kit**. Adds a JSON:API resource that returns the Redirect-module redirect
matching a front-end path, with the destination alias in `meta`. Package **Decoupled Kit**.
Version **2.0.7** (doc dir `2.x`). Core `^10 || ^11 || ^12`. GPL-2.0-or-later.

- **Dependencies:** `decoupled_kit` (base service), contrib `redirect`.
- **Parent project:** [decoupled_kit](../../../2.x/agent/start.md).

## What it provides

- **JSON:API resource** `Drupal\decoupled_kit_redirect\Resource\Redirect` (extends
  `jsonapi_resources` `EntityResourceBase`). Route `decoupled_kit.redirect` at
  `%jsonapi%/decoupled_kit/redirect` (GET, `_access: TRUE`,
  `_jsonapi_resource_types: ['redirect--redirect']`). See [api/redirect.md](api/redirect.md).
- **Hook** `help` via `Drupal\decoupled_kit_redirect\Hook\DecoupledKitRedirectHooks` (autowired
  service, attribute + `#[LegacyHook]` wrapper).
- No config, no schema, no permissions, no Drush, no plugin types.

## Solution docs

- [api/redirect.md](api/redirect.md) — the Redirect resource: request contract, alias/internal-path
  resolution, entity lookup, and the `meta.alias` response.
