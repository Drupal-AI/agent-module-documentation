# Configure the Colorbox Inline filter

No dedicated admin page. Configuration is the per-text-format filter setting.

## Enable it

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`) and edit a format (e.g. Full HTML).
2. Check **Colorbox Inline Text Filter** under *Enabled filters*.
3. (Optional) In *Filter settings* set **CSS classes** (`css_classes`) — space-delimited classes applied to
   the generated `<a>`. Default `colorbox`.
4. Save. Images in content using that format now open in Colorbox.

Filter id: `ckeditor_colorbox_inline`. Config path in the format entity:
`filters.ckeditor_colorbox_inline` (schema `filter_settings.ckeditor_colorbox_inline`, one key
`css_classes`).

## Set it with Drush

```php
// drush php:eval — enable the filter on the "full_html" format with default classes.
$f = \Drupal\filter\Entity\FilterFormat::load('full_html');
$f->setFilterConfig('ckeditor_colorbox_inline', [
  'status' => TRUE,
  'weight' => -10,
  'settings' => ['css_classes' => 'colorbox'],
])->save();
```

## What it does to the markup

For each `<img>` in the text, unless its `class` attribute contains the substring `noColorbox`, the filter
wraps it:

```html
<!-- before -->
<img src="/sites/default/files/photo.jpg" alt="Photo">
<!-- after -->
<a href="/sites/default/files/photo.jpg" class="colorbox" data-colorbox-gallery="ckeditor-colorbox-inline">
  <img src="/sites/default/files/photo.jpg" alt="Photo">
</a>
```

- The link `href` is taken from the image's own `src`.
- All wrapped images share `data-colorbox-gallery="ckeditor-colorbox-inline"`, so they form **one Colorbox
  gallery** the visitor can page through.
- Add class `noColorbox` to any `<img>` to exclude it.

## Notes

- It is a `TYPE_TRANSFORM_IRREVERSIBLE` filter applied at render/display time, so it affects every `<img>`
  in the field regardless of how it was inserted (CKEditor, pasted HTML, migration).
- Colorbox's own assets are attached site-wide via `hook_page_attachments`; the actual lightbox styling and
  options come from the Colorbox module's configuration.
- Order matters only relative to other filters; the default weight is -10 (runs early).
