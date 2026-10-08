<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering icons: render/form elements, service, theme

Icons render as **CSS icon-font `<span>` elements** — never inline SVG. The `icon` template is
`<span {{ attributes }}></span>`; the chosen IconLibrary plugin's `build()` adds the icon's CSS
class(es) to `#attributes['class']` and attaches the icon set's stylesheet library. Class values are
escaped by Drupal's `Attribute` object.

## Render element `#type => 'icon'`

`Drupal\icons\Element\Icon` (`RenderElement('icon')`). Properties:

- `#icon_set` — an icon set id (string) or a loaded `IconSetInterface`.
- `#icon_name` — the icon name within that set.
- `#attributes` — extra HTML attributes for the `<span>`.
- `#icon_id` — alternative single-string form `"set:name"` (see `buildRenderArray()`).

```php
$build['icon'] = [
  '#type' => 'icon',
  '#icon_set' => 'my_set',      // config entity id
  '#icon_name' => 'home',
];
// or from a stored field value "my_set:home":
$build['icon'] = \Drupal\icons\Element\Icon::buildRenderArray($value);
```

`preRenderIcon()` splits `#icon_id` into set/name, loads the `icon_set` entity if needed, gets its
plugin and delegates to `$plugin->build()`. If the set or name is empty/unknown it returns the bare
element (renders nothing meaningful) — safe no-op.

## Form/select element `#type => 'icon_select'`

`Drupal\icons\Element\IconSelect` extends core `Select`. Adds a themed picker: it builds an
`item_list` of clickable glyphs from `#options` (each option keyed `set:name`), attaches the
`icons/icon_picker` library and the per-set icomoon libraries, and the `icon_select` theme wrapper
(`icon-select.html.twig`) overlays the custom dropdown on the native `<select>`. `js/IconPicker.js`
(`Drupal.behaviors.iconsPicker`) drives selection and mirrors the choice back into the `<select>`.
List-item markup is escaped with `Html::escape()`.

## Form element `#type => 'font_icon_picker'`

Submodule `icons_iconpicker`. `FontIconPickerElement` extends `Textfield`; a process callback pushes
every icon's CSS classes/tags into `drupalSettings.FontIconPicker` and the jQuery fontIconPicker JS
turns the hidden textfield into a searchable picker. Stored/returned value is the icon id `set:name`
(the element validates it against the known icon list). Themes: `grey`/`darkgrey`/`bootstrap`/`inverted`.

## Service `icons.manager` (`Drupal\icons\IconsManager`)

- `getIconOptions(): array` — options for every icon across all icon sets, `set:name => title`;
  grouped by set label when >1 set exists. Used by the field widgets and menu form alters.
- `getMenuItemIcons(MenuLinkInterface): array` / `processMenuItems(array &$items): array` /
  `formatMenuIconItem(array $item, array $icons): array` — see [../hooks/menu-icons.md](../hooks/menu-icons.md).

## Theme hooks & suggestions (from `ThemeHooks`)

| Theme hook | Template | Variables |
|---|---|---|
| `icon` | `icon.html.twig` | `icon_set`, `attributes` |
| `icon_select` | `icon-select.html.twig` | render element (`icon_select`, `icon_picker`) |

`hook_theme_suggestions_icon()` adds `icon__{plugin_id}` and `icon__{icon_set_id}`, so a theme can
override per provider or per set (e.g. `icon--fontawesome.html.twig`).
