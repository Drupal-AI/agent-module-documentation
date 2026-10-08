<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RapiDoc Elements Field Formatter

Provides two field formatters that turn an OpenAPI/Swagger specification into a browsable,
try-it-out API reference rendered by the [RapiDoc](https://rapidocweb.com/) web component:

- **RapiDoc Elements UI** (`rapidoc_elements_ui`) for **file** fields — renders the uploaded
  YAML/JSON spec file.
- **RapiDoc Elements UI** (`rapidoc_elements_link_ui`) for **link** fields — renders the spec
  found at the linked URL.

Both formatters attach the `rapidoc` library and pass the resolved spec URL to a Twig template
(`rapidoc-elements-ui-field-item.html.twig`) as the `spec-url` attribute of a `<rapi-doc>`
element. The RapiDoc component then fetches and renders the spec **client-side, in the
visitor's browser**.

---

## Installation & configuration

- Requires core `file` and `link` modules.
- Install with `drush en rapidoc_elements_field_formatter`.
- On a file or link field's *Manage display*, choose the **RapiDoc Elements UI** formatter.
- The RapiDoc JavaScript is loaded from the public CDN `https://unpkg.com/rapidoc/dist/rapidoc-min.js`
  (declared in `rapidoc_elements_field_formatter.libraries.yml`). Sites with a strict CSP or an
  offline requirement should mirror the library locally and override the definition.
- Template styling (theme colours, layout, try-it behaviour) is hard-coded in the Twig template;
  override the template in your theme to change it.
- Note: the file-field formatter resolves the URL server-side from the uploaded file
  (`generateAbsoluteString`), while the link-field formatter uses the editor-supplied link URL.

---

## Use cases

- Publish interactive API documentation for a service directly on a Drupal page.
- Let content editors attach an `openapi.yaml`/`swagger.json` file and render it as docs.
- Reference a remotely hosted spec via a link field and render it inline.
- Provide "try it out" API consoles for internal developer portals.
- Show versioned API specs as file-field revisions.
- Embed API references inside nodes, media, or paragraphs.
- Give non-developers a no-code way to surface OpenAPI docs.
- Replace an external Swagger UI hosting with an on-site render.
- Present multiple specs on one page via multi-value fields.
- Standardise API doc presentation across a documentation site.
- Combine with access-controlled fields to gate who sees a spec.
- Prototype API docs quickly during development.
- Use the focus/row RapiDoc layout for a clean reading experience.
- Offer authenticated "try" calls via RapiDoc's auth panel.
- Document partner/third-party APIs alongside your own.
- Serve as an example of extending core file/link formatters.
