<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text-format filters + CKEditor 5 plugins (token → markup)

This is the rich-text path: two CKEditor 5 buttons insert a placeholder tag into stored body text,
and two text-format filters turn that tag into rendered icon/pictogram markup on display. Both must
be enabled on the same text format.

## Filters (`src/Plugin/Filter/`)

- `PickerFilterBase` (abstract, `@internal`, extends core `FilterBase`, injects `renderer`). Consts
  `TAG_NAME` and `ITEM_ATTRIBUTE` set by subclasses. `process($text, $langcode)`:
  1. Fast-exits if the text does not contain `<TAG_NAME`.
  2. Loads the text with `Html::load()`, runs an XPath query for
     `//TAG_NAME[normalize-space(@ITEM_ATTRIBUTE)!='']`.
  3. For each node, `buildItem($node)` returns a render array, which `renderIntoDomNode()` renders
     inside a `RenderContext` (so bubbleable metadata is merged onto the `FilterProcessResult`) and
     substitutes for the node via `replaceNodeContent()`.
- `IconPickerFilter` (`id: dsfr4drupal_picker_icon`, `TYPE_TRANSFORM_REVERSIBLE`, tag `dsfr-icon`,
  attrs `data-icon` + `data-size`). `buildItem()` returns `#type => 'component'`,
  `#component => 'dsfr4drupal_picker:icon'`, props `icon` = `Html::escape($node->getAttribute('data-icon'))`
  and `size` = `Html::escape($node->getAttribute('data-size') ?: '')`.
- `PictogramPickerFilter` (`id: dsfr4drupal_picker_pictogram`, tag `dsfr-pictogram`, attr
  `data-pictogram`). `buildItem()` returns `#component => 'dsfr4drupal_picker:pictogram'` with prop
  `pictogram` = `Html::escape($node->getAttribute('data-pictogram'))`.

The attribute value read from the source tag is escaped before it becomes an SDC prop, and the SDC
Twig applies further attribute/class escaping on render (`Attribute::addClass()` for the icon class;
Twig attribute-context autoescape for the pictogram path). Both filters expose `tips()` help text.

## SDC components (`components/`)

- `dsfr4drupal_picker:icon` (`components/icon/icon.twig`) — required prop `icon`, optional `size`
  (enum xs/sm/md/lg, default md). Emits `<span aria-hidden="true" class="fr-icon--<size> <icon>">`.
- `dsfr4drupal_picker:pictogram` (`components/pictogram/pictogram.twig`) — required prop `path`,
  optional `is_dsfr` (default true). Merges `svg_attributes(path)` (numeric width/height/viewBox
  only), then either an `<svg>` with three `<use href="{{ path }}#artwork-…">` (DSFR) or an
  `<img src="{{ path }}">` (custom).

## CKEditor 5 plugins (`src/Plugin/CKEditor5Plugin/`)

- `PluginBase` (abstract, `@internal`, extends `CKEditor5PluginDefault`, configurable). Config
  `allowed_groups => []`, `has_search => TRUE`; its configuration form is `ConfigureFormBase`
  (via a plugin form factory). `getDynamicPluginConfig()` builds the grouped, group-label-translated
  `items` list (respecting `allowed_groups`) from `picker->getItemsAvailable()`, plus `has_search`
  and the widget `theme`, and hands it to the client plugin (`PLUGIN_NAME`).
- `Icon` — `PLUGIN_NAME = dsfrIconPicker`, button *DSFR icons*, `dialogUrl` =
  `dsfr4drupal_picker.icon.dialog`, form `ConfigureIconForm`.
- `Pictogram` — `PLUGIN_NAME = dsfrPictogramPicker`, button *DSFR pictograms*, `dialogUrl` =
  `dsfr4drupal_picker.pictogram.dialog`, adds `pictoBasePath`, form `ConfigurePictogramForm`.
- Definition file `dsfr4drupal_picker.ckeditor5.yml` declares the two plugins, their toolbar items,
  allowed elements (`<dsfr-icon data-icon data-size>`, `<dsfr-pictogram data-pictogram>`), and the
  filter `conditions` (`dsfr4drupal_picker_icon` / `_pictogram`) — the button only shows when its
  filter is enabled. Client builds are `js/build/icon.js` / `pictogram.js` (see
  `dsfr4drupal_picker.libraries.yml`; sources under `js/ckeditor5_plugins/`).
- The plugin **configuration** form (per text format) is `PluginForm/ConfigureFormBase` +
  `ConfigureIconForm`/`ConfigurePictogramForm`: *Allowed groups* checkboxes and a *Display search
  input* checkbox, stored in the editor's plugin settings.

## End-to-end

Editor clicks a toolbar button → a dialog form (see
[config/settings-and-routes.md](../config/settings-and-routes.md)) inserts
`<dsfr-icon data-icon="…" data-size="md">` (or `<dsfr-pictogram data-pictogram="…">`) into the body.
On display, the matching filter converts each tag to the SDC-rendered icon/pictogram. Note: the
pictogram filter passes prop `pictogram` while the SDC requires `path` — a functional/rendering
mismatch to be aware of when embedding pictograms via the filter.
