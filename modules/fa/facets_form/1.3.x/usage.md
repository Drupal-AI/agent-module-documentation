<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facets Form renders the facets of a facets source as real Drupal Form API elements inside a single form/block, so filters are applied only when the user submits (rather than on every click) and can be altered and themed through standard Form API.

---

Where the core Facets module renders widgets as link lists that JavaScript rewrites into form elements (applying each filter immediately), Facets Form exposes facets as genuine Form API elements collected in one form with a submit and reset button. It provides a block plugin (`facets_form`) that is **derived per facets source** (`FacetsFormBlockDeriver`) — placing "Facet form: <source>" builds a `FacetsForm` (`FormBase`) containing every *eligible* facet for that source. A facet is eligible when its widget implements `\Drupal\facets_form\FacetsFormWidgetInterface`; the module ships two such widgets, "Dropdown (inside form)" (`facets_form_dropdown`) and "Checkboxes (inside form)" (`facets_form_checkbox`), both extending the Facets `ArrayWidget` and using a shared `FacetsFormWidgetTrait`. The block config lets a site builder limit which facets appear and set the submit/reset button labels. On submit, each widget's `prepareValueForUrl()` turns the selected values into active filters, and the Facets URL generator redirects to the facet-filtered URL (reset returns to the current URL with the `f` query param stripped). A themeable `facets_form_item` template (with per-widget and per-source suggestions) renders each option label, and a per-widget JS event system (`TriggerWidgetChangeJavaScriptEvent` + auto-discovered `js/plugin/<id>.js` snippets) lets third parties react to live widget changes. Four submodules add a date-range widget, an extended date-range widget with quick pickers, a fulltext text widget, and a (deprecated) live results-count feature. Depends on Facets 2.x/3.x (and, in practice, Search API for the query side).

---

- Let users pick several facet filters and apply them all at once with a single Search button.
- Improve mobile faceted-search UX by deferring filter application until submit.
- Place a self-contained search-filter form block for a specific Search API facets source.
- Expose facets as a real `<select>` (single or multiple) via the Dropdown (inside form) widget.
- Expose facets as checkboxes via the Checkboxes (inside form) widget.
- Restrict a facets form block to only a chosen subset of the source's facets.
- Customize the submit and reset/clear button labels per block.
- Reset all active facet filters with a Clear-filters link that strips the `f` query parameter.
- Pipe facet widgets through Drupal Form API so `hook_form_alter()` can modify them.
- Theme facet option labels by overriding the `facets_form_item` template (with widget/source suggestions).
- Indent hierarchical (taxonomy) facet options using a configurable indentation class (checkboxes) or child prefix (dropdown).
- Show or hide result counts next to each option using the widget's "show numbers" config.
- Add a date-range filter form element via the `facets_form_date_range` submodule.
- Offer "this week / last month" quick date pickers via the `facets_form_date_range_extended` submodule.
- Add a free-text search box as a facet via the `facets_form_fulltext` submodule.
- Build a custom in-form facet widget by implementing `FacetsFormWidgetInterface` and providing a template.
- React to live widget changes in JS by subscribing to `TriggerWidgetChangeJavaScriptEvent` and shipping a `js/plugin/<id>.js` snippet.
- Combine multiple facets (category + tag + date + text) in one submit-driven filter form.
- Preserve non-filter query parameters (paging, sort) when submitting or resetting the form.
- Provide accessible, server-rendered facet forms that work without the core Facets link-rewriting JS.
- Disable a widget when there are no results using its "disable on empty" option.
- Drive a Views + Search API results page from a co-located facets form block.
- Give editors a familiar form-based search filter UI instead of instant-apply facet links.
