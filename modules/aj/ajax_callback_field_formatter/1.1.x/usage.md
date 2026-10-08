Ajax Callbacks Field Formatter adds a Link field formatter that renders each link value as a client-side AJAX trigger instead of a normal anchor, firing a request to the link's URL on page load.

---

The module ships one field formatter plugin (`ajax_callback_field_formatter`) that applies only to core Link (`link`) fields. Instead of rendering a Link value as an `<a>` element, it renders a `<span>` carrying two data attributes: the link's URL and a stable element id built from `entity_type--entity_id--field_name--delta`. Its bundled JavaScript (`js/ajax_callback_field_formatter.js`, a `Drupal.behaviors` behavior using `core/once`) walks every such span, calls `Drupal.ajax()` against the URL (appending an `ajax_callback_field_formatter_id` query parameter carrying a CSS selector for the span), and executes whatever AJAX commands the response returns. The module deliberately provides no controller or route of its own — the site builder points each link's URL at their own controller that returns an `AjaxResponse`, so the response can run any AJAX command (replace content, open a dialog, etc.). The formatter subclasses core's `LinkFormatter`, so it inherits the standard Link formatter settings. It defines no permissions, routes, services, config schema, or Drush commands; the requested callback runs with the viewing user's own privileges and access rules.

---

- Turn a Link field into an on-load AJAX trigger without writing any JavaScript.
- Replace a rendered link (`<a>`) with a `<span>` that fires an AJAX callback instead of navigating.
- Fetch and inject dynamic content into a page region as soon as it renders.
- Point a link's URL at a custom controller returning an `AjaxResponse` with `ReplaceCommand`.
- Open a modal/dialog automatically from a Link field value using `OpenModalDialogCommand`.
- Lazy-load an expensive or personalized fragment for one entity/field/delta.
- Show a placeholder text (the link's text part) that is replaced once the AJAX callback completes.
- Provide a graceful fallback: the link text remains visible if JavaScript fails or is disabled.
- Target the exact rendered element from your controller via the passed CSS-selector query parameter.
- Drive per-entity AJAX behavior where the URL differs per row/node (e.g. `/my-callback/{id}`).
- Build interactive dashboards where each field triggers its own data request.
- Attach live status/counter widgets sourced from a controller response.
- Reuse one generic JS connector across many different callbacks instead of bespoke behaviors.
- Apply the formatter via Manage Display in the UI, or via `core.entity_view_display.*` config.
- Configure inherited core Link formatter settings (trim length, rel, target) on the same field.
- Render the same formatter across nodes, taxonomy terms, users, or any entity with a Link field.
- Prototype AJAX-driven UI quickly by only implementing the server-side controller.
- Support Drupal 9, 10, and 11 (`core_version_requirement: ^9 || ^10 || ^11`).
- Distinguish multiple deltas of a multi-value Link field, each with its own callback id.
- Use it as a lightweight alternative to writing a full custom field formatter plus behavior.
