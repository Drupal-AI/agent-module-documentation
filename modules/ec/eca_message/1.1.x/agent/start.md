<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Message (eca_message) — agent index

A minimal "plug & play" bridge that lets **ECA** models create **Message** module entities.
It ships **no ECA plugins of its own** — instead it re-points the `message` entity type's
**access handler** so ECA's generic *Create/Save entity* actions (from ECA Content) can build and
save Message entities. Package `Custom`. Depends on `eca`, `message`. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version-dir 1.1.x (release 1.1.0).

- **What the module actually contains, the hook, the access handler, and how to drive it from ECA** →
  [api/access-handler.md](api/access-handler.md)

## What it actually is (from source)

- `eca_message.info.yml`: `type: module`, deps `eca:eca` + `message:message`, no `configure` route.
- `eca_message.module`: one hook, `eca_message_entity_type_alter()`, which calls
  `$entity_types['message']->setHandlerClass('access', 'Drupal\eca_message\MessageAccessControlHandler')`.
- `src/MessageAccessControlHandler.php`: `MessageAccessControlHandler extends`
  core `EntityAccessControlHandler`; overrides `createAccess()`.
- **No** `*.services.yml`, `*.routing.yml`, `*.permissions.yml`, `*.links.*.yml`, `config/`,
  `*.install`, `composer.json`, JS/CSS, Drush commands, or `src/Plugin/**` — so no ECA
  events/conditions/actions, no config objects/schema, no permissions are provided by this module.

## How message creation actually happens

The Message entities are created by **ECA + ECA Content's** own generic entity actions, not by this
module. `eca_message` only replaces the Message access handler so those create actions succeed. It is
a documented temporary shim until ECA core gains the capability (drupal.org issue 3375899).

## Notes / caveats

- Adversarial check vs. the old stub: the module does **not** provide "ECA actions"/events. Any doc
  or model that references an `eca_message`-provided action plugin is wrong — build Messages with
  ECA Content's *Create entity* / *Save entity* actions targeting the `message` entity type.
- No settings form / no `configure` route; nothing to configure. Enable and use from ECA.
