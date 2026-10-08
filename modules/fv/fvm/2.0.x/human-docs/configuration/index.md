# Configuration

## Open the settings form

1. Log in as a user with the **Administer display modes** permission.
2. Go to **Structure → Display modes → View modes**, then click the **Field View
   Mode** action link — or navigate directly to
   `/admin/structure/display-modes/view/fvm`.

## What the form shows

The form lists every content entity bundle that has **more than the default view
mode** (bundles with only a `default` view mode are hidden, because there'd be
nothing to choose). For each listed bundle you get:

- **An enable checkbox** — tick it to turn Field View Mode on for that bundle. On
  save this creates the locked **View Mode** selection field and adds it to the
  bundle's default edit form. Untick it to remove the field again (see the data
  warning below).
- **A "limit view modes" checkboxes group** — optionally restrict which view modes
  appear in the editor's dropdown for that bundle. **If you check none, all enabled
  view modes are offered.** Check a subset to offer only those (for example just
  *Teaser* and *Featured*).

## What happens when you save

- **Enabling a bundle** creates a shared, locked entity-reference field named
  `view_mode_selection` (if it doesn't already exist), adds it to that bundle with
  the label **View Mode**, and places it on the default form display as a select
  list.
- **Disabling a bundle** removes the field from that bundle **only if no entities
  of that bundle have a value stored**. If any rows use it, nothing is deleted and
  your data is preserved.

> **Avoid data loss:** to stop offering the selector on a bundle that already has
> saved values, hide the field on the bundle's *Manage form display* instead of
> unticking the bundle here. Unticking is meant for bundles with no data.

## The selection widget options

The field is rendered with a **select list** widget (when core's Options module is
enabled; otherwise an autocomplete). On the bundle's *Manage form display*, the
widget's settings let you:

- **Rename the empty "Default" option** — give the "no explicit choice" option a
  friendlier label.
- **Remove the empty option entirely** — drop the "Default" choice so editors must
  pick a real view mode.

## Layout Builder interaction (custom blocks)

If you use **Layout Builder** with custom blocks (`block_content`), an extra
checkbox appears under that entity type:

- **Hide Layout builder view mode field** — when ticked, Field View Mode drives the
  block's view mode and Layout Builder's own view-mode field is hidden on the block
  form. When left unticked (the default), Field View Mode defers to Layout Builder
  and hides **its own** field on the block form, so the two never both control the
  same setting.

## How rendering works

Once a bundle is enabled and an editor has chosen a view mode on an entity, Field
View Mode switches that entity to the selected view mode at render time
automatically. Entities left on "Default" render as they always would.
