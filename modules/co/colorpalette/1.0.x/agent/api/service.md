# Color Palette — `colorpalette.utility` service

Service `colorpalette.utility` → `Drupal\colorpalette\ColorPaletteUtility` (args `@current_user`,
`@entity_type.manager`; uses the `taxonomy_term` storage). Public methods:

| Method | Purpose |
|---|---|
| `getPaletteColors(array $filter_tags = [])` | Loads published `colorpalette_colors` terms, sorted by weight then name; if filter tags given, `field_colorpalette_filter_tags IN (…)`. `accessCheck(TRUE)`. |
| `isColorExisting($hexcode): int` | Returns the term id of an existing color with that hexcode, or `0`. |
| `createNewColor($hexcode, $name, array $filter_tags): Term` | Creates + saves a published `colorpalette_colors` term. |
| `loadColor($id)` | Load one (int) or many (array) terms. |
| `extractTargetIds(array $target_ids): array` | Flatten `[['target_id'=>N],…]` to `[N,…]` (int). |
| `isAdministerPaletteUser(): bool` | `currentUser->hasPermission('administer palette')`. |
| `resetColorWise()` | Loads all Colors terms, sorts by summed HSV (`hexToHsv`), and re-saves each with an incrementing weight. |
| `hexToHsv($hex): array` | Convert `#rrggbb` to `['h','s','v']`. |
| `getDataDialogOptions()` / `getDialogLinkOptions(array $options = [])` | Modal dialog option arrays for the launch link / modal. |
| `generateAjaxResponse(array $data): AjaxResponse` | Builds the AJAX response that applies a picked color: closes the dialog, sets the field value via `InvokeCommand` on `[data-drupal-selector=…]`, and updates the launch button's class/background/html. |

Notes for callers:
- To apply a color programmatically to a field element you mirror `generateAjaxResponse`'s `$data`:
  `selector` (the field's `data-drupal-selector`), `value` (`#rrggbb` for text, or `"Label (tid)"` for
  entity_reference), `background` (hex without `#`), `html`.
- The New Color submit handler (`ColorPaletteNewColorForm::updateColorState`) is the reference flow for
  create-or-reuse-and-publish with filter-tag merging.
