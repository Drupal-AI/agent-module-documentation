# Configuration

Frontend Editing is configured across three admin forms under **Configuration →
Frontend editing**, all gated by the **Administer frontend editing** permission.
Everything is stored in one config object, `frontend_editing.settings`.

## The three forms

| Form | Path | What it covers |
|---|---|---|
| **Settings** | `/admin/config/frontend-editing` | sidebar/full widths and preview |
| **Entity types and bundles** | `/admin/config/frontend-editing/entity-bundle-restrictions` | which bundles are editable |
| **UI settings** | `/admin/config/frontend-editing/ui-settings` | toggle button, colors, filters |

## Choose editable bundles (the important step)

Frontend editing is opt-in per entity-type/bundle. Nothing becomes editable until
you enable it here.

1. Go to **Configuration → Frontend editing → Entity types and bundles**.
2. In the checkbox grid, tick the bundles you want to be editable on the front end
   — for example `node.landing_page`, or specific `paragraph` types.
3. Save.

A bundle that is not ticked gets no editing wrapper or controls at all.

## Settings form — widths and preview

On the main **Settings** form:

- **Sidebar width** — the width (in %) of the slide-in edit panel in split view
  (default **30**).
- **Full width** — the width (in %) used for the full/preview pane (default **70**).
- **AJAX content update** — refresh the edited content in place after saving, with
  no full page reload (on by default).
- **Automatic preview** — re-render the entity in the sidebar as fields change.
- **Hover highlight** — outline the editable region when the editor hovers over it,
  so they can see exactly what a field maps to.

## UI settings form — toggle, color, and filters

On the **UI settings** form:

- **Primary color** — the accent color of the editing UI (default `#a9a9a9`).
- **Floating toggle button** — show a floating on/off button so editors can switch
  frontend editing on and off per session (on by default). You can also set its
  screen offsets (top/bottom/left/right).
- **Keep action links in viewport** — how paragraph action links stay visible on
  very tall paragraphs (off by default).
- **Filter the "add paragraph" list** — show a search box on the add-paragraph type
  list (on by default), and the **threshold** number of types above which that
  filter appears (default **10**).

## Excluding specific fields

If you want certain fields to render but *not* be editable, you can add their full
field names (for example `node.article.field_internal_note`) to the
**exclude fields** setting. Developers can do the same in code with the
`hook_fe_field_wrapper_exclude_alter()` alter hook — see the
[`agent/`](../agent/start.md) docs.

## Permissions recap

- **Access frontend editing** — the baseline permission to use the editor and open
  the sidebar.
- **Administer frontend editing** — reach the three admin forms above (trusted/admin
  only).
- **Move paragraphs** / **Add paragraphs** / **Delete paragraphs** — the individual
  inline paragraph controls.

Note that these permissions work alongside normal entity access and the
`paragraphs_edit` module's own access checks, so a user still needs the usual "edit"
rights on the content they are changing.

## Deploying the configuration

All settings live in the `frontend_editing.settings` config object, so your editable
bundles and UI choices travel with a normal configuration export. You can inspect
them with:

```bash
drush config:get frontend_editing.settings
```
