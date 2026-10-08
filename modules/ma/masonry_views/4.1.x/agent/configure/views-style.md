# Use the Masonry Views style

Masonry Views is a **Views format**. There is no settings page — you configure it per view
display.

## Via the Views UI

1. Edit a view (`/admin/structure/views/view/<id>`).
2. In the display, click **Format** → **Settings** and choose **Masonry**.
3. In the Masonry fieldset, set the layout options (gutter width, resizable, animated, etc.).
4. Pick a **Row style** (fields or rendered entity) as usual, and Save.

## In config (`views.view.*` display)

The style lives on the display's `display_options.style`:

```yaml
display_options:
  style:
    type: masonry
    options:
      layoutColumnWidth: ''      # selector/width for a column; '' = auto from first item
      gutterWidth: '0'           # gap between items (px)
      isLayoutResizable: true
      isLayoutAnimated: true
      layoutAnimationDuration: 500
      isLayoutFitsWidth: false
      isLayoutRtlMode: false
      isLayoutImagesLoadedFirst: true
      isLayoutImagesLazyLoaded: false
      imageLazyloadSelector: lazyload
      imageLazyloadedSelector: lazyloaded
      stampSelector: ''
      isItemsWidthForce: true
      isItemsPositionInPercent: false
      extraOptions: {}
  row:
    type: 'entity:node'          # or 'fields'
```

These option keys and their defaults are defined by the **masonry** module's
`masonry.service->getMasonryDefaultOptions()` — Masonry Views just exposes them in the Views
options form (`buildOptionsForm()` calls `masonry.service->buildSettingsForm()`), so the value
set is whatever that service validates.

Read/set programmatically:

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display = &$view->getDisplay('default');
$display['display_options']['style']['type'] = 'masonry';
$display['display_options']['style']['options']['gutterWidth'] = '20';
$view->save();
```

```bash
drush cget views.view.my_view display.default.display_options.style
```

## Rendered markup & theming

- Theme hook `views_view_masonry`; template `views-view-masonry.html.twig`.
- Each result row is wrapped as `<div class="masonry-item …">` (plus any per-row class).
- The rows container gets `data-drupal-masonry-layout` and a class
  `masonry-layout-<clean_view_id>`; with grouping, each group also gets `masonry-group-<n>`.
- `masonry_views_preprocess_views_view_masonry()` calls
  `masonry.service->applyMasonryDisplay($variables, '.masonry-layout-<id>', '.masonry-item', $options, [...cache tags])`
  to attach the jQuery Masonry library and settings.

If the jQuery Masonry library is not installed, the options form shows "These options have been
disabled as the jQuery Masonry plugin is not installed." and no layout JS is attached.
