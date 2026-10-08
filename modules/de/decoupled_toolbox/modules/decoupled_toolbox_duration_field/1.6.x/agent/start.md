<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox for Duration Field (decoupled_toolbox_duration_field) — agent index

Sub-module of **Decoupled Toolbox**. Makes Duration Field compatible with Decoupled Toolbox. Package **Decoupled**. Core `>=8`. License GPL-2.0-or-later. Version 1.6.0-rc0.

- Depends on: `duration_field`, `decoupled_toolbox`.

## What it provides

- One field formatter plugin **`decoupled_duration_field`** (`DurationFieldDecoupledFormatter`, extends `GenericDecoupledFormatter`), `field_types` = `duration`, in `src/Plugin/Field/FieldFormatter/DurationFieldDecoupledFormatter.php`.
- `viewFieldItem()` returns the field's `duration` property value (the ISO-8601 duration string), or NULL when empty.
- Requires the contrib Duration Field module. Extends `GenericDecoupledFormatter`.
- No routes, permissions, services, config, or Drush of its own.

## Operate

Enable (`drush en decoupled_toolbox_duration_field -y`), then on the target bundle's **Decoupled** view display select the *Duration Field* decoupled formatter for the duration field and set a **Decoupled field key**. The value is serialized by the parent module's collection endpoint. See the parent [fields/formatters.md](../../../1.6.x/agent/fields/formatters.md) for the shared formatter model.
