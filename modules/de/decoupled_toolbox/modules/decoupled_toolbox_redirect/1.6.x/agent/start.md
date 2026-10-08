<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox for Redirect (decoupled_toolbox_redirect) — agent index

Sub-module of **Decoupled Toolbox**. Adds a computed field exposing Redirect source paths for decoupled output. Package **Decoupled**. Core `>=8`. GPL-2.0-or-later. Version 1.6.0-rc0.

- Depends on: `redirect` (contrib), `decoupled_toolbox`.

## What it provides

- `hook_entity_base_field_info()` (in `decoupled_toolbox_redirect.module`) adds a computed base field **`redirect_source__path`** (string, unlimited cardinality, translatable, `setDisplayConfigurable('view', TRUE)`) to every entity type with a `canonical` link template.
- Field item list class `RedirectSourcePathFieldItemList` (`ComputedItemListTrait`): `computeValue()` queries `redirect` storage for redirects whose `redirect_redirect.uri` is `internal:/node/{id}` or `entity:node/{id}` in the current language, emitting each `getSourcePathWithQuery()` value.
- No routes, permissions, services, config, or Drush.

## Operate

Enable, then place `redirect_source__path` on the target bundle's **Decoupled** display with a decoupled formatter and a **Decoupled field key**. See parent [fields/formatters.md](../../../1.6.x/agent/fields/formatters.md).
