ECA Breadcrumbs lets you rebuild a page's breadcrumb trail from an ECA model, with full token support and no custom code.

---

The module registers a high-priority breadcrumb builder (`eca_breadcrumbs.breadcrumb_builder`) that fires an ECA "Build breadcrumb" event on every route. Inside an ECA model you react to that event with two actions: "Breadcrumb: add item" appends one Title/URL link, and "Breadcrumb: set items" replaces the entire trail from a multi-line `Title|URL` list. Titles and URLs run through Drupal's token system, and route parameters (the current node, user, or taxonomy term) are automatically exposed as ECA token data, so `[node:title]`, `[term:name]`, and similar tokens resolve against the page being viewed. URLs may be internal paths, absolute external URLs, or route names; an empty URL renders the item as the non-clickable current page. When your model sets no items the builder returns nothing and Drupal's normal breadcrumb builders take over. Conditions on the event let you scope each trail to a content type, route, role, or any other ECA condition. The module also adds a `[breadcrumb:route-name]` token and a pipeline-identifier action/condition pair for coordinating several breadcrumb models. It depends on ECA and Token and needs no configuration after install.

---

- Replace the breadcrumb on article nodes with `Home | Articles | [node:title]` using "Breadcrumb: set items".
- Build a taxonomy-driven trail like `Home | [node:field_category:entity:name] | [node:title]`.
- Add a single "Home" link to the front of a section's breadcrumb with "Breadcrumb: add item".
- Insert a category link whose URL is derived from a term id: `/category/[node:field_category:entity:tid]`.
- Show a different breadcrumb for a specific route (e.g. a custom landing page) by conditioning the model on the route name.
- Give unauthenticated and authenticated users different breadcrumbs by adding a user-role condition.
- Point the final breadcrumb item at the current page by leaving its URL empty (rendered as plain text via `<nolink>`).
- Link a breadcrumb item to an external site (e.g. `https://example.com`) that the module resolves with `Url::fromUri()`.
- Link a breadcrumb item to a named route instead of a path.
- Build multi-level e-commerce category navigation that adapts to product hierarchy.
- Add a dynamic breadcrumb item only when a field is present, using an "entity has field" condition before the add-item action.
- Use `[current-page:title]` or `[breadcrumb:route-name]` tokens to label the current location.
- Combine several add-item actions in one model to assemble a trail piece by piece.
- Override core's default node/term breadcrumbs on selected bundles while leaving the rest untouched.
- Localize breadcrumb link text by feeding translated token values or condition-scoped models.
- Reset the trail to just a home link on utility pages (search, 404 landing, etc.).
- Assign a pipeline identifier with "Does breadcrumb should apply" so one model can claim a route unambiguously.
- Gate a breadcrumb model with "Breadcrumb pipeline identifier is active" so only the intended pipeline builds the trail.
- Prototype breadcrumb rules visually in the ECA UI and iterate without deploying code.
- Keep breadcrumb logic in exportable ECA configuration alongside the rest of your site's business rules.
- Drive breadcrumbs from custom fields, computed values, or references resolved through tokens.
- Provide contextual breadcrumbs for views pages or custom controllers by matching their route.
