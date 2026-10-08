Viewfield provides a field type that references a View (plus a specific display and optional contextual-filter arguments) and renders that view inline wherever the host entity is displayed. It is essentially a way to embed a view as a field on any content type or other fieldable entity.

---

Viewfield defines a `viewfield` field type (extending core's `EntityReferenceItem`, with `target_type` fixed to `view`) whose value stores a `target_id` (the View), a `display_id` (which display to run), an `arguments` string (comma/slash-delimited contextual filters, token-aware), and an `items_to_display` override. The default `viewfield_select` widget lets an author pick a view, then Ajax-loads that view's displays into a second select, plus an "Advanced options" area for arguments and items-to-display. Field settings let a site builder restrict the choices via `allowed_views` and `allowed_display_types`, and an `Always use default value` (`force_default`) checkbox that hides the field on entity forms and always renders a configured default. Three formatters render the value: `viewfield_default` (runs the view and themes it with `viewfield`/`viewfield_item` templates, with view-title display and an `always_build_output` option for empty results), `viewfield_rendered` ("Rendered entities" — renders the view's result rows as entities in a chosen view mode, single-cardinality only), and `viewfield_title` ("Title and display name" — prints the view title, display name and arguments for debugging). Arguments support Drupal tokens resolved against the host entity, so a viewfield can pass the current node's ID or other values into the view's contextual filters. The module ships config schema, Twig templates, a REST normalizer, and a Drupal 7 migrate field plugin. This is a beta release.

---

- Embed a related-content view (e.g. "more articles in this section") directly on a node.
- Add a "Viewfield" field to a content type via Manage fields and reference an existing view.
- Let editors pick which View and which display renders in a field, per piece of content.
- Pass the current node's ID into a view's contextual filter using a token argument.
- Force a fixed view+display on every entity in a bundle with "Always use default value".
- Restrict the views authors may choose from using the `allowed_views` field setting.
- Restrict which display types (block, page, etc.) authors may choose via `allowed_display_types`.
- Override the number of items a display shows per entity via "Items to display" (disables the pager).
- Render a view's result rows as full entities in a chosen view mode with the "Rendered entities" formatter.
- Display a block view inline on an article without placing it in a region.
- Show a taxonomy-term's related content by passing the term ID as a token argument.
- Build a "featured content" region on a landing page by referencing a curated view.
- Pass multiple contextual filters by separating them with "/" in the Arguments field.
- Pass multi-value arguments to a single filter using "+" or "," between values.
- Always build output for an attachment display even when the view returns no results.
- Choose whether the view title renders Above, Inline, Hidden, or Visually Hidden.
- Show a debug summary (view, display, arguments) of a viewfield with the "Title and display name" formatter.
- Store several distinct view displays on one entity by setting field cardinality > 1.
- Override viewfield theming by copying `viewfield.html.twig` / `viewfield-item.html.twig`.
- Style view titles with the added `field__item__label` CSS class.
- Reuse one view with different arguments on different pages (arguments are part of cache keys).
- Migrate Drupal 7 viewfield values into Drupal 10/11 via the bundled d7 migrate field plugin.
- Expose viewfield values through REST using the module's field normalizer.
- Hide the viewfield on edit forms entirely for site-controlled, non-editable embeds.
