<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eca_message: the hook + access handler, and driving it from ECA

This is the whole module. There are two source files of substance.

## `eca_message.module` — the alter hook

`eca_message_entity_type_alter(array &$entity_types)` runs once at entity-type build and does a
single thing:

```
$entity_types['message']
  ->setHandlerClass('access', 'Drupal\eca_message\MessageAccessControlHandler');
```

It replaces the `message` content entity's `access` handler with the module's own class. The Message
module (`drupal/message`) does not declare a custom `access` handler in its `@ContentEntityType`
annotation, so before this module the `message` type used core's default
`\Drupal\Core\Entity\EntityAccessControlHandler`. After enabling `eca_message`, all access checks on
`message` entities route through `MessageAccessControlHandler` instead.

## `src/MessageAccessControlHandler.php`

`class MessageAccessControlHandler extends \Drupal\Core\Entity\EntityAccessControlHandler`.

- It overrides only `createAccess($entity_bundle, AccountInterface $account, array $context, $return_as_object)`
  so that ECA workflows can create `message` entities (the reason the module exists). This is the
  module's plug-and-play create-access shim.
- It does **not** override `checkAccess()` (view/update/delete), so those operations keep core's
  default behaviour, which honours the `message` entity type's `admin_permission = "administer messages"`.

No other methods, no config, no services.

## How to create Message entities from ECA (the actual workflow)

`eca_message` provides **no ECA event/condition/action plugins**. You create Messages with the
generic actions that ship in **ECA Content** (part of the `eca` project):

1. Enable `eca`, `eca_content`, `message`, and `eca_message`, plus at least one **message template**
   (`message_template` config entity, created at *Admin → Structure → Message templates*).
2. In an ECA model, respond to an event (e.g. an entity-insert event, or a custom event).
3. Add ECA Content's **"Create a new entity"** action, entity type `message`, bundle = your message
   template machine name; set any token/argument/field values.
4. Add ECA Content's **"Save entity"** action for that token, or use a create-and-save action.

Because `eca_message` supplies the create-access handler, those generic ECA actions succeed against
the `message` type. Without it, message creation from ECA is blocked by the entity type's default
create-access policy.

## What it is NOT (adversarial notes)

- No `src/Plugin/**` — nothing named `eca_message.*` appears in ECA's event/condition/action lists.
- No settings form, `configure` route, permissions, config schema/objects, or `.install`.
- Maintainer-declared **temporary** shim until ECA core absorbs the feature
  (drupal.org/project/eca/issues/3375899).
