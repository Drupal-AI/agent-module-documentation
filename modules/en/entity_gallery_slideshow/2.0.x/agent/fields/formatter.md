<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Gallery" formatter (`entity_gallery_slideshow_view`)

`src/Plugin/Field/FieldFormatter/EntityGalleryFormatter.php`, extending core
`EntityReferenceEntityFormatter`.

## Install & enable

```bash
composer require drupal/entity_gallery_slideshow
drush en entity_gallery_slideshow -y
```

No module dependencies (info.yml has no `dependencies`); front-end depends on the Swiper CDN
library (see [../routes/slideshow.md](../routes/slideshow.md)).

## Enable it on a field

Applies to **`entity_reference`** fields only (`field_types = { "entity_reference" }`).
`isApplicable()` additionally requires the reference's `target_type` to have at least one view
mode (`entity_display.repository::getViewModes()` non-empty), plus the parent
`EntityReferenceEntityFormatter` applicability. So it targets reference fields to view-mode-able
entities (media, nodes, etc.).

UI: *Structure → (bundle) → Manage display* → set the entity_reference field's format to
**Gallery** → gear icon for the settings below.

## Settings (`defaultSettings()` / `settingsForm()`)

| Key | Default | Meaning |
|---|---|---|
| `gallery_view_mode` | `default` | View mode used to render each item in the **grid gallery**. Select of `getViewModeOptions(target_type)`, required. |
| `slideshow_view_mode` | `default` | View mode used to render each slide in the **modal slideshow**. Required. |
| `modal_title` | `t('Slideshow')` | Text used as the modal dialog title. Required. |
| `pager` | `TRUE` | Adds a Swiper fraction pagination element to the slideshow. |
| `progress_bar` | `FALSE` | Adds a Swiper scrollbar element to the slideshow. |

(plus inherited `EntityReferenceFormatterBase::defaultSettings()`, e.g. `link`.)
`settingsSummary()` lists the two view modes, the modal title, and pager/progress-bar state on the
Manage-display summary line. There is **no config schema** shipped for these keys.

## Gallery render path (`viewElements()`)

1. `$entities = $this->getEntitiesToView($items, $langcode)` — core's access-aware resolver (only
   items the viewer may see; sets `_referringItem`).
2. `modal_title` is passed through `Xss::filter()`, `/` → `_`, then `urlencode()` (so it can travel
   in the URL path).
3. Builds a `#theme => 'item_list'` with class `entity-gallery`, attaching library
   `entity_gallery_slideshow/entity_gallery_slideshow` (CSS) and `core/drupal.dialog.ajax`.
4. For each referenced entity: resolves the **parent entity** via
   `$entity->_referringItem->getParent()->getParent()->getEntity()`, renders the entity with the
   `gallery_view_mode` view builder, and wraps that render in a `Link` to route
   **`entity_gallery_slideshow.slideshow.nojs`** with attributes `class="dialog use-ajax"`,
   `data-dialog-type="dialog"`, `data-slide=<delta>`. Route params carry
   `entity_type`, `entity_id`, `field_name`, `slide_id` (the delta), `view_mode`
   (= `slideshow_view_mode`), `pager`, `progress_bar`, `modal_title`.
5. Each list item is a container (`entity-gallery-item` / `entity-gallery-content`) with the
   entity's own cache tags.

So the clicked link is a `use-ajax` dialog link; core's dialog.ajax turns the response of the
matching AJAX route into a modal. The `.nojs` path is the graceful-degradation target when JS is
off. The actual slideshow markup and Swiper init are documented in
[../routes/slideshow.md](../routes/slideshow.md).

## Config example (view display)

```yaml
# core.entity_view_display.node.article.default
content:
  field_gallery:
    type: entity_gallery_slideshow_view
    label: hidden
    settings:
      gallery_view_mode: teaser
      slideshow_view_mode: full
      modal_title: 'Gallery'
      pager: true
      progress_bar: false
```

## Notes

- You can mix bundles in one field (e.g. image + document media); each is rendered through its own
  view mode.
- Styling is intentionally minimal (`css/entity-gallery-slideshow.css`); the README states theming
  is the site's responsibility.
