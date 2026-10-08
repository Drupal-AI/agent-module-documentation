<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Slider collection (slider_collection) — agent index

**Base/wrapper module** for JS slider libraries. On its own it renders nothing: it ships
abstract base classes + two settings-alter events, and the concrete integrations live in
submodules. A slider is built as a **Views display** using a submodule's Views style (rows =
slides), or as a **field formatter** on a multi-value entity-reference field (sc_swiper only).

- Depends on core `views`. Core `^10 || ^11`. No routes, permissions, settings page, config
  schema, services, drush, or `.module` file of its own.
- Slider option values (autoplay/loop/speed/breakpoints/items…) are set per Views display or per
  field-display in their option forms; there is no site-wide config object.

Submodules shipped in the tarball (documented separately, not here):

| Submodule | Library | Local library path expected | Provides |
|---|---|---|---|
| `sc_swiper` | Swiper (`^11.1`) | `/libraries/swiper/swiper-bundle.min.js` | Views style `sc_swiper`, field formatters `swiper_entity_reference` / `swiper_entity_reference_revisions` |
| `sc_tinyslider` | Tiny Slider 2 (`^2.9`) | `/libraries/tiny-slider/dist/min/tiny-slider.js` | Views style `sc_tinyslider` |

Enabling the base alone does nothing visible — enable one library submodule and download its JS
library locally (a `hook_requirements` runtime check enforces this).

What you'd do:
- **Extend to a new slider library / understand the base classes** → [api/extend.md](api/extend.md)
- **Alter slider settings before render (EventSubscriber)** → [events/settings.md](events/settings.md)

Key facts (real names from source):
- Base classes: `Drupal\slider_collection\SliderCollectionSliderBase` (settings-shaping service base,
  `getSliderGeneralSettings()`, abstract `defaultSettings()` / `formattedSettings(array)`) and
  `Drupal\slider_collection\SliderCollectionViewsStyleBase` (extends Views `StylePluginBase`,
  `usesRowPlugin`/`usesRowClass` = TRUE, common option form + cache handling, abstract
  `getDefaultSettings()` / `getFormattedSettings()`).
- Events: `Drupal\slider_collection\Event\SliderCollectionEvents::ALTER_VIEW_SETTINGS`
  (`slider_collection.alter_view_settings`, `AlterViewSettingsEvent`) and `::ALTER_ENTITY_SETTINGS`
  (`slider_collection.alter_entity_settings`, `AlterEntitySettingsEvent`).
- Common Views-style option keys (from `SliderCollectionViewsStyleBase::buildOptionsForm`):
  `autoplay`, `speed`, `loop`, `breakpointMobile`/`itemsMobile`, `breakpointTablet`/`itemsTablet`,
  `breakpointDesktop`/`itemsDesktop`.
- No `SliderCollectionSlider` plugin type exists — integration is by subclassing the two base
  classes, not by a plugin manager.
