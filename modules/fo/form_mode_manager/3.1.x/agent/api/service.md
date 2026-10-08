<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `form_mode.manager` service

Service id **`form_mode.manager`** (class `FormModeManager`, interface
`FormModeManagerInterface`). The central API for discovering form modes; used by the route
subscribers, permissions, local task/action derivers, and the submodules.

## Key methods

| Method | Returns |
|---|---|
| `getActiveDisplays($entity_type_id)` | Form modes that have a `core.entity_form_display.<entity>.<bundle>.<mode>` config (mode != `default`), keyed by mode → display entity. **This is the definition of "active".** |
| `getFormModesByEntity($entity_type_id)` | Form modes for the entity type, minus excluded ones. |
| `getFormModesIdByEntity($entity_type_id)` | Machine names of the above. |
| `getAllFormModesDefinitions($ignore_excluded = FALSE, $ignore_active_display = FALSE)` | All entity types' form modes, filtered by exclusion and (by default) to active displays only. |
| `getFormModeManagerPath($entity_type, $form_mode_id)` | The canonical path + `/{form_mode_id}`. |
| `getFormModeExcluded($entity_type_id)` | The excluded-modes config for the entity type. |
| `filterExcludedFormModes(&$modes, $entity_type_id, $ignore_excluded)` | Removes excluded/malformed modes in place. |
| `filterInactiveDisplay(&$modes, $entity_type_id)` | Removes modes with no active form display. |

Constants: `FormModeManagerInterface::ADD_PREFIX = 'fmm_'`,
`EDIT_PREFIX = 'fmm_edit_'` (form-class identifiers).

## Usage

```php
$fmm = \Drupal::service('form_mode.manager');

// Which node form modes are actually usable (active) on this site?
$active = array_keys($fmm->getActiveDisplays('node'));   // e.g. ['contributor']

// All active form modes for every entity type:
$defs = $fmm->getAllFormModesDefinitions();               // ['node' => ['node.contributor' => …], …]
```

Note `getActiveDisplays()` reads config names directly (`config.factory->listAll('core.entity_form_display.<type>.')`)
and excludes the `default` mode — so activating a mode is exactly "create an entity_form_display
for it" (see [configure/settings.md](../configure/settings.md)). There is no Drush command; drive
it via this service or by writing the display/config.
