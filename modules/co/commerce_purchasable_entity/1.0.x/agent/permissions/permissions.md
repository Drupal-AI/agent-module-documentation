# Permissions and access control

## Permissions (`commerce_purchasable_entity.permissions.yml`)

| Permission | Notes |
|---|---|
| `administer commerce_purchasable_entity_type` | `restrict access: true`. Also the entity type `admin_permission` for both `commerce_purchasable_entity` and `commerce_purchasable_entity_type`. Grants full access to every entity operation and to type/bundle administration (fields, form/view displays). |
| `create commerce_purchasable_entity` | Create purchasable entities. |
| `edit commerce_purchasable_entity` | Edit (update) purchasable entities. |
| `delete commerce_purchasable_entity` | Delete purchasable entities. |
| `view commerce_purchasable_entity` | View purchasable entities. |

The bundle-type routes (`entity.commerce_purchasable_entity_type.*`) and Field UI require
`administer commerce_purchasable_entity_type`. The configuration landing route
(`commerce_purchasable_entity.configuration`) requires the core `access commerce administration
pages` permission.

## Access control handler

`Drupal\commerce_purchasable_entity\PurchasableEntityAccessControlHandler`
(`src/PurchasableEntityAccessControlHandler.php`) extends core `EntityAccessControlHandler`. Each
operation is `AccessResult::allowedIfHasPermissions(..., 'OR')` on the specific permission **or**
the admin permission — nothing is granted anonymously:

| Operation | Allowed if the account has |
|---|---|
| `view` | `view commerce_purchasable_entity` OR `administer commerce_purchasable_entity_type` |
| `update` | `edit commerce_purchasable_entity` OR `administer commerce_purchasable_entity_type` |
| `delete` | `delete commerce_purchasable_entity` OR `administer commerce_purchasable_entity_type` |
| create (`checkCreateAccess`) | `create commerce_purchasable_entity` OR `administer commerce_purchasable_entity_type` |
| other operations | `AccessResult::neutral()` |

This matrix is asserted directly by `tests/src/Kernel/PurchasableEntityAccessTest.php` (e.g. a user
with only `view` can view but not update/delete; a user with only `access administration pages` is
denied all three). Access is not per-store or per-owner — it is a flat permission check.
