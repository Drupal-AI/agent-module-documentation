<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Block Exposed Filter Blocks unlocks the "Exposed form in block" option for Views **block** displays, so a block display's exposed filters can be placed as their own separate block anywhere on the page.

---

Core Views only offers *Exposed form in block* on displays whose display plugin returns `TRUE` from `usesExposedFormInBlock()` — in practice page displays. This module swaps the class behind the `block` display plugin via `hook_views_plugins_display_alter()`, pointing it at `Drupal\views_block_filter_block\Plugin\views\display\ViewsBlockFilterBlockPluginDisplayBlock`, which extends **ctools_views**' `Block` display plugin and overrides three methods: `usesExposedFormInBlock()` returns `TRUE`, `usesExposed()` falls back to `DisplayPluginBase::usesExposed()` (instead of the block plugin's AJAX-only behaviour), and `getLinkDisplay()` returns `NULL` when the configured link display no longer exists. Setting *Advanced → Exposed form in block* to **Yes** stores `exposed_block: true` in that display's `display_options`, which makes core's `views_exposed_filter_block` deriver expose a block plugin with the id `views_exposed_filter_block:<view_id>-<display_id>`. You then place that block from *Structure → Block layout* like any other. The module has no settings, no permissions, no config schema and no configure route — installing it is the whole setup. It also implements `hook_form_views_exposed_form_alter()` so the exposed form's Reset button is hidden when the form has no visible children (and never re-enabled if something else already disabled it). Because it depends on `ctools:ctools_views`, an update hook (`views_block_filter_block_update_8001()`) installs `ctools_views` for sites upgrading from an older release.

---

- Place a Views block's exposed filters in a sidebar while the results block sits in the main content region.
- Put a search/filter form above a listing block that lives in a completely different region.
- Give a block-display view the same "filters in a block" behaviour a page display gets for free.
- Show one filter form controlling a results block rendered in a page footer.
- Reuse a single exposed filter block across several regions of a layout.
- Combine with Layout Builder: place the exposed filter block and the view block in separate sections.
- Build a dashboard where filter controls sit in a fixed header and results scroll below.
- Avoid converting a block display into a page display just to get an exposed form block.
- Expose a date-range filter as a standalone widget above a calendar-style views block.
- Let editors place the filter block only on selected pages using core block visibility conditions.
- Provide a taxonomy filter block for a "related content" views block.
- Add exposed sort controls (Sort by / Order) as a block separate from the listing.
- Hide the Reset button automatically when an exposed form ends up with no visible elements.
- Keep exposed filter state working with AJAX-enabled views blocks.
- Use ctools_views' per-block-instance display settings together with an exposed filter block.
- Build a faceted-looking UI without installing a facets stack.
- Place the filter block in a modal/off-canvas region while results render inline.
- Give a paginated views block a filter form that is not repeated by the pager.
- Migrate a Drupal 7 "exposed form in block" setup to Drupal 10/11.
- Expose a fulltext search filter block for a Search API view rendered as a block.
- Let a theme style the filter form independently of the results block markup.
- Provide multiple views blocks on one page, each with its own exposed filter block.
- Configure everything through config export (`exposed_block: true` plus a `block.block.*` entry).
- Audit which displays have the option on with `drush config:get views.view.<id>`.
- Remove the module's effect simply by setting *Exposed form in block* back to **No**.
