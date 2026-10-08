<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Markup adds a "Manage markup" admin UI that controls the wrapper HTML tags and CSS classes rendered around each entity field, per field and per view mode, without writing Twig template overrides.

---

Entity Markup provides a per-field, per-view-mode user interface for shaping the HTML that wraps rendered entity fields. For each configurable field in a bundle's display it lets a site builder choose the tag used for the field wrapper, the field-items wrapper, each field item, and the label, override the displayed label text, remove a wrapper entirely, and add extra CSS classes to the field and to each item. It works by loading its `entity_view_markup` configuration in a `hook_preprocess_field()` implementation and applying the values through its own field theme templates (with theme suggestions inserted ahead of the default field templates). It depends only on core Field, adds no permissions of its own (the "Manage markup" tabs reuse each entity type's `administer <type> display` access), and stores everything as configuration so choices are exportable. It is aimed at projects that would otherwise accumulate many small `field--*.html.twig` overrides just to change a wrapper tag or heading level.

---

- Render a node title with an `h1`/`h2` heading tag instead of the default wrapper.
- Change a field's outer wrapper from `div` to `figure`, `p`, or `ul`.
- Remove the wrapping element around a field entirely (the "- Remove -" option).
- Wrap each item of a multi-value field in `li` elements to produce a real list.
- Render multi-value field items inside a `ul` items container.
- Change the tag used for a field's label (e.g. `span`, `p`, or a heading).
- Override the displayed label text for a field on a specific view mode.
- Add extra CSS classes to a field wrapper to match a design system.
- Add per-item CSS classes to each value of a multi-value field.
- Apply different markup for the same field across Default, Teaser, and other view modes.
- Reduce the number of custom Twig field templates a theme has to carry.
- Tailor field markup for a component/design-system-driven front end from the admin UI.
- Give editors semantic heading levels on specific fields without a developer.
- Configure markup for content entity fields such as nodes, taxonomy terms, and media.
- Configure markup for any entity type that exposes a Field UI base route.
- Keep markup adjustments as exportable configuration in version control.
- Adjust wrapper markup on a teaser to differ from the full display.
- Strip redundant wrapper divs to flatten a field's rendered HTML.
- Set list markup on tag/reference fields for cleaner output.
- Standardize heading levels across bundles for accessibility consistency.
- Prototype markup changes quickly without touching theme templates.
- Combine with the core layout manager instead of a full layout module.
- Reach the settings from the "Manage markup" tab next to Manage fields/display.
- Apply markup only to fields visible in the current display region.
