<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widgets & Controls plugin systems

Noahs has **two** plugin systems, each with a manager service and an annotation/attribute.

## Widgets
- Manager: `plugin.manager.widget` → `WidgetManager` (`parent: default_plugin_manager`).
- Annotation: `Annotation\WidgetPlugin`.
- Base: `Plugin\Widget\WidgetBase` (implements `WidgetInterface`).
- ~35 shipped widgets under `src/Plugin/Widget/`, e.g. `WidgetNoahsRow`, `WidgetNoahsColumn`, `WidgetNoahsCard`/`WidgetNoahsCardGrid`, `WidgetNoahsHeading`, `WidgetNoahsButton`, `WidgetNoahsText`/`WidgetNoahsPlainText`/`WidgetNoahsPlainCode`, `WidgetNoahsImage`/`WidgetNoahsGallery`/`WidgetNoahsSlideshow`/`WidgetNoahsCarousel`, `WidgetNoahsTabs`/`WidgetNoahsAccordion`, `WidgetNoahsVideo`, `WidgetNoahsCountdown`, `WidgetNoahsImageComparer`, and Drupal-integration widgets `WidgetNoahsDrupalBlock`, `WidgetNoahsDrupalViews`, `WidgetNoahsDrupalWebform`, `WidgetNoahsDrupalToken`, `WidgetNoahsInsertNode`.

## Controls
- Manager: `plugin.manager.control` → `ControlManager`; helper services `noahs_page_builder.control_service` (`Service\ControlServices`) and `noahs_page_builder.controls_manager` (`ControlsManager`).
- Annotation: `Annotation\ControlPlugin`. Base: `Plugin\Control\ControlBase`.
- ~40 controls under `src/Plugin/Control/`: primitives (`ControlText`, `ControlTextarea`, `ControlNumber`, `ControlSelect`, `ControlCheckbox`, `ControlRadio`, `ControlDate`, `ControlHidden`, `ControlHtml`, `ControlNoahsColor`, `ControlNoahsUrl`, `ControlNoahsImage`) and styling groups (`ControlNoahsMargin`, `ControlNoahsPadding`, `ControlNoahsBorder`, `ControlNoahsRadius`, `ControlNoahsShadows`, `ControlNoahsBackgroundImage`/`Gradient`/`Overlay`, `ControlNoahsFont`/`FontStyles`, `ControlNoahsTransform`, `ControlNoahsWidth`, `ControlNoahsCustomCss`, `ControlNoahsTable`, `ControlNoahsGallery`, `ControlNoahsVideoBackground`/`VideoUpload`, `ControlNoahsCoordinates`, `ControlNoahsSelectDesign`).

## Adding your own
Create a plugin in your module under `src/Plugin/Widget` or `src/Plugin/Control`, extend the matching base class, and annotate with `@WidgetPlugin`/`@ControlPlugin`. The managers autodiscover it and it appears in the builder palette / control panel. Widget/control config is serialized into the page layout JSON and rendered via the module's Twig templates.

## Also provided
- Blocks: `NoahsMenuBlock`, `NoahsLocalTasksBlock`, `NoahsSocialNetworksBlock`.
- Views style plugin `NoahsSwiperStyle`; field formatters `NoahsGalleryFormatter`, `NoahsMediaSwiperFormatter`.
- Theme negotiator `Theme\CustomThemeNegotiator`.
