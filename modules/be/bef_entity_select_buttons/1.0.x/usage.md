<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BEF Entity Select Buttons adds a Better Exposed Filters widget that renders a Views exposed filter's options as styled buttons, with an optional per-option "add entity" link.

---

BEF Entity Select Buttons extends the Better Exposed Filters (BEF) module with one filter-widget plugin, "BEF entity select buttons". A site builder selects it for a Views exposed filter under that filter's BEF configuration; the filter's options are then rendered as buttons (using core's `button` classes) laid out in a CSS grid or flexbox, rather than as a select list or plain BEF links. It is intended for bundle/entity-reference filters on content overviews — e.g. filtering a listing by content type or by a taxonomy/entity-reference field. Optionally, when the filter targets an entity type, each button can carry a small companion "add entity" button linking to that bundle's add-content form, shown only if the current user may create it. The widget subclasses BEF's `Links` widget and includes BEF's `bef-links` Twig template, so it reuses BEF's query/URL toggle behavior and only tweaks markup, classes, layout and the add-content affordance. It provides no routes, permissions, content entities, or config schema of its own; its only service is a URL helper that builds add-content links. Requires the `better_exposed_filters` module; supports Drupal 9.4, 10 and 11.

---

- Render a Views exposed content-type filter as a row of buttons instead of a select list.
- Let visitors filter a listing by clicking a bundle button rather than using a dropdown.
- Provide a touch-friendly, more visible filter UI on public content overviews.
- Filter an entity-reference exposed filter (e.g. taxonomy term reference) with button options.
- Lay filter buttons out in a responsive CSS grid (default) for even alignment.
- Switch button layout to flexbox instead of grid via the widget's "Align buttons in flex" option.
- Display the filter as a full-width block element on its own line ("Show as block element in full width").
- Show compact/small buttons via the widget's "Display small buttons" option.
- Highlight the currently-selected option with core's `button--primary` styling.
- Toggle an active filter off by clicking the same button again (inherited from BEF Links).
- Add a companion "add entity" button beside each bundle that deep-links to its add-content form.
- Give content editors a one-click path from a filtered overview to creating a new item of that bundle.
- Hide the add-content link automatically for users who lack create access to that bundle.
- Fall back to the `node.add` route for node bundles that expose no `add-form` link template.
- Combine with AJAX-enabled Views (JS strips the add-button click handler so AJAX doesn't misfire).
- Improve exposed-filter usability on admin content dashboards built with Views.
- Style the widget further via the shipped `bef-entity-select-buttons` CSS component classes.
- Reuse BEF's existing exposed-filter query handling while changing only the presentation.
- Apply per-exposed-filter, leaving other filters on the same view unchanged.
- Build a bundle-picker header for a content landing page.
- Replace a long content-type dropdown with scannable buttons.
- Offer editors a quicker create-and-filter workflow on entity overviews.
- Add a cleaner, more modern look to Views exposed filters without custom theming.
