<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AttributesManager service & options.yml

## Service
`animate_fields_aos.attributes_manager` → `Drupal\animate_fields_aos\AttributesManager`
(defined in `animate_fields_aos.services.yml`, args `@module_handler`, `@theme_handler`,
`@cache.discovery`). It implements `AttributesManagerInterface`, `PluginManagerInterface`,
`CachedDiscoveryInterface` and extends `DefaultPluginManager`. Despite being a plugin manager, its only
job is to aggregate the animation/easing/anchor option definitions and return them as Form API
`#options` arrays. Interface constant `NO_DATA_ANIMATION_VALUE = 'none'`.

## Discovery — `getDiscovery()`
Uses `YamlDiscovery('options', …)` over **all module and theme directories**
(`$module_handler->getModuleDirectories() + $themeHandler->getThemeDirectories()`), wrapped in a
`ContainerDerivativeDiscoveryDecorator`. So every `<extension>.options.yml` (not only this module's) is
merged. Results are cached in the `animate_fields_aos` cache bin with tag `animate_fields_aos`. Each
definition has `label`, `group`, and (typo'd) `descripton` defaults.

## Definitions source — `animate_fields_aos.options.yml`
Flat map of `id: { label, group[, description] }`. Groups used by the three methods below:
- **Fade / Flip / Slide / Zoom** — animation effects (e.g. `fade-up`, `flip-left`, `slide-up`,
  `zoom-in-down`).
- **Ease** — easing curves (`linear`, `ease-in-out-cubic`, …).
- **Anchor Placement** — trigger anchors (`top-bottom`, `center-center`, …).

## Public methods (`AttributesManagerInterface`)
- `getAnimationOptions()` — grouped `#options` (optgroups Fade/Flip/Slide/Zoom) of definitions whose
  `group` is in `['Fade','Flip','Slide','Zoom']`, each labelled `"@label (@tag)"`. Prepends `none => None`.
- `getAnchorPlacementOptions()` — flat `#options` of `group === 'Anchor Placement'`. Prepends `none`.
- `getEasingOptions()` — flat `#options` of `group === 'Ease'`. Prepends `none`.

Each id is used verbatim as the `data-aos*` attribute value emitted by `hook_preprocess_field`.

## Extending the option lists
Ship a `<yourmodule>.options.yml` (or `<yourtheme>.options.yml`) with entries in the matching `group`
(e.g. `group: Fade` for a new effect, `group: Ease`, or `group: Anchor Placement`). Clear the
`animate_fields_aos` discovery cache (or `drush cr`) and the new option appears in the formatter selects.
The `id` you choose must be a valid AOS attribute value for the CDN library to react to it.
