<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding link attributes to image / responsive-image fields

This module has **no formatter plugin of its own**. It extends core's existing `image` and
`responsive_image` field formatters with third-party settings and re-renders them through overridden
Twig templates. All logic lives in `image_link_attributes.module`.

## Install & enable

```bash
composer require drupal/image_link_attributes
drush en image_link_attributes -y
```

Dependencies: core **`image`** and **`link`**. No sub-modules, no permissions, no Drush commands.

## Enable it on a field

1. On a bundle with an **image** or **responsive image** field, go to *Structure → (bundle) →
   Manage display*.
2. Set that field's format to **Image** (or **Responsive image**) and click the gear.
3. In the formatter settings, set **Link image to** = *File* or *Content* (core setting). The custom
   attribute settings are hidden until a link target is chosen (`#states` on the `image_link`
   select).
4. Tick **"Add custom attribute(s) to the link?"** and open **Advanced** to set values.

The settings form is built by `image_link_attributes_field_formatter_third_party_settings_form()`,
which only acts when `$plugin->getPluginId()` is `image` or `responsive_image`.

## Settings (third-party settings under `image_link_attributes`)

Stored on the view display's field component at
`third_party_settings.image_link_attributes`:

| Key | Widget | Meaning |
|---|---|---|
| `extended` | checkbox | Master switch: "Add custom attribute(s) to the link?". Nothing is added unless this is on. |
| `advanced.target` | select | Value for the `target` attribute; options come from config `targets` (`_blank`, `_self`, `_parent`, `_top`) plus a `none` (empty) option. |
| `advanced.<attr>` | textfield | One textfield per attribute defined in config `attributes` (ships `class` and `rel`). Free-text value for that attribute. |
| `alternate_images` | checkbox | "Link to alternate Image Style?" — link the image at an image-style variant instead of the original file (from 8.x-1.8). Hidden when the link target is empty or `content`. |
| `alternate_image_styles` | select | Which image style to link to (`image_style_options(FALSE)`); used only when `alternate_images` is on. |

The offered `target` options and the set of attribute textfields are read from the config object,
so the available attributes are configurable site-wide (see below). Each attribute's label defaults
to `ucfirst(str_replace('-', ' ', $attribute))` and its description to
`Enter value for <attr> attribute` when config leaves them blank.

`image_link_attributes_field_formatter_settings_summary_alter()` adds a "Link Attributes" item list
(and a "Linked Image Style" line) to the Manage display summary, listing each non-empty attribute.

## Config object `image_link_attributes.config`

Defines what editors can choose. Defaults in `config/install/image_link_attributes.config.yml`,
schema in `config/schema/image_link_attributes.schema.yml` (`type: config_object`).

```yaml
targets:
  _blank:  { label: '_blank',  description: 'Load in a new window' }
  _self:   { label: '_self',   description: 'Load in the same frame as it was clicked' }
  _parent: { label: '_parent', description: 'Load in the parent frameset' }
  _top:    { label: '_top',    description: 'Load in the full body of the window' }
attributes:
  class: { label: '',            description: '' }
  rel:   { label: 'Relationship', description: '' }
```

There is **no admin form / route** for this config (the module ships no `*.routing.yml`, even though
`.info.yml` declares `configure: image_link_attributes.config`). To add another attribute (e.g.
`data-gallery`) or another target, edit the config via config import or `drush cset` and clear cache.

## How the attributes reach the markup

`image_link_attributes_preprocess_field()` (hook_preprocess_field) does the work, only for
`#formatter` of `image` or `responsive_image`:

```php
// If there are advanced attributes, get them and assign them.
if ($is_enabled) {
  $advanced_attributes = array_filter($custom_settings['advanced']);
  foreach (Element::children($items) as $child_name) {
    $delta =& $items[$child_name];
    $content =& $delta['content'];
    $link_attributes = $content['#link_attributes'] ?? [];
    $link_attributes = array_merge($link_attributes, $advanced_attributes);
    $content['#link_attributes'] = $link_attributes;
  }
}
```

`array_filter()` drops empty values, so only attributes with a set value are merged. The settings are
re-read from the resolved `EntityViewDisplay::collectRenderDisplay()` component (not just the passed
element), so they apply per view mode.

For the alternate image style, it loads `ImageStyle::load($alternate_image_style)` and sets
`$content['#alternate_path'] = $style->buildUrl($image_file->uri->value)` per item.

`hook_theme()` declares `image_formatter` / `responsive_image_formatter` with extra variables
(`link_attributes`, `alternate_path`), and `hook_theme_registry_alter()` repoints those two theme
hooks at this module's `templates/field/` directory. The templates:

```twig
{% if url %}
  {% if alternate_path|trim is not empty %}
    {{ link(image, alternate_path, link_attributes) }}
  {% else %}
    {{ link(image, url, link_attributes) }}
  {% endif %}
{% else %}
  {{ image }}
{% endif %}
```

(`responsive-image-formatter.html.twig` is identical with `responsive_image` in place of `image`.)

Attribute values are passed as the third argument to core's `link()` Twig function, which wraps them
in Drupal's `Attribute` object — so values are **escaped by core's Attribute handling**, the same as
any core-rendered link. Attribute **names** are fixed by config (`class`, `rel`, plus the `target`
select), not free-form per field.

## Operate it via config (view display)

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_image.third_party_settings.image_link_attributes.extended 1 -y
drush cset core.entity_view_display.node.article.default \
  'content.field_image.third_party_settings.image_link_attributes.advanced.rel' 'lightbox-series' -y
drush cr
```

The field component must also have core's `settings.image_link` set to `file` or `content` for the
anchor (and thus the attributes) to render.

## Gotchas

- Nothing renders unless the **core** `image_link` setting links the image (to file or content) AND
  `extended` is on.
- `alternate_images` is only meaningful when linking to **file** (it is hidden for the `content`
  link target); it rewrites the anchor `href` to the chosen image style's URL.
- No config schema is declared for the per-field third-party settings themselves (only for the
  site-level `image_link_attributes.config`), so strict config-schema checkers may flag the view
  display; the settings still save and work.
