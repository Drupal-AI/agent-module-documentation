Marker.io embeds the [Marker.io](https://marker.io/) visual-feedback / bug-reporting widget into your Drupal site so permitted users can report issues (with screenshots and context) directly from any page; it requires a Marker.io project key and subscription.

---

The module injects the Marker.io JavaScript widget site-wide via `hook_page_bottom()` using a
**lazy builder** (`markerio.lazy_builder:build`) so page caching stays intact. The widget is only
attached for users who hold the **`access markerio`** permission; anonymous/unpermitted users get
nothing. On the settings form (`/admin/config/system/markerio`, permission
`administer markerio configuration`) an admin enters the **Marker.io project key** and optionally
enables **Track node ID**. The lazy builder passes the project key plus (for authenticated users)
their email and display name into `drupalSettings.markerio` so Marker.io can pre-fill the reporter's
identity; when node tracking is on and the current route has a node, its id is passed too. Cache
contexts (`user`, `route`) and tags (`config:markerio.settings`, `user:<id>`, `node:<id>`) are set
so the right widget/state is delivered per user and page. The actual widget UI, screenshot capture,
and issue routing all happen client-side in Marker.io's SaaS; Drupal only supplies configuration
and identity hints.

---

- Add an in-page "Report a bug" widget for QA testers on a staging site.
- Let editors flag content issues visually without leaving the page.
- Collect visual feedback from clients during UAT/review.
- Restrict the widget to specific roles via the `access markerio` permission.
- Pre-fill the reporter's name/email from their Drupal account.
- Attach the current node id to reports so bugs are tied to the right page.
- Enable the widget only for logged-in staff while hiding it from visitors.
- Wire Marker.io issues into an external tracker (Jira, GitHub, etc.) via the SaaS.
- Gather screenshot-annotated feedback on responsive/layout problems.
- Turn the widget on for a whole site with a single project key.
- Keep full-page caching working thanks to the lazy-builder placeholder.
- Provide a lightweight feedback channel without building a custom form.
- Differentiate widget delivery per user with correct cache contexts.
- Disable the widget instantly by removing the permission from a role.
- Track feedback per page/route using node-id context.
- Onboard a new Marker.io project by pasting its project key.
- Let anonymous visitors report bugs by granting the permission to the anonymous role.
- Roll out visual feedback across multiple environments with per-env project keys.
- Capture browser/console metadata Marker.io collects for reproducible bug reports.
- Remove the module's page attachment cleanly (no residual markup for unpermitted users).
