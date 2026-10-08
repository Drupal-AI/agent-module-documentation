<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST resources

Three `@RestResource` plugins in `src/Plugin/rest/resource/`. Each extends
`Drupal\rest\Plugin\ResourceBase`, injects services via `create()`, implements only `get()`, and
returns a `Drupal\rest\ResourceResponse` (the array is serialized by core's serializer to the
requested format). URIs use only the `canonical` `uri_paths` entry — GET only.

## 1. Bundles by entity — `EntityBundlesResource`

- **Plugin id:** `entity_bundles`. **Label:** "Bundles by entity".
- **URI:** `GET /entity/{entity_type}/bundles`.
- **`get(string $entity_type)`**: calls the `entity_type.bundle.info` service
  `getBundleInfo($entity_type)` and returns that array (keyed by bundle id, each with `label`,
  `translatable`, etc.). When `$entity_type == 'node'`, it loops the bundles and sets
  `$bundle['description']` from `NodeType::load($bundle_id)->getDescription()`.
- **Errors:** throws `BadRequestHttpException("Entity type wasn't provided.")` when `$entity_type`
  is empty.
- **Injected:** `entity_type.manager`, `current_user` (stored but not used); the bundle-info
  service is fetched inline via `\Drupal::service('entity_type.bundle.info')`.

## 2. Fields by entity + bundle — `EntityBundleFieldsResource`

- **Plugin id:** `Entity Bundle Resource Label` (literal, spaces included — this is the machine id
  in the annotation). **Label:** "Fields by entity bundle".
- **URI:** `GET /entity/{entity_type}/{bundle}/fields`.
- **`get(string $entity_type, string $bundle)`**: runs
  `\Drupal::entityQuery('field_config')->condition('id', "$entity_type.$bundle.", 'STARTS_WITH')`,
  loads the matches with `FieldConfig::loadMultiple($ids)`, and builds a map keyed by field name
  where each entry has `field_config` (the `FieldConfig`) and `field_storage`
  (`$field_instance->getFieldStorageDefinition()`). Returns that map.
- **Errors:** `NotFoundHttpException` when no fields match; `BadRequestHttpException` when
  `$entity_type`/`$bundle` are missing.
- **Injected:** `current_user` (stored, not used). Note: this is a `field_config` query, so it
  returns only configurable (bundle) fields, not base fields.

## 3. View modes by entity + bundle — `EntityBundleViewModesResource`

- **Plugin id:** `bundle_view_modes`. **Label:** "View modes by entity bundle".
- **URI:** `GET /entity/{entity_type}/{bundle}/view_modes`.
- **`get(string $entity_type, string $bundle)`**: gets the `entity_view_display` definition's
  `getConfigPrefix()`, then `config.factory->listAll("{prefix}.{entity_type}.{bundle}.")`. For each
  returned config name it strips the prefix and returns a map of the remaining machine id
  (`{entity_type}.{bundle}.{view_mode}`) to the view-mode label segment.
- **Errors:** `NotFoundHttpException` when the list is empty; `BadRequestHttpException` when args
  are missing.
- **Injected:** `entity_type.manager`, `config.factory`, `current_user` (stored, not used).

## Notes

- The fields and view-modes classes import `AccessDeniedHttpException` but never throw it; access is
  handled entirely by the REST layer (see [config/enable-and-access.md](../config/enable-and-access.md)).
- Responses are plain arrays; the classes do not attach explicit cacheability metadata to the
  `ResourceResponse`.
