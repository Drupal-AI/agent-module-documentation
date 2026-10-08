<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Reference Field Filter adds an `exposed_filters` setting plugin to the Views Reference (viewsreference) field, letting content editors set values for a referenced view's exposed filters right on the entity edit form and optionally show that exposed form on the rendered page.

---

The module extends the [Views Reference](https://www.drupal.org/project/viewsreference) field by providing a single `ViewsReferenceSetting` plugin with id `exposed_filters` (label "Exposed Filters - editor view"). Once you enable that setting on a viewsreference field (via the field's `enabled_settings`), the field widget renders the referenced view's exposed-filter widgets inline, so an editor placing the view can pre-set filter values (category, date, search term, etc.) without touching the view itself. It also adds a "Show Filters on Page" checkbox (stored key `vr_exposed_filters_visible`): when unchecked, the editor's filter values are forced as fixed exposed input and the exposed form is hidden on the page (`exposed_block` forced TRUE); when checked, the visitor sees the live exposed form and can override. At render time the plugin's `alterView()` maps the stored values onto the view's exposed input, and `alterFormField()` builds the per-handler widgets by rendering the view's real exposed form. The module has no config UI, no permissions, no Drush, and its only service is a small utility (`viewsreference_filter.views_utility`) that loads and initialises the referenced view's executable so its handlers can be introspected.

---

- Let editors pick a category value for an embedded "Latest articles" view without editing the view.
- Pre-filter a referenced view of events to a chosen event type per placement.
- Embed the same view in several places, each pre-set to a different exposed-filter value.
- Give editors a "Show Filters on Page" toggle so visitors can further refine an embedded listing.
- Hide the exposed form but still force a fixed filter value on a placed view.
- Pre-set a search term on an embedded search-style view for a landing page.
- Configure a viewsreference field so editors control an exposed date-range filter.
- Let a paragraph that references a view carry its own exposed-filter selections.
- Reuse one generic "products by taxonomy" view across many nodes with different term filters.
- Allow non-technical editors to steer view output through familiar filter widgets.
- Combine with viewsreference display selection so editors choose display and filter values together.
- Pre-populate an exposed "author" filter on an embedded activity feed.
- Set default exposed values while still letting visitors change them on the page.
- Drive a "related content" block view by an editor-chosen tag.
- Provide curated, per-placement filtering without cloning views.
- Expose only the filters the referencing field enables, keeping editor UI focused.
- Let editors force a status filter (e.g. only published) on a placed view.
- Build editorially-controlled dashboards from a single parameterised view.
- Present a referenced view filtered to the current section via an editor selection.
- Use with Layout Builder / Paragraphs to place filtered views in regions.
- Keep a single view definition while editors supply the variable exposed input.
- Show a visitor-facing exposed filter form only where the editor opts in.
- Avoid custom code for "same view, different filter" placement patterns.
- Let editors clear a filter by leaving the exposed widget empty (empty values are ignored).
