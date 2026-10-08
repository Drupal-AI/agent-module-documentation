<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building a Child Entity type

Child Entity ships no entity types — you wire one up in a custom module.

## Requirements on your entity type
- Implement `\Drupal\child_entity\Entity\ChildEntityInterface`.
- `use \Drupal\child_entity\ChildEntityTrait;`.
- Declare a `parent` entity key in `entity_keys` (`'parent' => '<parent_entity_type_id>'`).
- Call `self::childBaseFieldDefinitions($entity_type)` from `baseFieldDefinitions()` to add the read-only `parent` entity_reference field.

## Handlers to register in the annotation
- `access = "Drupal\child_entity\ChildEntityAccessControlHandler"`
- `route_provider[html] = "Drupal\child_entity\Routing\ChildContentEntityHtmlRouteProvider"`
- Permission callback in `<module>.permissions.yml`:
  `permission_callbacks: [ '\Drupal\child_entity\ChildEntityPermissions::generatePermissions' ]`

## What you get
- All entity routes are re-pathed under the parent's canonical (or edit) link template.
- The parent entity is bound from the route and available as a context.
- `addPage` redirects straight to the add form when only one bundle exists.

## Access model (read carefully)
- `view`: allowed when published (for publishable types) AND parent `view` access.
- other ops: `AccessResult::allowed()` AND-combined with parent access for that op.
- `checkCreateAccess()`: returns allowed for any `html` request format — it does NOT check the create permission or parent access. If you expose add routes to untrusted users, add your own create-access check.
