# Configure Entity Translation Sync

Settings form at `/admin/config/regional/entity-translation-sync` (route
`entity_translation_sync.settings_form`, menu link under `system.admin_config_regional`, gated by core
`administer site configuration`). Class `Drupal\entity_translation_sync\Form\SettingsForm`, form id
`entity_translation_sync_settings`, editable config `entity_translation_sync.settings`.

The form lists every **translatable** entity type that has at least one translatable bundle. Enable an
entity type (checkbox), then per bundle tick "enabled" and tick which of its **translatable** fields may
be synced. Non-translatable fields and `entity_reference_revisions` fields (Paragraphs) are never
offered. If no translatable entity type exists, the form shows a link to
`language.content_settings_page` instead.

- `validateForm`: an enabled bundle with **no** field ticked is a validation error.
- `submitForm`: writes the config; if the *set of enabled entity types* changed vs. before, it adds a
  warning "After removing / adding new entity types is needed to clear caches." **You must clear caches**
  after any entity-type enable/disable, because routes, the link template, per-type permissions and the
  tab are all rebuilt from this config.

## Config object shape

`entity_translation_sync.settings` has a single key `entity_types`. Ships empty (`config/install`:
`entity_types: {}`). Populated shape:

```yaml
entity_types:
  node:                       # entity type id
    bundles:
      article:                # bundle id
        fields:               # sequence of field machine names
          - field_media
          - field_price
      page:
        fields:
          - field_hero
  media:
    bundles:
      image:
        fields:
          - field_media_image
```

Schema (`config/schema/entity_translation_sync.schema.yml`): `entity_translation_sync.settings` is a
`config_object`; `entity_types` is a `sequence` keyed by entity type → `bundles` sequence keyed by bundle
→ `fields` sequence of strings.

## Set it with Drush / PHP

```php
$config = \Drupal::configFactory()->getEditable('entity_translation_sync.settings');
$config->set('entity_types', [
  'node' => [
    'bundles' => [
      'article' => ['fields' => ['field_media', 'field_price']],
    ],
  ],
])->save();
```

Or with Drush:

```bash
drush cset entity_translation_sync.settings entity_types.node.bundles.article.fields.0 field_media -y
drush cr   # required after adding/removing an entity type
```

## What happens at runtime

Once an entity type appears in `entity_types`, this chain wires up the sync page:

1. **Link template** — `entity_translation_sync_entity_type_alter()` (`.module`) adds link template
   `drupal:entity-translation-sync` = `<canonical>/entity-translation-sync` to each enabled entity type
   that has a `canonical` template.
2. **Route** — `EntityTranslationSyncRouteSubscriber::alterRoutes()` (service
   `entity_translation_sync.route_subscriber`, `RoutingEvents::ALTER` priority `-219`) registers route
   `entity.<entity_type_id>.entity_translation_sync` at that path. Its form is
   `Drupal\entity_translation_sync\Form\EntityTranslationSyncForm`; it inherits `_admin_route` from the
   type's `entity.<type>.edit_form`. Requirements: `_entity_access: <type>.view` **and**
   `_entity_translation_sync_access: 'TRUE'`.
3. **Access check** — `EntityTranslationSyncAccessChecker` (service
   `access_check.entity_translation_sync.synchronize_access_checker`, `applies_to:
   _entity_translation_sync_access`) allows when the entity's type+bundle is enabled in config **and**
   the account holds `synchronize any entity translation` OR `synchronize <type> translation`.
4. **Tab** — `EntityTranslationSyncLocalTasks` deriver adds an "Entity translation sync" local task on
   the entity canonical for each enabled type. `hook_entity_operation` also adds the same as an entity
   **operation** link in listings (subject to the same permissions).
5. **The sync form** (`EntityTranslationSyncForm`): resolves the entity in the current language
   (`EntityRepository::getTranslationFromContext`). It renders a table — one row per configured field
   that is non-empty and passes `access('view')`/`access('edit')`, one column per *other* translation
   language (all translation languages except the current one). A per-language checkbox is offered for a
   field only when `access('edit')` passes. Submitting runs a **batch**: for each selected language it
   sets each chosen field on that translation to the current language's value
   (`$translation->set($field, $entity->get($field)->getValue())`), then saves the entity **once** at the
   end. Success/failure per language is reported via messenger; per-field errors are logged to
   `logger.channel.entity_translation_sync`.

Only the values are copied; fields stay translatable, so a language can still diverge on the next edit.
Values already divergent before a field was added to the sync set are not reconciled until the next sync
run.
