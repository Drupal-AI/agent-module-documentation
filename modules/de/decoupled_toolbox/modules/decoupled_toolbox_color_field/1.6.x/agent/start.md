<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox for Color Field (decoupled_toolbox_color_field) — agent index

Sub-module of **Decoupled Toolbox**. Makes Color Field compatible with Decoupled Toolbox. Package **Decoupled**. Core `>=8`. License GPL-2.0-or-later. Version 1.6.0-rc0.

- Depends on: `color_field`, `decoupled_toolbox`.

## What it provides

- One field formatter plugin **`decoupled_color_field`** (`ColorFieldDecoupledFormatter`, extends `GenericDecoupledFormatter`), `field_types` = `color_field_type`, in `src/Plugin/Field/FieldFormatter/ColorFieldDecoupledFormatter.php`.
- Adds an RGBA-output setting; `viewFieldItem()` emits the colour as a lowercased hex string, or as an `rgb()`/`rgba()` string when RGBA output is enabled (via `ColorHex::toString()` / `toRgb()`).
- Requires the contrib Color Field module. Extends `GenericDecoupledFormatter`.
- No routes, permissions, services, config, or Drush of its own.

## Operate

Enable (`drush en decoupled_toolbox_color_field -y`), then on the target bundle's **Decoupled** view display select the *Color Field* decoupled formatter for the color_field_type field and set a **Decoupled field key**. The value is serialized by the parent module's collection endpoint. See the parent [fields/formatters.md](../../../1.6.x/agent/fields/formatters.md) for the shared formatter model.
