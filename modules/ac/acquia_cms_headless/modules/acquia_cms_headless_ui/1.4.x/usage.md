Acquia CMS Headless UI is the "pure headless" submodule of Acquia CMS Headless: it disables Drupal's front end and restructures the admin experience around the JSON:API.

---

Acquia CMS Headless UI turns a progressively decoupled Acquia CMS site into a purely headless one. On install it repoints the site front page to a `/frontpage` login screen, sends 403s to the login form, switches the admin theme to Gin, and creates a set of path aliases and menu/toolbar changes that reorganize administration into three areas — API (access control, OAuth clients, roles, tokens, users), Data model (content types, media types, taxonomy, blocks) and System administration. It rewrites each entity's canonical "View" local task to point at that entity's JSON:API representation, hides Drupal front-end concepts (themes page, promote/sticky, manage-display), and adds a Next.js "Preview" tab on nodes that renders the decoupled site preview of the latest revision. It depends on the parent `acquia_cms_headless` module and on core `path_alias`, and is normally enabled/disabled through the parent's "Enable Headless mode" checkbox rather than directly.

Use it when you want Drupal to serve purely as an API backend for a Next.js (or other) front end and want the Drupal UI streamlined to match, with content editors working against the API rather than a themed Drupal site.

---

- Disable Drupal's public front end and run the site as a pure API backend.
- Replace the front page with a login screen for content editors.
- Redirect anonymous 403s to the user login form.
- Reorganize the admin toolbar into API / Data model / System administration.
- Rewrite entity "View" tabs to their JSON:API URL instead of the themed page.
- Add a Next.js site-preview tab to nodes for latest-revision preview.
- Alias OAuth/consumer/role/token/user admin pages under `/admin/access/*`.
- Alias content-model admin pages under `/admin/content-models/*`.
- Switch the admin theme to Gin for a headless-focused editing experience.
- Hide front-end-only node options (Promote, Sticky, preview mode, manage display).
- Redirect entity add/edit forms back to their content list views.
- Default post-login destination to the front/dashboard.
- Provide a help screen documenting the OAuth password-grant token flow.
- Remove the themes page and theme management menu items.
- Keep the system front page from being overridden while headless mode is on.
- Turn off the moderation dashboard login redirect that conflicts with headless login.
- Reverse all of the above cleanly on uninstall (restores front end, aliases, config).
- Enable/disable it via the parent module's Headless tour step.
- Present taxonomy terms as plain text in the overview (no themed links).
- Point media/block admin under the content-model grouping.
