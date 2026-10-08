<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Elements (custom_elements) — agent index

Framework that renders Drupal entities/fields into **custom-element markup**
(`<node-article-teaser title="…">`) or an equivalent **JSON tree**, for consumption by
web-component or JS-framework front ends. Core of Lupus Decoupled Drupal.

- Version **3.4.1**, core `^10 || ^11`, PHP 8.1+ (Canvas integration needs 11.2+ / PHP 8.3+).
- License GPL-2.0-or-later. Composer `drupal/custom_elements` (requires `drunomics/service-utils`).
- Settings: `/admin/config/system/custom-elements` — permission `administer site configuration`.
- Submodules: `custom_elements_ui`, `custom_elements_thunder`, `custom_elements_extra_formatters`.

## Mental model

1. **`CustomElement`** (`src/CustomElement.php`) — the value object: a `tag`, optional
   `tagPrefix`, a flat `attributes` map, and weighted named **slots** holding markup
   (`MarkupInterface`) or nested `CustomElement`s. Carries cache metadata. Underscores in tags,
   attribute keys and slot keys are normalized to dashes; a leading `field-` is stripped by
   default (`CustomElement::$removeFieldPrefix`).
2. **`custom_elements.generator`** (`CustomElementGenerator`) — builds a `CustomElement` tree from
   a content entity + view mode. Picks one build path per bundle (see `api/generation.md`).
3. **Output layers** — markup via `template_preprocess_custom_element` + the `custom_element`
   theme hook + `templates/custom-element.html.twig`; JSON via `CustomElementNormalizer`.
   See `api/rendering.md` and `api/json.md`.

## Where things live

- Build service + processors: `src/CustomElementGenerator.php`, `src/Processor/*`.
- Field formatter plugins: `src/Plugin/CustomElementsFieldFormatter/*` (plugin type
  `custom_elements_field_formatter`). See `plugins/field-formatters.md`.
- Preview providers: `src/Plugin/CustomElementsPreviewProvider/*` (plugin type
  `custom_elements_preview_provider`). See `plugins/preview-providers.md`.
- CE display config entity: `src/Entity/EntityCeDisplay.php` (`entity_ce_display.*.*.*`).
  See `config/displays.md`.
- Settings + config: `src/Form/SettingsForm.php`, `config/install/custom_elements.settings.yml`,
  `config/schema/custom_elements.schema.yml`. See `config/settings.md`.
- Hooks (alter API): `custom_elements.api.php`, `custom_elements.module`.

## Solution docs

- `api/generation.md` — the generator, build paths, processors, entity/field access.
- `api/rendering.md` — markup output, theme hook, web-component vs vue-3 styles, slots.
- `api/json.md` — normalizer, explicit vs legacy JSON formats.
- `plugins/field-formatters.md` — the field formatter plugin type and shipped plugins.
- `plugins/preview-providers.md` — the preview provider plugin type (markup/json/nuxt).
- `config/displays.md` — Custom Elements Display config entity and the UI submodule.
- `config/settings.md` — module settings and how rendering is enabled per view mode.
- `submodules.md` — thunder, extra_formatters, ui.

## Key facts / gotchas

- By default the module does **nothing** until (a) another module uses the API (e.g.
  `lupus_ce_renderer`), or (b) a view mode has "Force custom elements rendering" enabled on its
  Manage Display tab. Any view mode whose machine name starts with `custom_elements` auto-enables.
- Markup attributes are emitted through Drupal's `Attribute` object, so attribute values **are**
  HTML-escaped. Slot values are emitted as `#markup`.
- JSON output is **not** HTML-escaped by design — the front end owns escaping.
- Two markup styles: `web_component` (default; `slot="name"` attributes) and `vue-3`
  (`<template #name>` named slots; array attributes become `:prop` bound props).
- Two JSON formats: `explicit` (`{element, props, slots}`, default for new installs) and
  `legacy`/implicit (props+slots merged at root; slated for removal in 4.x).
