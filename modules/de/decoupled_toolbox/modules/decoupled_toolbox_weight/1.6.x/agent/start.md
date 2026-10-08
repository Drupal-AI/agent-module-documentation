<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Toolbox for Weight (decoupled_toolbox_weight) — agent index

Sub-module of **Decoupled Toolbox**. Makes Weight compatible with Decoupled Toolbox. Package **Decoupled**. Core `>=8`. License GPL-2.0-or-later. Version 1.6.0-rc0.

- Depends on: `decoupled_toolbox`, `weight`.

## What it provides

- One field formatter plugin **`decoupled_weight`** (`WeightDecoupledFormatter`, extends `GenericDecoupledFormatter`), `field_types` = `weight`, in `src/Plugin/Field/FieldFormatter/WeightDecoupledFormatter.php`.
- `viewFieldItem()` casts the weight value to an integer (`(int) $item->getString()`).
- Requires the contrib Weight module. Extends `GenericDecoupledFormatter`.
- No routes, permissions, services, config, or Drush of its own.

## Operate

Enable (`drush en decoupled_toolbox_weight -y`), then on the target bundle's **Decoupled** view display select the *Weight* decoupled formatter for the weight field and set a **Decoupled field key**. The value is serialized by the parent module's collection endpoint. See the parent [fields/formatters.md](../../../1.6.x/agent/fields/formatters.md) for the shared formatter model.
