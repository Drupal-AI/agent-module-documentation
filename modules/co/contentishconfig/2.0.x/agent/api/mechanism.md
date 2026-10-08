<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contentish Config — mechanism (event subscriber + third-party setting)

Everything the module does lives in two files: `contentishconfig.module` (the UI checkbox) and
`src/ContentishConfigTransformationEventSubscriber.php` (the sync behavior). No routes,
permissions, settings form, or Drush.

## Install / enable

`drush en contentishconfig`. No dependencies to add (composer.json has only `require-dev`:
`drupal/core ^9.3`, `drupal/config_ignore ^2.3` — neither is a runtime requirement). Core config
sync must be in use (`config.transform.export` / `config.transform.import` are core events, D8.8+).

## Marking config as contentish (the UI)

`contentishconfig_form_alter(&$form, $formState, $formId)`:
- Runs on any form whose form object is an `EntityFormInterface` and **not** an
  `EntityDeleteForm`, when the edited entity is a `ConfigEntityInterface`.
- Sets `$form['third_party_settings']['#tree'] = TRUE` and adds a fieldset **"Contentish config"**
  with a checkbox **"Contentish"** at `third_party_settings.contentishconfig.contentish`.
- `#default_value` = the entity's existing third-party setting, falling back to
  `ContentishConfigTransformationEventSubscriber::contentishSelectionDefault($config)`.
- Registers `#entity_builders[] = 'contentishconfig_entity_builder'`.

`contentishconfig_entity_builder(...)`: reads the submitted value; if it differs from the default
it calls `$configEntity->setThirdPartySetting('contentishconfig', 'contentish', $bool)`, otherwise
`unsetThirdPartySetting(...)`. So the flag is only persisted when it deviates from the default —
keeping exported config clean.

Schema (`config/schema/contentishconfig.schema.yml`): `*.*.*.third_party.contentishconfig` →
mapping with boolean `contentish`. The flag therefore serializes as part of the host entity's own
config.

## The default rule

```php
public static function contentishSelectionDefault(ConfigEntityInterface $config): bool {
  return strpos($config->id(), '_content_') === 0;
}
```

Any config entity whose **machine id begins with `_content_`** is contentish by default (no
checkbox change needed). Everything else defaults to not-contentish.

## How ignoring works (the subscriber)

`getSubscribedEvents()`: `config.transform.export` → `onConfigTransformExport` (priority **500**),
`config.transform.import` → `onConfigTransformImport` (priority **-500**).

`getContentishConfigNames()` (protected) iterates every `ConfigEntityTypeInterface` from the entity
type manager, loads all entities of each type, reads their `contentish` third-party setting (or the
`_content_` default when unset), and returns the full config names
(`$entityType->getConfigPrefix() . '.' . $config->id()`) of those that are contentish.

- **Export** (`onConfigTransformExport`): for the default collection plus every collection, calls
  `$collection->delete($configName)` for each contentish name — **removing** those items from the
  export/sync storage so they never appear in a config export or diff.
- **Import** (`onConfigTransformImport`): for each collection, reads each contentish item from the
  **active** storage (`@config.storage`) and, if it is an array, writes it back into the incoming
  import storage. This makes the import see the current live value, so the import neither deletes
  the item (it exists in the incoming storage) nor overwrites the active value with something from
  the sync directory.

Net effect: contentish config is pinned to whatever is currently active on the site and is invisible
to config-sync in both directions.

## Operating notes

- Because names come from **loaded config entities** on the site, only config that currently exists
  in active storage can be contentish; a brand-new `_content_*` item arriving purely via import is
  not pre-known.
- The flag is entity-local (third-party setting), so there is no central ignore list to maintain and
  the decision travels with the entity's own config.
- Priorities (export +500 / import -500) place this transform early on export and late on import
  relative to other storage transformers.
