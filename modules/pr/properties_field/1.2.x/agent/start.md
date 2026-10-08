<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Properties Field — agent index

Adds one field type, `properties`: an unlimited-cardinality list of typed **machine_name + label + type + value** rows on any fieldable entity. Version **1.2.0**. Core `^9 || ^10 || ^11`.

No admin settings page, no permissions, no Drush. You operate it entirely by adding/configuring the field on a bundle. Values are content — if you emit them elsewhere, escape them (the shipped formatters/template already autoescape).

- [Configure the field, widget & formatters](configure/field.md) — plugin IDs, widget/formatter settings, storage schema, the unique constraint.
- [Value types & adding your own](plugins/value-types.md) — the 5 built-in `@PropertiesValueType` plugins and how to write a new one.
