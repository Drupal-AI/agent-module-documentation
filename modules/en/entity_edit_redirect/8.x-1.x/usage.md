<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Edit Redirect intercepts entity edit-form routes and 301-redirects them to a matching path on a configured external server.
---
A response event subscriber (`EntityEditRedirectSubscriber`, priority 1000) detects routes named `entity.{entity_type}.edit_form` with a single route parameter. For entity types/bundles that have a configured path pattern (patterns may include `{uuid}`), it builds `base_redirect_url + '/' + path` and issues a `TrustedRedirectResponse` (301). Optionally it appends the origin's return destination as a query string: it prefers the `destination` query parameter, then a same-origin `referer` (validated with `UrlHelper::externalIsLocal`), then the entity's canonical URL, then the site base URL. The redirect target host is the admin-configured `base_redirect_url`, not user input, and `TrustedRedirectResponse` is used, so this is not an open redirect.

Configuration lives at `/admin/config/content/entity_edit_redirect` (route `entity_edit_redirect.admin_form`) behind the permission string `admininister entity edit redirect configuration` (note the module's own typo). Settings are `base_redirect_url`, `append_destination`, `destination_querystring`, and a textarea of `entity_type[.bundle]:path_pattern` rules. Typical use is offloading editing of certain entities to an external CMS/headless editor while keeping viewing on the Drupal site.
---
- Send node edit forms to an external editing application.
- Configure a base redirect URL for the external editor.
- Define per-entity-type path patterns for the external edit path.
- Define per-bundle path patterns (e.g. only redirect Article edits).
- Include the entity UUID in the external path via `{uuid}`.
- Append the Drupal return URL as a `destination` query string.
- Change the destination query-string parameter name.
- Preserve the contextual-edit "return to view page" behaviour via referer.
- Keep viewing on Drupal while editing happens elsewhere.
- Integrate a decoupled/headless editing workflow.
- Disable redirection by clearing the base redirect URL.
- Limit which content types are offloaded by omitting their patterns.
- Restrict access to the settings form via the module's permission.
- Audit that redirects use TrustedRedirectResponse to a fixed host.
- Route editors of a specific bundle to a bespoke editing screen.
- Return an editor to /admin/content after external editing.
- Support a multi-site setup where editing is centralised.