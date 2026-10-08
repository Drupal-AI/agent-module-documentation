<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA event plugins

`eca_entity_share` contributes **two ECA event plugins**, one per submodule. Each declares a single
derivative that maps an Entity Share Symfony event onto ECA, using ECA's `#[EcaEvent]` attribute and
an `EventDeriverBase` subclass. There are no actions or conditions — you pair these events with
ECA's generic conditions/actions in a model.

## Install / enable

- `ddev drush en eca_entity_share_client -y` — for the client (import-side) event.
- `ddev drush en eca_entity_share_server -y` — for the server (channel-list) event.
- Enabling either pulls in `eca` and the matching Entity Share submodule (see each
  `*.info.yml`). The umbrella `eca_entity_share` module is hidden and need not be enabled directly.

## Client event — `entity_share_client`

- Class `Drupal\eca_entity_share_client\Plugin\ECA\Event\EntityShareClientEvent`
  (`modules/client/src/Plugin/ECA/Event/EntityShareClientEvent.php`), deriver
  `EntityShareClientEventDeriver` in the same namespace.
- `definitions()` returns one derivative:
  - **`rel_field_value`** — label *"Entity share: Relationship Field Value"*,
    `event_name` = `RelationshipFieldValueEvent::EVENT_NAME`
    (`entity_share_client.relationship_field_value`),
    `event_class` = `Drupal\entity_share_client\Event\RelationshipFieldValueEvent`.
- The base event (in the `entity_share_client` module) is dispatched while importing an entity's
  relationship (entity-reference) field. Its public API:
  - `getField()` → the `FieldItemListInterface` being processed.
  - `getFieldValue()` / `setFieldValue(array)` → read or **alter** the array of field values that
    Entity Share will apply. An ECA action that writes back to the event can therefore rewrite the
    imported reference value.
- `version_introduced: '1.0.0'`.

## Server event — `entity_share_server`

- Class `Drupal\eca_entity_share_server\Plugin\ECA\Event\EntityShareServerEvent`
  (`modules/server/src/Plugin/ECA/Event/EntityShareServerEvent.php`), deriver
  `EntityShareServerEventDeriver` in the same namespace.
- `definitions()` returns one derivative (note: the array key is `rel_field_value`, but it maps to
  the channel-list event):
  - **`rel_field_value`** — label *"Entity share: Channel list prepared"*,
    `event_name` = `ChannelListEvent::EVENT_NAME` (`entity_share_server.channel_list`),
    `event_class` = `Drupal\entity_share_server\Event\ChannelListEvent`.
- The base event (in the `entity_share_server` module) is dispatched while the server builds the list
  of channels it advertises. Its public API:
  - `getChannelList()` / `setChannelList(array)` → read or replace the channel-list array.
  - `addChannel($channel_name, array $channel_definition)` → append a channel (no-op if it already
    exists).
- `version_introduced: '1.0.0'`.

## Config schema

Both derivatives carry ECA's generic event-plugin config type. Schema (in each submodule's
`config/schema/*.schema.yml`):

- `eca.event.plugin.entity_share_client:rel_field_value` → `type: eca.event.plugin`.
- `eca.event.plugin.entity_share_server:rel_field_value` → `type: eca.event.plugin`.

There is no settings form, no `config/install` default config, and no per-plugin fields beyond what
`eca.event.plugin` defines. Event configuration is done inside the ECA model, not on a module screen.

## Using in an ECA model

1. Create an ECA model (Modeller UI or config) and add a **Start event**.
2. Pick *Entity share: Relationship Field Value* (client) or *Entity share: Channel list prepared*
   (server) as the event.
3. Add ECA conditions/actions. To alter data, use an action that sets the event's value — the field
   value array on the client event, or the channel list on the server event — so the change is
   carried back into Entity Share's normal processing.

## Boundaries

- This module contributes only the event definitions above; it performs **no** HTTP requests, holds
  **no** credentials, defines **no** routes/permissions, and adds **no** access checks. The remote
  sync, OAuth/authentication, and channel access are all handled by the base **Entity Share** module.
