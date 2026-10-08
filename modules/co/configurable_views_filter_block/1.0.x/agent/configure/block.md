# Configure — the block plugin & its settings

## The plugin

- **Block id:** `configurable_views_filter_block_block`
- **Admin label:** "Views Exposed Filter Block (configurable form)"
- **Class:** `Drupal\configurable_views_filter_block\Plugin\Block\ConfigurableViewsExposedFilterBlock`
  (extends core `ViewsExposedFilterBlock`).
- **Deriver:** `Drupal\views\Plugin\Derivative\ViewsExposedFilterBlock` (the SAME deriver core
  uses). A derivative therefore exists for each view display whose exposed form is set to show in
  a block. Full derivative id: `configurable_views_filter_block_block:<view_id>-<display_id>`.

### Prerequisite on the view

The block only appears for a display that has **"Exposed form in block: Yes"**
(`display_options.exposed_block: true`) and has exposed filters. Set that in the view's
*Advanced → Exposed form in block* option first, otherwise no derivative is generated.

## Settings (stored in the block config entity `settings`)

Schema type `configurable_views_filter_block`:

| Key | Type | Meaning |
|---|---|---|
| `visible_filters` | sequence of string | Exposed-filter **identifiers** to keep visible. Any exposed filter NOT listed is hidden. Empty = none of the filters shown. Identifiers are the exposed filter's `identifier` (e.g. `title`, `uid`), listed on the form as `Label (identifier)`. |
| `no_groups` | boolean | Convert collapsible `details` filter groups into plain containers. |
| `no_reset` | boolean | Hide the exposed-form reset button (option shown only if the view enables a reset button). |
| `no_sort` | boolean | Hide exposed sort fields (`sort_by` / `sort_order`) (option shown only if the view exposes sorts). |
| `no_pager` | boolean | Hide exposed pager fields (`items_per_page` / `offset`) (option shown only if the view exposes the pager). |

On the block form these appear as a **Visible filters** checkboxes group plus an **Other
visibility options** checkboxes group (`form_options`) that maps to the four booleans.

## Configure via the UI

*Block layout → Place block →* choose **Views Exposed Filter Block (configurable form)** for your
view/display, then tick the filters to keep and any of the visibility options.

## Configure via config / code

```php
\Drupal\block\Entity\Block::create([
  'id' => 'my_view_filters',
  'plugin' => 'configurable_views_filter_block_block:my_view-page_1',
  'theme' => 'olivero',
  'region' => 'sidebar_first',
  'settings' => [
    'id' => 'configurable_views_filter_block_block:my_view-page_1',
    'label' => 'Filters',
    'label_display' => '0',
    'visible_filters' => ['title' => 'title'], // keep only the "title" filter
    'no_groups' => FALSE,
    'no_reset' => TRUE,   // hide reset button
    'no_sort'  => TRUE,   // hide sort
    'no_pager' => FALSE,
  ],
  'visibility' => [],
])->save();
```

Because hiding uses a CSS wrapper (`hidden-exposed-filter`) rather than `#access`, hidden filter
values are still submitted — the point is presentation, letting you spread one view's exposed
form across multiple block instances (each gets a unique regenerated form `#id`).
