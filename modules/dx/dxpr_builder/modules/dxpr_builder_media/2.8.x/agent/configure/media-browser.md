<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# The DXPR media browser

Enabling the submodule installs the config from `config/install/`; there is nothing else to set
up except pointing DXPR Builder at it.

## Shipped config
- `entity_browser.browser.dxpr_builder_media_modal` — the Entity Browser (modal) DXPR opens to
  pick media.
- `views.view.dxpr_builder_media` — the View that lists media as a selectable grid inside the
  browser.
- `image.style.dxpr_builder_media_thumbnail` — thumbnail style for the grid.

## Activate it in DXPR Builder
DXPR's settings form (`admin/dxpr_studio/dxpr_builder/settings`, "Media" section) lists every
available entity browser (when `entity_browser` is enabled) plus **Media Library**. Choosing the
DXPR browser writes the entity browser id into the parent config object:
```
dxpr_builder.settings:media_browser = 'dxpr_builder_media_modal'
```
Set it programmatically:
```php
\Drupal::configFactory()->getEditable('dxpr_builder.settings')
  ->set('media_browser', 'dxpr_builder_media_modal')->save();
```
`media_browser = ''` means basic file upload; `'media_library'` uses core Media Library. Read the
current choice with `drush cget dxpr_builder.settings media_browser`.

## Theming glue (`dxpr_builder_media.module`)
- `hook_preprocess_views_view()` — for the `dxpr_builder_media` view, attaches
  `dxpr_builder_media/gin_style` when the active (or base) theme is Gin, otherwise
  `dxpr_builder_media/claro_style`, plus `dxpr_builder_media/view`.
- `hook_library_info_alter()` — adds core Backbone (`core/backbone` or `core/internal.backbone`)
  as a dependency of the view's JS library.

The module is `hidden: true`, so it will not appear on the normal Extend UI; enable via
`drush en dxpr_builder_media`. No permissions, schema, routes, or Drush.
