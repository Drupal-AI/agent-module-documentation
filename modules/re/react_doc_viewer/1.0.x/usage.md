<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# react doc viewer

react doc viewer displays uploaded document files through a bundled React application. It
provides:

- A **field formatter** (`rdv_field_formatter`) for file fields that renders a link to
  `/rdv/{fid}`, a page that mounts the React viewer (`<div id="rdv-main__react">`).
- A **REST resource** (`react_doc_viewer_rest_resource`, `GET /react-doc-viewer/{fid}`) that
  returns the file's absolute URL and extension so the React app can fetch and render it.
- A permission, *access page file viewer*, and a viewer route `/rdv/{fid}` gated by
  *access content*.

---

## Installation & configuration

- Requires the core `rest` (and `serialization`) modules.
- Install with `drush en react_doc_viewer`.
- On a file field's *Manage display*, select the **Rdv field formatter**.
- The REST resource is installed via `config/install` with cookie authentication and the JSON
  format; grant the relevant *restful get* permission to roles that should call it.
- `config/install/react_doc_viewer.settings.yml` ships an `allowed_tags` list.
- The bundled React build lives in `js/dist/index.js` (attached via the `react_doc_viewer`
  library).

Known issues (see agent notes): the REST resource's internal permission check references a
mis-spelled permission and an unimported exception class, and the viewer route's title callback
calls methods that do not exist on `ControllerBase` — both are fail-closed/error paths rather
than exploitable disclosures.

---

## Use cases

- Show a "view document" link on nodes that mounts an in-browser React viewer.
- Provide a consistent document-viewing experience across file types.
- Decouple document rendering into a React front-end while keeping files in Drupal.
- Serve a file's URL + type to a SPA via a simple REST endpoint.
- Display PDFs and office documents without leaving the site.
- Offer a viewer page per file ID at a predictable `/rdv/{fid}` path.
- Integrate document previews into a decoupled or progressively-decoupled build.
- Let editors attach documents and expose a viewer with one formatter setting.
- Centralise document viewing behind a single React component.
- Prototype a document portal quickly.
- Use cookie-authenticated REST calls from the same-origin React app.
- Restrict the viewer page with the *access content* permission.
- Restrict the file-metadata endpoint with a dedicated viewer permission.
- Reuse the bundled React build as a starting point for customisation.
- Present filenames as page titles for viewed documents.
- Serve as an example of pairing a field formatter with a REST resource.
