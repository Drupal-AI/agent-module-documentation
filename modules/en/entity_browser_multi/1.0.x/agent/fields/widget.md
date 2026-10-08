<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity browser (multi) field widget

Class `Drupal\entity_browser_multi\Plugin\Field\FieldWidget\EntityBrowserMultiWidget`
(`src/Plugin/Field/FieldWidget/EntityBrowserMultiWidget.php`). It **extends** Entity
Browser's `EntityReferenceBrowserWidget`, so everything it does is layered on the stock
widget's selection/AJAX/access behavior.

## Install & enable

```bash
composer require drupal/entity_browser_multi
drush en entity_browser_multi -y
```

Requires core `^11.4`, PHP `>=8.3`, and `entity_browser:^2`. At least one Entity Browser
config entity must already exist (*Structure → Entity browsers*) or the launcher table is
empty.

## Plugin definition

`#[FieldWidget(...)]` attribute (lines 29–35):

- `id: 'entity_browser_multi'`
- `label: 'Entity browser (multi)'`
- `description: 'One or more native Entity Browser launchers sharing one selection.'`
- `field_types: ['entity_reference']`
- `multiple_values: TRUE`

The class is intentionally **not `final`** so other modules can subclass it (comment lines
25–28). `create()` adds `theme.manager` to the parent's injected services.

## Selecting it

*Structure → Content types → [type] → Manage form display* → set the entity_reference
field's widget to **Entity browser (multi)** → open the gear to configure launchers. There is
**no** dedicated admin/config route.

## Settings form (`settingsForm()`)

- Starts from `parent::settingsForm()`, then hides the stock single-browser select:
  `$element['entity_browser']['#access'] = FALSE` and `['#required'] = FALSE`.
- Loads all `entity_browser` config entities via
  `entityTypeManager->getStorage('entity_browser')->loadMultiple()` (id → label).
- Renders `entity_browsers_drag_drop` as a `#type => table` with a `#tabledrag` order
  handler (group `ebm-entity-browser-weight`). Each row (`buildDragDropRows()`) has an
  *enabled* checkbox, the machine name as `#plain_text`, and a `#type => weight`. Header/help
  text explain that enabled browsers become field buttons, drag sets order, labels come from
  each browser's Modal link text, and the last enabled browser is styled primary.
- `#element_validate` → `validateEntityBrowsersDragDrop()`.

### `validateEntityBrowsersDragDrop()` (static)

Reads the submitted table, coerces each row to `{enabled: bool, weight: int}`, sorts with
`SortArray::sortByWeightElement`, and writes back the normalized rows. It then **derives** the
stock settings for the parent widget:

- `entity_browser` = first enabled browser id (or `''`).
- `additional_entity_browsers` = the remaining enabled ids (`array_values`).
- `create_entity_browser` = `''` (legacy key cleared).

`settingsSummary()` appends `Launchers (@count): a → b → c` (or "none selected").

## Config schema

`config/schema/entity_browser_multi.schema.yml`, type
`field.widget.settings.entity_browser_multi`:

- `entity_browser` (string) — primary browser, derived from the table.
- `additional_entity_browsers` (sequence of string) — the rest, derived.
- `entity_browsers_drag_drop` (sequence keyed by browser id; each `{enabled: bool,
  weight: int}`, `orderby: key`) — the persisted table state.
- `create_entity_browser` (string) — legacy.
- Inherited stock keys: `field_widget_display`, `field_widget_edit`, `field_widget_remove`,
  `field_widget_replace`, `open`, `field_widget_display_settings`
  (`entity_browser.field_widget_display.[%parent.field_widget_display]`), `selection_mode`.

`defaultSettings()` adds `entity_browsers_drag_drop => []`,
`additional_entity_browsers => []`, `create_entity_browser => ''` on top of the parent's.

## Rendering multiple launchers (`formElement()`)

1. `getOrderedEntityBrowsers()` returns the ordered enabled browser ids (from the table, or,
   for legacy configs, from `entity_browser` + `additional_entity_browsers` /
   `create_entity_browser`). If empty, falls back to `parent::formElement()` (plain stock
   widget).
2. Sets the primary via `setSetting('entity_browser', $ordered[0])` and calls
   `parent::formElement()` once to get the base launcher element.
3. Removes the single `entity_browser` element and, for each ordered browser, **clones** the
   base launcher, sets `#entity_browser = $browser_id`, restores its `#process`, and places it
   in an `actions` container (`#type => container`, `entity-browser-multi__add-bar` classes,
   `form-actions`). Keys after the first are `entity_browser_<sanitized id>`. Each launcher is
   decorated with `entity-browser-multi__add-bar-action` (`decorateLauncherElement()`).
4. `#after_build => afterBuildAddBarButtons()` walks the container and, for each launcher's
   `open_modal` button, adds `button` / `entity-browser-multi__add-bar-button` classes; the
   first also gets `#button_type = 'primary'` + `button--primary`.
5. Attaches libraries via `widgetLibraries()`: always `entity_browser_multi/widget`; adds
   `entity_browser_multi/widget.gin` when `activeThemeIsOrExtends('gin')` is TRUE
   (`theme.manager` active theme name or its base-theme extensions).

`form()` also adds the `field--widget-entity-browser-entity-reference` class so it reuses the
stock Entity Browser Sortable CSS.

## Operating notes

- All launchers write to one hidden `target_id`; selection, ordering, edit/remove/replace and
  the modal/AJAX flow are the stock widget's, unchanged.
- Button labels are each browser's own Modal display "link text" — set them on the browser,
  not here.
- No permissions, routes, services, or hooks are added; view/selection access is whatever the
  underlying Entity Browser and its selection display enforce.
- Libraries: `entity_browser_multi.libraries.yml` defines `widget` (CSS) and `widget.gin`
  (CSS, depends on `entity_browser_multi/widget` + `gin/gin_base`).
