# Configure — settings & `ignored_entity_types`

**Configure route:** `entity_bundle_permissions.settings` → `/admin/config/entity-bundle-permissions`
(permission `administer entity_bundle_permissions`). Form class `Drupal\entity_bundle_permissions\Form\SettingsForm`.

## The only setting

Config object `entity_bundle_permissions.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `ignored_entity_types` | sequence of entity-type IDs | `{}` (empty) | Content entity types the module will **not** interfere with. Any type listed here is skipped by both the permission generator and the access hook. |

The form's multiselect only lists entity types that qualify (content entity type, non-internal,
with a bundle entity type) — the same set the module would otherwise gate.

## Read / set via drush

Read the ignored list:

```bash
drush config:get entity_bundle_permissions.settings ignored_entity_types
```

Set it (e.g. stop gating taxonomy terms and media):

```bash
drush config:set entity_bundle_permissions.settings ignored_entity_types.0 taxonomy_term -y
drush config:set entity_bundle_permissions.settings ignored_entity_types.1 media -y
```

Or via `php:eval`:

```php
\Drupal::configFactory()->getEditable('entity_bundle_permissions.settings')
  ->set('ignored_entity_types', ['taxonomy_term', 'media'])->save();
```

## Side effect of saving the form

`SettingsForm::submitForm()` calls `updateUserRoles()`, which iterates every `user_role` and
**revokes any permission that no longer exists** in the permission handler (i.e. bundle
permissions for now-ignored types, or bundles that were deleted). It reports how many roles were
updated. Setting the config directly with drush does *not* trigger this cleanup — resave the form
(or clear the roles yourself) if you need stale permissions purged.
