<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views exposed filter blocks provides a single block plugin that renders a view display's exposed filter form as a standalone block, so the filters can be placed in any region — decoupled from where (or whether) the view results appear.

---

The module ships one Block plugin, `views_exposed_filter_blocks_block` (category "Views Exposed Filter Blocks", admin label "Views exposed filter block"). You place as many instances as you like from *Block layout*, and each instance is configured with two settings: `view_display` — a `"<view_id>:<display_id>"` string picked from a select of all enabled views/displays (built with `Views::getViewsAsOptions()`) — and `form_state_always_process`, a boolean (default TRUE) that makes the block process submitted input on build. At render time `build()` loads the view, calls `setDisplay()`/`initHandlers()`, and builds core's `\Drupal\views\Form\ViewsExposedForm` against a `FormState` seeded with the view and display, using the GET method with redirects disabled. The block has `getCacheMaxAge() == 0` so filter state is never cached. Unlike the similar [views_block_filter_block](https://www.drupal.org/project/views_block_filter_block), which only works for `block` display plugins and is configured on the view, this module works for **any** display plugin (including `eva`, `page`, `block`, attachments) and is configured entirely on the block. There is no admin settings page (`configure: null`), no permissions, no Drush, and no plugin types — its only persistent state is per-block config stored in each `block.block.<id>` config entity. Typical use: put the exposed filters in a sidebar while an EVA or attachment display shows the results in the main content; disable AJAX on the target view and keep the block and results on the same page so filter values reach the view.

---

- Show a view's exposed filters in a sidebar while the results render elsewhere on the page.
- Add exposed filters to an [EVA](https://www.drupal.org/project/eva) display embedded in an entity, which otherwise has no place for an exposed form.
- Put the filter form in the `highlighted` or `hero` region above the main content region that holds the view.
- Expose filters for an attachment or feed display that cannot render its own exposed form.
- Reuse one set of exposed filters for a view that is embedded in several places on a page.
- Place the search/filter box for a listing in the header region for a site-wide look.
- Separate the exposed filter UI from a `block` display so the filters and the results sit in different regions.
- Give a non-page view (embedded via twig, layout builder, or another module) a working exposed filter form.
- Filter a masonry/slideshow/accordion views style display using filters placed in a different region.
- Configure the block to only submit values to the view (`form_state_always_process` off) rather than display submitted values itself.
- Configure the block to also show and handle submitted values (`form_state_always_process` on, the default).
- Build a dashboard where one filter block drives a results view rendered by a separate mechanism on the same page.
- Add exposed filters to a view rendered inside a paragraph or custom block.
- Place multiple filter blocks, each targeting a different view/display, on the same admin page.
- Move exposed filters out of the results area to satisfy a specific page layout requirement.
- Provide filters for a page whose results come from a `page` display when you want the filters in a fixed region instead of inline.
- Set the block's visibility (paths, roles, content types) via core block visibility so filters only appear where the results do.
- Point the exposed form's action at a different results page using the view's "custom URL" link display option.
- Standardize where filters appear across a site by placing filter blocks in a consistent region.
- Combine with core block layout so filters can be hidden on unrelated pages.
- Filter an embedded view without editing the view display's own "Exposed form in block" setting.
- Deploy the whole configuration as exported config (`block.block.<id>` with `plugin: views_exposed_filter_blocks_block`).
- Prototype filter placement quickly by adding/removing block instances rather than restructuring the view.
