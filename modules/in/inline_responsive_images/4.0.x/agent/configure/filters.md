# Configure — enable the filters & choose allowed styles

There is **no module settings page** (`configure: null`). Everything is configured on a
**text format** (`filter.format.<format>`), on the *Text formats and editors* admin page
(`/admin/config/content/formats`).

## The two filters

| Filter id | Title | Needs | Attribute it consumes |
|---|---|---|---|
| `filter_imagestyle` | Display image styles | `image` | `data-image-style` |
| `filter_responsive_image_style` | Display responsive images | `responsive_image` | `data-responsive-image-style` |

Each filter's settings form shows checkboxes of the site's (responsive) image styles; the
ones you tick become the choices offered in the editor.

## Where the setting is stored

Config entity: `filter.format.<format>` → per-filter under `filters`:

```yaml
filters:
  filter_imagestyle:
    id: filter_imagestyle
    provider: inline_responsive_images
    status: true
    weight: 100
    settings:
      image_styles:              # map of style_id: style_id; unchecked entries are 0
        thumbnail: thumbnail
        large: large
```

The responsive filter is identical but `settings.image_styles` holds **responsive** image
style ids (e.g. `narrow: narrow`, `wide: wide`).

## Via the UI

1. Go to *Configuration → Content authoring → Text formats and editors*.
2. Configure a format that uses the **CKEditor 5** editor and has the image button in its
   toolbar.
3. Enable **Display image styles** *or* **Display responsive images** and tick the styles
   to expose.
4. Ordering caveat (from the module help/README): if the *Restrict images to this site* or
   *Track images uploaded via a Text Editor* filters are on, put this module's filter
   **after** them, or leave those off — otherwise the transform can be undone.
5. Save. Editors now get a style dropdown in the image balloon toolbar.

## Scriptable (drush php:eval)

```php
$ff = \Drupal\filter\Entity\FilterFormat::load('basic_html');
$cfg = $ff->filters('filter_imagestyle')->getConfiguration();
$cfg['status'] = TRUE;
$cfg['settings']['image_styles'] = ['thumbnail' => 'thumbnail', 'large' => 'large'];
$ff->setFilterConfig('filter_imagestyle', $cfg)->save();
```

Read it back:

```bash
drush cget filter.format.basic_html filters.filter_imagestyle.settings.image_styles
```

## Config schema

`config/schema/inline_responsive_images.schema.yml` types both filters' settings as
`inline_images_filters` → `image_styles` is a `sequence` of style machine names.

## Do not mix the two filters on one format

The editor-dialog form alter (`inline_responsive_images.module`) intentionally **removes**
the image-style selector when the responsive-image filter is also active — a `<picture>`
mapping should not be double-wrapped in a plain image style. Pick one per format.
