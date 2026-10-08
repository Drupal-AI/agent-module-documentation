Autocomplete Extras lets site builders set the minimum keystrokes and the maximum number of results, per widget instance, on Drupal's core entity-reference and link autocomplete fields (and site-wide on the Menu Link Content form).

---

Autocomplete Extras is a small, dependency-free field-UX module. It alters two of Drupal core's autocomplete widgets - `EntityReferenceAutocompleteWidget` (entity-reference fields) and the `link` module's `LinkWidget` - by adding two extra widget settings on the *Manage form display* screen: "Minimum length to trigger autocomplete" and, for link widgets, "Number of results" (entity-reference widgets already have a core `match_limit`, so the module only reuses it). The minimum length is written to a `data-min-length` attribute and enforced client-side by a small behavior on top of jQuery UI autocomplete; the match limit is pushed into the widget's `#selection_settings['match_limit']`, which core's existing autocomplete/selection-handler pipeline honors when building suggestions. A separate admin settings form (`/admin/config/user-interface/autocomplete-extras`) applies the same two controls to the link field of every Menu Link Content add/edit form. The module adds no new route that returns entities, no field type, no plugin and no permission - it purely tunes the behavior of core widgets, so access, filtering and query building all remain core's.

---

- Require 3 characters before an entity-reference autocomplete fires, to cut Ajax load on a large content type.
- Raise the number of suggestions above core's default of 10 on a taxonomy-term reference field so editors can browse more matches.
- Set match limit to 0 (unlimited) on a small vocabulary so every option is shown.
- Tune a user-reference field to only query after 2 characters, reducing noise on very common name prefixes.
- Apply a longer minimum length to an autocomplete field backed by a slow selection handler.
- Configure per-instance behavior differently on two view modes of the same field (default vs. a compact form).
- Improve the editor experience on a media-reference autocomplete by limiting suggestions to a manageable count.
- Reduce accidental queries on mobile by requiring more characters before suggestions appear.
- Speed up a node-reference field on a site with tens of thousands of nodes by combining a higher min length with a small match limit.
- Set the number of results on a link field's URI autocomplete (which core does not otherwise limit).
- Require several characters before the link-field internal-path autocomplete triggers.
- Turn on Autocomplete Extras for the Menu Link Content form and require 3 characters before the link autocomplete fires.
- Limit the menu-link link autocomplete to a fixed number of internal-path suggestions site-wide.
- Standardize autocomplete tuning across many fields by configuring each widget's third-party settings.
- Keep an editor from over-triggering suggestions on an autocomplete with an expensive backend.
- Show the current tuning at a glance in the widget settings summary on *Manage form display*.
- Provide a lighter autocomplete UX on content-heavy admin forms without writing custom code.
- Adjust autocomplete responsiveness without patching core or overriding widget plugins.
- Export the menu-link tuning as configuration (`autocomplete_extras.settings`) for deployment across environments.
- Give different reference fields their own min-length thresholds based on dataset size.
- Combine with an entity-reference view/selection handler to keep suggestion lists short and fast.
