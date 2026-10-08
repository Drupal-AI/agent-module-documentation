<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Asset detection & registration

## Entry points (entity hooks)

`acquia_dam_integration_links.module`:

```php
hook_entity_insert($entity)  -> enhanced_register->trackAssetUsage($entity)
hook_entity_update($entity)  -> enhanced_register->trackAssetUsage($entity)
hook_entity_delete($entity)  -> enhanced_register->removeAssetUsage($entity)
```

Only **eligible content entities** are processed; **media** and **paragraph** entities are
skipped as top-level subjects (their assets are tracked through the host entity).

## Services

| Service | Class | Role |
|---|---|---|
| `acquia_dam_integration_links.enhanced_register` | `EnhancedIntegrationLinkRegister` | Orchestrates track/remove; diffs old vs new assets; delegates to the parent register. |
| `acquia_dam_integration_links.tracker` | `AssetTracker` | Collects `asset_detector`-tagged services (`service_collector`) and runs them over an entity. |
| `acquia_dam_integration_links.media_reference_detector` | `MediaReferenceAssetDetector` | Finds DAM media via entity-reference fields. |
| `acquia_dam_integration_links.text_embed_detector` | `EntityEmbedTextDetector` | Finds DAM assets embedded in rich-text (Entity Embed). |
| `acquia_dam_integration_links.paragraphs_detector` | `ParagraphsAssetDetector` | Recurses into nested paragraphs. |

```php
// automatic on save/delete, but callable directly:
\Drupal::service('acquia_dam_integration_links.enhanced_register')->trackAssetUsage($entity);
\Drupal::service('acquia_dam_integration_links.enhanced_register')->removeAssetUsage($entity);
```

## Adding a detector

Register a service with the `asset_detector` tag implementing `AssetDetectorInterface`; the
`AssetTracker` picks it up via `addAssetDetector()` (service_collector). Use it to teach
discovery about a custom field/structure.

```yaml
services:
  mymodule.my_detector:
    class: Drupal\mymodule\MyAssetDetector
    tags:
      - { name: asset_detector }
```

## Registration & queue

After discovery, `EnhancedIntegrationLinkRegister` hands the asset set to the parent's
`acquia_dam.integration_link_register` (`IntegrationLinkRegister`), which enqueues
registration/removal in the **`acquia_dam_integration_links`** queue. Process it with the
parent module's tooling:

```bash
drush queue:run acquia_dam_integration_links
# or the parent Drush commands:
drush acquia-dam:queue-integration-links        # ad:qil
drush acquia-dam:process-integration-links-queue # ad:pilq
drush acquia-dam:register-integration-links     # ad:ril
```

The queue worker (plugin id `acquia_dam_integration_links`) and the actual DAM API calls live
in the **parent** module and require a live DAM connection.
