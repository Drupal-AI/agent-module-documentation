<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Iconify Field (iconify_field) — agent index

Icon **field type + picker widget + inline-SVG formatter** backed by the Iconify icon
sets, plus a **`#type => iconify_field` form element**, an **`iconify_field()` Twig
function**, an anonymous **JSON API** that backs the picker, and the bundled
**`iconify_field_ckeditor`** submodule (CKEditor 5 button that inserts icons in body text).
Depends only on core `field`. Version **1.2.1**.

**Core requirement is `^11.2` — the main module will NOT install on Drupal 10.** (The
`iconify_field_ckeditor` submodule alone declares `^10.1 || ^11`.) Check this first.

Key mechanism:
- **Icons come from the `iconify/json` Composer package on disk, NOT from Iconify's API.**
  `Drupal\iconify_field\Service\IconResolver` (service `iconify_field.icon_resolver`) reads
  collection JSON via `Iconify\IconsJSON\Finder`, inlines the SVG `body` into a `svg` render
  array (default `width/height = 1em`, so it inherits font size and `currentColor`), and
  caches it in `cache.render`. No runtime third-party request. Updating icon sets = a
  Composer operation. The SVG body is trusted, bundled data — not user input.
- Value scheme is `collection:name` (e.g. `mdi:home`). An unresolvable name **falls back to
  a `<span>` containing the raw name** (via `#type => iconify_icon`) rather than erroring.

Solution docs:
- **Add / configure the icon field type, its storage columns & per-item options** → [fields/field-type.md](fields/field-type.md)
- **Configure the Icon Picker widget (default & allowed collections, accessibility)** → [fields/widget.md](fields/widget.md)
- **Render the icon (the formatter, the `iconify_icon` render element, sizing/classes/ARIA)** → [fields/formatter.md](fields/formatter.md)
- **Use the developer surfaces: `iconify_field()` Twig fn, `#type => iconify_field` element, the JSON API, IconResolver service, CKEditor submodule** → [api/api.md](api/api.md)

Key facts:
- Field type id: `iconify_field_icon` (`Plugin\Field\FieldType\IconItem`); default widget
  `iconify_field_icon_picker`; default formatter `iconify_field_icon_formatter`.
- Storage columns: `value` (text, the `collection:name`), `classes` (varchar 255),
  `decorative` (tiny int, default 1), `arialabel` (text). `isEmpty()` = `value` empty.
- No permissions, no drush commands, no settings page (`configure` is null). Provides config
  schema (`field.widget.settings.iconify_field_icon_picker`).
- Elements: form element `#type => iconify_field` (`Element\IconifyField`, opens the picker
  modal); render element `#type => iconify_icon` (`Element\IconifyIcon`, renders one icon
  through the Twig function).
- Twig: `iconify_field('collection:name', attributes = [])` → SVG render array.
- Routes (all in `iconify_field.routing.yml`): `iconify_field.icon_picker`
  (`/admin/iconify_field/menu-icons/picker`, `_permission: access administration pages`) hosts
  the Vue picker app; `iconify_field.api.collections` (`/api/iconify_field/collections`) and
  `iconify_field.api.icons` (`/api/iconify_field/icons/{collection}`) are **`_access: TRUE`
  (anonymous)** and return the bundled icon catalog as JSON.
- Picker UI is a **Vue 3 app** compiled to `frontend/dist/index.js` (attached via library
  `iconify_field/icon-picker`); it fetches the JSON API and dispatches an
  `iconify-field-pick-icon` event handled by `js/pick-icon.js`.
- Submodule `iconify_field_ckeditor`: CKEditor 5 plugin (`iconify_field_ckeditor_iconify_field`)
  inserts `<span data-icon="collection:name" …>`; its controller
  `/api/iconify_field_ckeditor/icon/{icon}` (`_access: TRUE`) returns one rendered SVG with
  `Content-Type: image/svg+xml`.
- Optional integration plugins (load only if the host module is present): GraphQLCompose field
  type (`iconify_field_icon` → SDL `String`) and SingleContentSync field processor.
