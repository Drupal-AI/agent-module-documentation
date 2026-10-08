<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Entity Share (eca_entity_share) — agent index

Bridges the **ECA** rules engine to **Entity Share** (JSON:API content syndication between Drupal
sites). It registers Entity Share's Symfony events as **ECA event plugins** so ECA models can start
on, read, and alter those events. Package `ECA`. License GPL-2.0-or-later. Core `^10.4 || ^11`,
PHP `>=8.1`. Requires `drupal/eca ^2.0 || ^3.0` and `drupal/entity_share ^3.0 || ^4.0`.

- **The two ECA event plugins, their derivatives, event classes and how to use them in a model** →
  [plugins/events.md](plugins/events.md)

## What it actually is

- A hidden top-level package holder (`eca_entity_share.info.yml`, `hidden: true`) with **no code**.
  All functionality lives in two hidden submodules:
  - **`eca_entity_share_client`** — depends on `eca:eca` and `entity_share:entity_share_client`.
  - **`eca_entity_share_server`** — depends on `eca:eca` and `entity_share:entity_share_server`.
- Each submodule provides one ECA **event** plugin (via ECA's `#[EcaEvent]` attribute + a deriver);
  no actions, conditions, services, routes, permissions, forms, or Drush commands.

## Plugins provided (from source)

- Client — `EntityShareClientEvent` (id **`entity_share_client`**), one derivative
  **`rel_field_value`** ("Entity share: Relationship Field Value") wrapping
  `Drupal\entity_share_client\Event\RelationshipFieldValueEvent`
  (`entity_share_client.relationship_field_value`), fired during import.
- Server — `EntityShareServerEvent` (id **`entity_share_server`**), one derivative
  **`rel_field_value`** ("Entity share: Channel list prepared") wrapping
  `Drupal\entity_share_server\Event\ChannelListEvent` (`entity_share_server.channel_list`),
  fired while building the channel list.

## Config schema

- Config-schema entries only, for the ECA event-plugin config keys:
  `eca.event.plugin.entity_share_client:rel_field_value` and
  `eca.event.plugin.entity_share_server:rel_field_value` (both `type: eca.event.plugin`).
  No settings form and no `config/install` defaults.

## Notes

- The actual sync (remote HTTP, OAuth, channel access) is owned by **Entity Share**, not this module.
  This module only orchestrates it from ECA and holds no access-control role of its own.
