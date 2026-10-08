<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: attaches the Redoc standalone JS so a `<redoc spec-url="...">` tag placed in node body renders API docs.
- When: you want to publish human-readable OpenAPI/Swagger documentation as a page on your Drupal site.

---

- Enable the module; it has no dependencies and no admin form.
- Use a text format that allows the `<redoc>` tag (Full HTML) on the field where you embed the spec.

---

- `hook_preprocess_page` attaches the `api_redoc_document/api_redoc_document` library on every page.
- The library loads `redoc.standalone.js` from the jsDelivr CDN as an external script (see note).
- Authors embed `<redoc spec-url="path/to/spec.json"></redoc>` in a Full-HTML field.
- The spec URL may be a remote URL or a local file path serving JSON or YAML.
- Redoc renders the spec client-side into formatted API documentation.
- Ships `css/style.css` for basic styling of the rendered docs.
- No routes, permissions, or services are provided; it is presentation-only.
- Because the library attaches site-wide, the Redoc script loads on all pages, not just doc pages.
- Use a filtered text format carefully so the raw `<redoc>` tag is not stripped.
- The spec must be valid OpenAPI JSON/YAML or Redoc will not render it.
- Host the spec file yourself if you prefer not to depend on external URLs.
- hook_help documents the tag format on `help.page.api_redoc_document`.
- Client-side rendering means the browser fetches the spec, not Drupal.
- Note the CDN dependency for offline/air-gapped or strict-CSP environments.
- Clear caches after enabling so the library attaches.
- Version 1.0.x supports Drupal 8/9/10.
