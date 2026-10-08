<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Permissions by Entity

The submodule has **no configuration of its own** (`configure: null`, no `config/`, no
`*.permissions.yml`, no schema). Everything it reads comes from the parent module.

```bash
drush en permissions_by_entity -y
```

## What must be true before it restricts anything

1. **The entity is not a node.** `AccessChecker::isAccessControlled()` returns `FALSE` for
   `node` on purpose — nodes stay with `permissions_by_term`.
2. **The entity is fieldable and saved** (`FieldableEntityInterface`, `!isNew()`), and the
   operation is `view`.
3. **The entity has an `entity_reference` field targeting `taxonomy_term`** (directly, or through
   another referenced fieldable entity — the check recurses).
4. **`permissions_by_term.settings:target_bundles` is NOT empty** and shares at least one
   vocabulary with that field's `handler_settings.target_bundles`:

   ```php
   // AccessChecker::isAccessControlled()
   $target_bundles = $settings->get('target_bundles');
   $field_target_bundles = $field_definition->getSetting('handler_settings')['target_bundles'] ?? [];
   if (is_countable($target_bundles) && count($target_bundles) > 0
       && count(array_intersect($field_target_bundles, $target_bundles)) > 0) { … }
   ```

   **This is the number one reason "nothing happens".** The parent module treats an empty
   `target_bundles` as "all vocabularies", but this submodule treats it as "none".
   Also: a term-reference field with **no** `handler_settings.target_bundles` (unrestricted) never
   intersects, so it is never controlled either.
5. Then either `permission_mode` is on (any eligible taxonomy field makes the entity controlled),
   or at least one referenced term actually carries a grant (`isAnyPermissionSetForTerm()`).

```bash
# make the submodule active for the 'tags' vocabulary
drush php:eval '\Drupal::configFactory()->getEditable("permissions_by_term.settings")
  ->set("target_bundles", ["tags"])->save();'
drush cr
```

## Where grants come from

Exactly the same tables and forms as the parent module — the term edit form's *Permissions*
fieldset and the user edit form's *Permissions → Vocabularies* selector, stored in
`permissions_by_term_user` / `permissions_by_term_role`.
See [the parent module's docs](../../../../3.1.x/agent/configure/settings-and-grants.md).

## Parent settings that change this submodule's behaviour

| Key | Effect here |
|---|---|
| `target_bundles` | **Required** (see above). |
| `permission_mode` | Any eligible taxonomy field makes the entity controlled, and `isAccessAllowed()` starts from `FALSE`. |
| `require_all_terms_granted` | The user must be granted **every** referenced term; `isAccessAllowed()` starts from `FALSE` and returns early on the first failure. |
| `disable_node_access_records` | Irrelevant here — this submodule uses `hook_entity_access()`, not node grants. |

## Checking whether an entity is controlled

```bash
drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("media")->load(1);
  $c = \Drupal::service("permissions_by_entity.access_checker");
  printf("controlled=%s allowed_for_uid_3=%s\n",
    var_export($c->isAccessControlled($e), TRUE),
    var_export($c->isAccessAllowed($e, 3), TRUE));'
```
