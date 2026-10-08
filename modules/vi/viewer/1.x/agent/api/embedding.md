<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embedding a viewer + the JSON data endpoint

A viewer is stored config data, not pre-rendered HTML. Whichever way it is embedded, the display
plugin's `getRenderable()` emits a small wrapper element carrying the viewer's **UUID** and attaches
a JS library; the browser then calls the REST data endpoint and builds the DOM client-side.

## The data endpoint — `rest.viewer.GET`

- Route/path: `/get/viewer/{uuid}` (config `config/install/rest.resource.viewer.yml`, resource id
  `viewer`, class `Plugin/rest/resource/ViewerResource`). Methods: GET; format: json; auth: cookie.
- `hook_install` (`viewer.install`) grants `restful get viewer` to `authenticated` **and**
  `anonymous`, so the endpoint answers for site visitors by default (removed on uninstall).
- `ViewerResource::get($uuid)` loads the `viewer` with that uuid and `status = 1`, then returns
  `{ data: <plugin getResponse()>, filters, configuration, settings }`. `data` for tabular viewers is
  `{ headers: [...], rows: [[...]] }` from the processor. Response cache contexts `user.permissions`,
  `url`; cache tags `viewer`, `viewer:{uuid}`, `viewer_source:{id}`.
- Client fetch: `assets/viewer.js` calls `<baseUrl>/get/viewer/{uuid}?_format=json`; per-viewer
  scripts (e.g. `assets/table/scripts.js`, `assets/spreadsheet/scripts.js`) consume `response.data`
  to populate the table/chart.

## Three embedding surfaces

1. **Block** — plugin id `viewer` (`Plugin/Block/ViewerBlock.php`). Block config `viewer_reference`
   is an `entity_autocomplete` for a `viewer`. `build()` renders the referenced viewer's
   `getRenderable()` when published, else an "inactive" / "requirements not met" message. Place at
   `/admin/structure/block`; block visibility/role restriction is standard core block behaviour.

2. **Field** — field type `viewer`, widget `viewer`, formatter `viewer` (all under
   `Plugin/Field/…`). The field stores a `target_id` (viewer id). `ViewersFormatter::viewElements()`
   renders each referenced viewer via `getRenderable()`. Add a "Viewer" field to any entity bundle.

3. **CKEditor 5 + filter** — CKEditor plugin `viewer_Viewer` (`viewer.ckeditor5.yml`, class
   `Plugin/CKEditor5Plugin/Viewer`) adds a **Viewer** toolbar button that opens the dialog route
   `viewer.ckeditor5_dialog` (`/viewer/dialog/{uuid}`, `Form/CKEditorDialogForm`, perm
   `use text format advanced`) to pick a viewer; it inserts a `<viewer data-viewer="ID">` element.
   The in-editor preview comes from `viewer.ckeditor5_preview` (`/viewer/preview/{editor}`,
   `Controller/CKEditorPreview::preview`, custom access `use text format <format>`). On the rendered
   page the text-format **filter** `viewer` (`Plugin/Filter/ViewerFilter.php`,
   TYPE_TRANSFORM_REVERSIBLE, weight 100) finds each `<viewer>` tag, loads the viewer by its
   `data-viewer` id (with `accessCheck(TRUE)`), and replaces the tag with the viewer's render array
   (or an inactive/requirements message). Enable both the toolbar button and the filter on the text
   format at `/admin/config/content/formats`.

## Notes for agents

- The block and field renderers gate on `$viewer->isPublished()` and `requirementsAreMet()`, but
  the actual data always arrives from the REST endpoint, which serves any `status = 1` viewer by
  UUID to anyone holding `restful get viewer` (granted to anonymous by default) — the on-page
  wrapper only needs to know the UUID.
- To fetch a viewer's data programmatically: GET `/get/viewer/{uuid}?_format=json`. To render one in
  code: load the `viewer` entity, `$plugin = $viewer->getViewerPlugin(); $plugin->setViewer($viewer);
  return $plugin->getRenderable();`.
