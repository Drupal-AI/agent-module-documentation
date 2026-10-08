<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Picker plugin type + PickerManager (icon / pictogram)

The module defines its own plugin type, `Dsfr4DrupalPicker`, whose plugins know how to enumerate the
available DSFR icon/pictogram set and resolve an item to a path/class. Everything else (widgets,
formatters, filters, CKEditor plugins, form elements, validation) asks the manager for one of the two
plugins and consumes its item list.

## Plugin type wiring

- Attribute `src/Attribute/Dsfr4DrupalPicker.php` — `#[\Attribute(TARGET_CLASS)]`, extends
  `Component\Plugin\Attribute\Plugin`. The plugin id is the single attribute argument, e.g.
  `#[Dsfr4DrupalPicker("icon")]`.
- Manager `src/PickerManager.php` (`PickerManager` implements `PickerManagerInterface`), service
  `plugin.manager.dsfr4drupal_picker` (also aliased to the interface). Discovers classes under
  `Plugin/Dsfr4DrupalPicker`, interface `PickerInterface`, attribute `Dsfr4DrupalPicker`.
  `alterInfo('dsfr4drupal_picker_info')`; cache bin key `dsfr4drupal_picker_info_plugins`.
- Interface `src/PickerInterface.php` — const `LIBRARY_PATH = 'libraries/dsfr/dist/'`. Methods:
  `getGroups()`, `getGroupLabel($group)`, `getItemsAvailable()`, `getItemsOriginal()`,
  `getItemsPath()`, `getItemPath($item)`, `sortGroups()`, `sortGroupsByKey()`.

## PickerBase (`Plugin/Dsfr4DrupalPicker/PickerBase.php`)

Abstract base (extends core `PluginBase`, `ContainerFactoryPluginInterface`). Injected:
`file_system`, `module_handler`; uses `UseCacheBackendTrait`.

- `getGroups()` = `array_keys(getItemsAvailable())`.
- `getGroupLabel($group)` = `t(ucfirst($group), [], ['context' => 'DSFR Group label'])`, then
  `hook_dsfr4drupal_picker_group_label_alter($group, &$label)`.
- `sortGroups()` / `sortGroupsByKey()` sort with `strcmp(iconv('UTF-8','ASCII//TRANSLIT', …))` — this
  is why the module requires `ext-iconv`.
- `sortItems()` (protected) `ksort()`s groups then `asort()`s each group's items.

## IconPicker plugin (`#[Dsfr4DrupalPicker("icon")]`)

- `getItemsPath()` = `libraries/dsfr/dist/icons`; `getCssFilesPath()` = `…/utility/icons/`.
- `getItemsOriginal()` scans `*.main.min.css` files under the icons dir, derives the **group** from
  the parent dir name (`icons-<group>`), and `parseCssFile()` extracts class names with
  `preg_match_all('#\.(fr-icon-[\w_-]+)#', …)` (deduped). Cached at `dsfr4drupal_picker:icons:…`.
- `getItemsAvailable()` = original set, then merges `hook_dsfr4drupal_picker_icons()`
  (`invokeAll`, `array_merge_recursive`), sorts, then `hook_dsfr4drupal_picker_icons_alter(&$icons)`.
  Cached at `dsfr4drupal_picker:icons`.
- `getItemPath($item)` returns the item unchanged — for icons the stored value **is** the CSS class
  (e.g. `fr-icon-warning-fill`).
- Throws `\LogicException` if no CSS files are found (i.e. DSFR library missing).

## PictogramPicker plugin (`#[Dsfr4DrupalPicker("pictogram")]`)

- `getItemsPath()` = `libraries/dsfr/dist/artwork/pictograms`.
- `getItemsOriginal()` scans `*.svg` (`getFiles()`), groups by parent dir name; each item value is
  `"<group>/<name>"`. Cached at `dsfr4drupal_picker:pictograms:original`.
- `getItemsAvailable()` mirrors the icon flow but with `hook_dsfr4drupal_picker_pictograms()` /
  `_pictograms_alter()`. Cached at `dsfr4drupal_picker:pictograms`.
- `getItemPath($item)` = `getItemsPath() . '/' . $item . '.svg'`, then
  `hook_dsfr4drupal_picker_pictogram_path_alter($item, &$path)` (used to point custom pictograms —
  e.g. the Media submodule's — at a real file). The value is a `group/name` string.
- Throws `\LogicException` if no SVG files are found.

## Consumers (all resolve items from the manager)

- Form/render elements build `#options` from `getItemsAvailable()` (see
  [elements/render-elements.md](../elements/render-elements.md)).
- The field value constraint checks the stored value against `getItemsAvailable()` (see
  [fields/fields.md](../fields/fields.md)).
- Formatters/filters render through the SDC components; the pictogram formatter uses `getItemPath()`
  + `getItemsOriginal()` (see [plugins/editor-embed.md](editor-embed.md)).
- `TwigExtension\PictogramExtension` exposes `dsfr_pictogram_url($pictogram)` (→ `getItemPath()`,
  returns a `base_path()`-prefixed URL only if the file exists) and `svg_attributes($filepath)`
  (parses only numeric `width`/`height`/`viewBox` from the SVG).

## Extending the sets (hooks, `dsfr4drupal_picker.api.php`)

`hook_dsfr4drupal_picker_icons()` / `_icons_alter(&$icons)`,
`hook_dsfr4drupal_picker_pictograms()` / `_pictograms_alter(&$pictograms)`,
`hook_dsfr4drupal_picker_pictogram_path_alter($pictogram, &$path)`,
`hook_dsfr4drupal_picker_group_label_alter($group, &$label)`. Sets are cache-backed, so changes
appear after a cache clear. No action is needed on a DSFR library update — sets are re-scanned.
