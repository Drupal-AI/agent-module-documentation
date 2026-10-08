<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Faceted Filters JS provides a simple data-attributes faceted filter.

---

Views Faceted Filters JS provides a **simple, data-attributes-based JavaScript faceted filter for Views** —
client-side filtering of already-rendered view results by facet values (without a server round-trip), with a
subitem example submodule. It depends on core Views, in the views package.

Use it for lightweight client-side result filtering. It is a content-display/Views feature. Note: because it
filters **client-side on already-loaded results**, it is a presentation convenience, not a data boundary — all
the results it can filter are already sent to the browser (so it must not be used to "hide" sensitive rows; only
send rows the user may see, per the view's access). It has no access-control role. Configure the JS facets.

---

- Filter Views results client-side.
- Use data attributes for facets.
- Avoid a server round-trip.
- Depend on core Views.
- Provide an example submodule.
- Serve content display.
- Filter already-loaded results (presentation).
- Not use it to hide sensitive rows.
- Send only rows the user may see.
- Have no access-control role.
- Configure the JS facets.
- Handle JS facets.
- Filter results.
- Configure the filter.
- Facet client-side.
- Handle the view.
- Filter rows.
- Add facets.
- Rely on the view's access.
- Provide JS faceted filtering.
