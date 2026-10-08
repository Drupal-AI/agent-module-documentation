# Developer surfaces: Twig function, form element, service, JSON API, CKEditor submodule

All icon data comes from the on-disk **`iconify/json`** Composer package (accessed via
`Iconify\IconsJSON\Finder`) — there is no outbound HTTP call to Iconify anywhere in this module.

## `iconify_field()` Twig function

Provided by `Drupal\iconify_field\Twig\Extension\IconifyField` (service
`iconify_field.twig.IconifyField`). Embed a single icon in any template:

```twig
{{ iconify_field('mdi:account') }}
{{ iconify_field('tabler:home', { class: 'my-icon', width: '2em', height: '2em' }) }}
```

Signature: `iconify_field(?string $field, array|Attribute $attributes = [])`. It calls
`IconResolver::getIcon($field, $attributes)` and returns a render array (an `svg` html_tag, or
the fallback `span` for an unknown/empty name). See
[../fields/formatter.md](../fields/formatter.md) for the resolver details.

## `#type => iconify_field` form element

Class: `Drupal\iconify_field\Element\IconifyField` (`@FormElement("iconify_field")`). Reuse the
icon picker in any custom form:

```php
$form['icon'] = [
  '#type' => 'iconify_field',
  '#default_collection' => 'mdi',      // or NULL → first collection pre-selected
  '#collections' => ['mdi', 'tabler'], // or [] → all collections allowed
  '#default_value' => 'mdi:user',      // stored 'collection:name'
];
```

Theme `input__iconify_field` (`templates/input--iconify-field.html.twig`) renders a hidden text
input holding the value, a live SVG preview, and "Pick an icon" (modal to route
`iconify_field.icon_picker`) / "Clear icon" buttons. `preRenderIconifyField()` attaches
`core/drupal.dialog.ajax`, `iconify_field/icon-preview` and `iconify_field/icon-picker`.

## `IconResolver` service (`iconify_field.icon_resolver`)

`Drupal\iconify_field\Service\IconResolver implements IconResolverInterface`:

| Method | Returns | Purpose |
|---|---|---|
| `getIcon(?string $name, array\|Attribute $attributes = [], bool $autosize = FALSE)` | render array | Build the SVG (or fallback span) render array; caches in `cache.render`. `$autosize` = use native pixel size instead of `1em`. |
| `getIconifyCollections()` | array | `category => [id => "Name - License"]` map of all bundled collections (from `Finder::collections()`). Used by widget/CKEditor config selects. |
| `loadCollection(string $name)` | array | Decode a collection's JSON (`Finder::locate($name)`); empty array if missing. Statically cached per request. |

## JSON API routes (`iconify_field.routing.yml`)

| Route | Path | Access | Returns |
|---|---|---|---|
| `iconify_field.icon_picker` | `/admin/iconify_field/menu-icons/picker` | `_permission: access administration pages` | The Vue picker app page (form `IconifyFieldIconPickerForm`, theme `iconify_field_icon_picker`). |
| `iconify_field.api.collections` | `/api/iconify_field/collections` | **`_access: TRUE`** | `{error, collections}` — all bundled collections, optionally filtered by a `?collections=a,b` query. |
| `iconify_field.api.icons` | `/api/iconify_field/icons/{collection}` | **`_access: TRUE`** | `{error, icons}` — array of `collection:name` ids for that collection; `{error:'Collection not found', icons:[]}` if unknown. |

Controller: `Drupal\iconify_field\Controller\IconifyFieldApiController`. The two `/api/` routes
are **anonymous by design** — they only serve the public, bundled icon catalog (no site data),
and back the client-side picker. The `{collection}` param is a single path segment
(`[^/]+`), so it cannot contain `/`; `Finder::locate()` appends `.json` and reads from the
package's `json/` directory.

## The picker front end

- `iconify_field.icon_picker` renders `<div id="iconify-field--app">`; library
  `iconify_field/icon-picker` loads `js/pick-icon.js` + the compiled Vue 3 app
  `frontend/dist/index.js` (source in `frontend/src`, a Vite/Vue/TypeScript project).
- The app fetches the JSON API, and on selection dispatches an `iconify-field-pick-icon` event
  carrying `{ text: 'collection:name', icon: '<svg…>' }`.
- `js/pick-icon.js` writes that into the field's hidden input + inline preview, and also wires
  the "Clear icon" button.
- A `dev_mode` (env var `ICONIFY_FIELDS_DEV_MODE`) swaps in a Vite dev-server `<script>` for
  local frontend development.

## Submodule `iconify_field_ckeditor` (CKEditor 5 icons)

Adds a CKEditor 5 toolbar button so editors insert icons into body text. Declares
`^10.1 || ^11`, depends on `iconify_field` + `ckeditor5`.

- Plugin config `iconify_field_ckeditor_iconify_field` (`iconify_field_ckeditor.ckeditor5.yml`),
  PHP `Plugin\CKEditor5Plugin\IconifyField` (configurable: `default_collection`, `collections`,
  same collection selects as the field widget). Allowed markup is `<span>` with
  `class`/`data-icon`/`aria-hidden`/`aria-label`/`role="img"`; icons are stored in the text as
  `<span data-icon="collection:name" …>`.
- Controller route `iconify_field_ckeditor.api.icons`
  (`/api/iconify_field_ckeditor/icon/{icon}`, **`_access: TRUE`**) →
  `IconifyFieldCkeditorApiController::icon()` calls `IconResolver::getIcon($icon, [], TRUE)`
  (autosize) and returns the rendered SVG with `Content-Type: image/svg+xml`. The CKEditor JS
  uses this URL to preview an icon inside the editor.
- The editing-view JS (compiled `js/build/IconifyFieldPlugin.js`, source under
  `js/ckeditor5_plugins/`) provides the toolbar UI, the insert command and the options form.
