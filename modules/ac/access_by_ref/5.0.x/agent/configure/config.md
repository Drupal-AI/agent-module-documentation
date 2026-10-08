# Configure Access by Reference

Config UI: `/admin/config/content/access_by_ref` (route `entity.abrconfig.collection`,
permission `administer access_by_ref settings`). Add/edit rules there; each rule is an
`abrconfig` config entity (`access_by_ref.abrconfig.<id>`). The add form is
`Drupal\access_by_ref\Form\AbrconfigForm`.

## The `abrconfig` config entity (schema `access_by_ref.abrconfig.*`)

| Key | Form label | Meaning |
|---|---|---|
| `id` / `label` | Machine name / Label | Rule identity. |
| `bundle` | Bundle | Node bundle the rule applies to (options = all node bundles). |
| `field` | Field | Field on that bundle whose value is examined (all `FieldConfig` fields except `body`). |
| `reference_type` | Reference type | `user` / `user_mail` / `shared` / `inherit`. |
| `extra` | Extra field | A **user** entity field, used only by `shared` (the profile value to match). |
| `rights_type` | Rights type field | `view`/`update`/`delete` — the operation checked on the *parent* for `inherit`. |
| `rights_read` | Assign read rights? | Grant `view` when the rule matches. |
| `rights_update` | Assign update rights? | Grant `update` when the rule matches. |
| `rights_delete` | Assign delete rights? | Grant `delete` when the rule matches. |

## The four reference types (`AccessByRefHooks::nodeAccess`)

- **`user`** — the node's `field` is an entity reference; matches if any `target_id` equals the
  current user's uid.
- **`user_mail`** — the node's `field` holds email `value`(s); matches (case-insensitive,
  `strcasecmp`) against `currentUser->getEmail()`.
- **`shared`** — loads the current user, reads the user field named in `extra`, and matches if
  any node-field value equals any user-field value (compares on `value`, else `target_id`).
- **`inherit`** — for each `target_id` in the node's reference `field`, loads the referenced
  entity and grants if `target->access($rights_type)` is not FALSE. Handler-aware:
  `default:node`/`views` → check a referenced node; `default:user` → a referenced user;
  `default:paragraph` → follows the paragraph's `extra` field to referenced nodes. Chainable
  (a granted parent whose own access came from another `abrconfig`), with **no loop guard**.

## Grant algorithm

1. Return `neutral` immediately if op is `create`, user is anonymous (`uid == 0`), or user lacks
   `access node by reference`.
2. Load all `abrconfig` for `$node->bundle()`. For each, evaluate the reference type above.
3. On a match, set `grant_access_read/update/delete` from the rule's three booleans, then:
   `read`+op`view` → `AccessResult::allowed()`; `update`+op`update` → allowed; `delete`+op`delete`
   → allowed. Allowed results add `cachePerPermissions()->cachePerUser()` + the control entity as
   a cache dependency.
4. If nothing matches, return `AccessResult::neutral()` — the module never denies, only widens.

## Notes / gotchas

- Multiple `abrconfig` on the same bundle are all evaluated; the first matching allowed op wins.
- `inherit` checks the *single* `rights_type` operation on the parent but can then grant any of
  read/update/delete you enable — the checked op and the granted ops are independent.
- Changing config wipes the render cache (`cache.render` deleteAll) on save.
- Set a rule with Drush:
  ```php
  \Drupal::entityTypeManager()->getStorage('abrconfig')->create([
    'id' => 'article_owner', 'label' => 'Article owner edit',
    'bundle' => 'article', 'field' => 'field_owner', 'reference_type' => 'user',
    'rights_read' => TRUE, 'rights_update' => TRUE, 'rights_delete' => FALSE,
  ])->save();
  ```
