# Modeler — setup & operation

There is **no settings form** for this module (`configure` is null) and nothing to configure in
`config/`. It activates automatically once both `modeler_api` and at least one **model owner**
module are installed.

## Activation

```bash
composer require drupal/modeler        # pulls drupal/modeler_api ^1.1
drush en modeler
# plus a model owner, e.g. ECA:
composer require drupal/eca
drush en eca eca_ui
```

Then open the model owner's admin UI (for ECA: *Administration › Configuration › Workflow › ECA*)
and **Add** or edit a model — the React canvas opens in place of the classic form UI. If more than
one modeler plugin is installed, Modeler API lets the user choose; when only `workflow_modeler`
(plus the fallback) exists, it is used directly and `LinkHooks` rewrites the add/edit/view links
with HTMX so the editor loads inline (`.page-wrapper`, swapped `afterbegin`).

## Permissions

The module defines **no permissions**. The six modeler capabilities are declared and access-checked
by **Modeler API** (and its model owner), not here: edit metadata, switch context, edit templates,
create templates, test, replay. Grant them on the model owner's permission set. The React UI reads
the resolved permissions and hides/disables actions accordingly.

## View modes & user preferences

- Fullscreen (covers viewport) or a resizable, draggable floating window (position saved to
  `localStorage`).
- Dark/light theme toggle — also persisted to `localStorage`. No server-side storage; nothing to
  configure per site.

## Export formats

From the toolbar a model can be exported as:
- **Recipe** — a Drupal recipe for distribution.
- **Archive** — a compressed archive of the model's config files.
- **JSON** — portable model document (loadable by the standalone viewer).
- **SVG** — a static image of the canvas.

## Standalone viewer

A separate, Drupal-free read-only build renders an exported JSON model in any web page (with
optional replay). Build it from the module's `ui/` directory: `npm run build:standalone`. Use it to
embed a workflow diagram on a public page.

## Asset library

`modeler/react-ui` (`modeler.libraries.yml`) loads `dist/modeler.bundle.js` + `.css` and depends on
core `drupal`, `drupal.ajax`, `drupal.dialog`(+`.off_canvas`), `drupalSettings`, `jquery`, `once`.
It is attached by the plugin's render array; you do not attach it manually.
