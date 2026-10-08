<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BCVB configuration

## Install / enable
`composer require drupal/bcvb` then `drush en bcvb`. No runtime dependencies. To use the
recommended companions, add `drupal/bca` and `drupal/pinto` (both listed under `require-dev`
in the module's own composer.json and as `suggests` — they are optional).

## Config object
`bcvb.settings` (config_object). Schema: `config/schema/bcvb.schema.yml`.
- `entity_types` — sequence of strings (entity type IDs). Default install value: `[]`
  (`config/install/bcvb.settings.yml`).

Each ID in `entity_types` is an entity type whose view-builder class BCVB replaces. Empty/unticked
entries are filtered out (`\array_filter`) in `bcvb_entity_type_alter()`, so a disabled type has no
effect.

## Settings form
- Route `bcvb.settings` → `/admin/config/content/bcvb`, permission `administer bcvb settings`
  (`bcvb.routing.yml`, `bcvb.permissions.yml`). Menu link under
  *Administration › Configuration › Content authoring* (`bcvb.links.menu.yml`).
- Form `Drupal\bcvb\Form\BcvbConfigForm` (extends `ConfigFormBase`, form id `bcvb_config`).
- `buildForm()` builds a `checkboxes` element whose options are every entity type that is a
  `ContentEntityTypeInterface` **and** has a view-builder class (`$type->hasViewBuilderClass()`).
  Config entity types and content types without a view builder are excluded.
- The element uses `#config_target => 'bcvb.settings:entity_types'`, so core's config-target
  handling saves the ticked IDs straight into the config object; there is no custom submit handler.
- The description reminds authors that bundles must implement
  `\Drupal\bcvb\Entity\BuildableEntityInterface`.

## Cache invalidation on change
`Drupal\bcvb\EventSubscriber\BcvbConfigSubscriber` (registered in `bcvb.services.yml`, autowired)
listens to `ConfigEvents::SAVE`. `onSave()` returns early unless the saved config is `bcvb.settings`
and its `entity_types` key actually changed (`$event->isChanged('entity_types')`); otherwise it calls
`entityTypeManager->clearCachedDefinitions()` so the new view-builder class is picked up. Because the
view builder is swapped in `hook_entity_type_alter`, a full definition rebuild (cache clear) is what
makes a newly ticked entity type start (or stop) using BCVB.

## Operating notes
- Enabling a type has no visible effect until at least one of its bundle classes implements
  `BuildableEntityInterface` and returns TRUE from `shouldBuild()`.
- The config is plain and exportable; deploy via config sync like any settings object.
