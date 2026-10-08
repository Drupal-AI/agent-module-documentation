Better Exposed Filters (BEF) replaces the default single/multi-select boxes of Views exposed filters with richer widgets — checkboxes, radio buttons, links, sliders, date pickers and more — giving site builders fine-grained control over how an exposed form looks and behaves.

---

Views lets you expose a filter, sort or pager so visitors can refine a listing, but out of the box those controls are plain HTML `<select>` boxes. BEF adds a "Better Exposed Filters" exposed form plugin that you select in a view's **Exposed form** settings, unlocking per-filter widget choices: render a filter as checkboxes, radio buttons, clickable links, hidden fields, a number field, a noUiSlider range slider, or jQuery-style date/datetime pickers. It works the same way for exposed **sort** and **pager** controls, which can become links or radio buttons. Beyond widget selection, BEF adds behavioral options such as auto-submit (search as you type/click), hiding the submit button, "select all/none" links for checkbox filters, soft limits with more/less toggles, collapsible fieldsets, secondary "advanced" option groups, and rewriting of filter option labels. Widgets are Drupal plugins defined by three plugin managers (filter, pager, sort), so developers can add their own widget types. Extra markup and Twig templates make the exposed form easy to theme. All configuration is stored inside the view's exposed_form options (config schema provided), so it deploys with the view. It is a near-universal building block for faceted search and filtered listing pages.

---

- Render a taxonomy or content-type exposed filter as checkboxes instead of a multi-select box.
- Turn a single-value exposed filter into a set of radio buttons.
- Present filter options as a horizontal row of clickable links (like facets).
- Add "Select all / none" links above a checkbox filter.
- Enable auto-submit so the view refreshes as soon as a visitor changes a filter.
- Hide the Apply/Submit button when using auto-submit for a live-search feel.
- Add a range slider (noUiSlider) for a numeric price or quantity filter.
- Provide a date picker for exposed date filters.
- Provide a datetime picker for exposed datetime filters.
- Use a plain number field widget for numeric exposed filters.
- Hide a specific exposed filter as a hidden field while keeping its default value active.
- Collapse the exposed form into a collapsible fieldset to save vertical space.
- Group less-important filters into a secondary "Advanced options" fieldset.
- Apply a soft limit to a long checkbox/links list with "Show more / Show less" toggles.
- Wrap a long options list in a fixed-height scrollable container.
- Rewrite or reorder the visible labels of filter options.
- Convert the exposed **sort** control into links or radio buttons.
- Convert the exposed **pager** (items-per-page) control into links or radio buttons.
- Add a "Reset" link that clears the exposed filters via AJAX.
- Build a faceted product catalog browse page with checkbox facets.
- Build a real-time search results page that filters as the user types.
- Style exposed filters precisely using BEF's extra wrapper markup and Twig templates.
- Allow multiple checkbox selections on a filter that normally only takes one value.
- Add a custom filter widget type (plugin) for a bespoke input control.
- Ship exposed-form widget configuration as part of the view's exported config.
- Programmatically tune slider min/max via the BEF options alter hook.
