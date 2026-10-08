<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Preview Link settings

Config object **`preview_link.settings`**. Form route `preview_link.settings` at
`/admin/config/content/preview_link` (`PreviewLinkSettingsForm`), permission
`administer preview link settings`.

## Keys (with shipped defaults from `config/install`)

| Key | Default | Meaning |
|---|---|---|
| `enabled_entity_types` | `{}` (none) | which entity types/bundles can have preview links |
| `expiry_seconds` | `604800` (7 days) | link lifetime, in seconds |
| `multiple_entities` | `true` | whether one link may reference several entities |
| `display_message` | `subsequent` | when to show "link created" message: `always` / `subsequent` / `never` |

`display_message` is schema-constrained to those three values.

## `enabled_entity_types` shape

A map of entity type id → list of bundle machine names. **An entity type key with an empty
list means "all bundles of that type".** Example:

```yaml
enabled_entity_types:
  node:
    - article      # only the Article bundle
  media: {}        # all media bundles
```

The settings form builds keys as `entity_type` (all bundles) or `entity_type:bundle` from a
tableselect, then writes this structure in `submitForm()`.

## Set / read via drush

```bash
drush config:get preview_link.settings
drush config:set preview_link.settings expiry_seconds 3600 -y
drush config:set preview_link.settings display_message always -y
```

Enable a bundle in PHP (append, don't clobber other types):

```php
$c = \Drupal::configFactory()->getEditable('preview_link.settings');
$bundles = $c->get('enabled_entity_types.node') ?: [];
$bundles[] = 'article';
$c->set('enabled_entity_types.node', $bundles)->save();
```

Only entity types Preview Link supports appear in the form
(`PreviewLinkUtility::isEntityTypeSupported`). Enabling a type is what surfaces the
**Preview Link** generate tab and gates preview access for that content.
