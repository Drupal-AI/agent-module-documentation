<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Block renders several Facets (and Facets Summary blocks) inside a single Drupal block, so you can place one "Facets Block" in a region instead of placing each facet block individually.

---

The module provides one Block plugin, **`facets_block`** (`Drupal\facets_block\Plugin\Block\FacetsBlock`, admin label "Facets Block"), and depends on the Facets module. You place it on the Block layout page and, in its block form, tick which facets to include from the list of enabled facets (each option is keyed `facet_block:<facet_id>` for a facet or `facets_summary_block:<facet_id>` for a Facets Summary). At build time it instantiates each selected facet's own block plugin, collects the render output, optionally drops facets that are empty, injects a unique CSS class per facet (`facet-block--<id>`), and renders everything through the `facets_block` theme hook (`templates/facets-block.html.twig`). Its settings (stored in the block config entity under `settings`) are: **show_title** (show each facet's title, default TRUE), **exclude_empty_facets** (skip facets with no results, default TRUE), **hide_empty_block** (don't render the block at all when no facets are available, default FALSE), **add_js_classes** (attach a pre-render that adds JS-friendly classes, default FALSE), and **facets_to_include** (the array of selected facet ids). The block is uncacheable (`UncacheableDependencyTrait`). A `hook_facets_block_facets_alter()` hook lets other modules add or change entries in the facets array, and two pre-render helpers (`AddJsClasses`, `AddCssClasses`) implement the JS-class and hide-empty behaviors. There is no module settings form, configure route, permissions, or Drush.

---

- Place all search facets in one sidebar block instead of many separate blocks.
- Build a combined "Filters" panel for a Search API results page.
- Group brand, color, and price facets into a single tidy block.
- Include a Facets Summary alongside facets in the same block.
- Hide the whole filter block when a search returns no results (`hide_empty_block`).
- Automatically drop individual facets that have no available options (`exclude_empty_facets`).
- Show or hide the per-facet titles inside the combined block (`show_title`).
- Add JS-friendly CSS classes for custom front-end behavior (`add_js_classes`).
- Reorder or curate which facets appear by selecting them in the block form.
- Reduce block-layout clutter on faceted-search landing pages.
- Present a consistent filter UI across multiple pages by reusing one block config.
- Style each facet distinctly using the injected per-facet CSS classes.
- Add a custom "Home page" or reset link to the facets array via the alter hook.
- Place the combined facets block in a modal/off-canvas filter drawer.
- Keep an e-commerce category page's filters in a single, themeable container.
- Provide a mobile-friendly single filters block that collapses cleanly.
- Combine facets from one facet source into a compact panel.
- Override the block's Twig template for a bespoke filter layout.
- Swap the set of included facets per environment via exported block config.
- Avoid empty-facet noise on sparse result sets.
- Give themers one wrapper (`facets_block`) to target instead of many facet blocks.
- Reuse the same curated facet set on several displays.
