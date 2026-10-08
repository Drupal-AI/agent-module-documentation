# Configuration

Editable Fields has no global settings page. You enable and tune it **per field**,
using the "Editable field" display formatter's settings on a bundle's *Manage
display* page.

## Turn a field into an editable field

1. Go to the bundle's **Manage display** (for example
   `/admin/structure/types/manage/article/display`).
2. On the field's row, choose the **Editable field** formatter.
3. Click the cog to open its settings, choose a **form mode** and a **behaviour**,
   click **Update**, then **Save**.

## Settings, field by field

**Form mode** *(required)* — which form mode's widget renders the editable field.
The default form mode's widget is the usual choice, but you can point it at a
dedicated form mode with a simplified widget for inline use.

**Behaviour** — how the widget is presented:

- **Inline** — the widget is embedded directly in the display; the user edits it in
  place and clicks Update (or it autosaves).
- **Popup** — the display shows an **Edit** link; clicking it opens the widget in a
  modal dialog. Good for keeping the page tidy until someone chooses to edit.

**Bypass access check** — when on, the field is editable regardless of the user's
entity *update* access (the `use editablefields` permission is still required).
Use this for a field that should always be inline-editable.

**Fallback for no access** and **View mode for no access** — when a user does not
have edit access, instead of showing nothing you can render the field read-only in
a chosen view mode. Turn on the fallback and pick the view mode to use.

**Fallback before edit** and **View mode before edit** *(popup)* — control what is
shown before the user clicks the "Edit" link: turn on the fallback and choose the
view mode to display until the widget is requested.

**Autosave — fields that trigger it** — a comma-separated list of field names that
should save automatically when they change. When set, the manual **Update** button
is hidden and the change is submitted over AJAX.

**Autosave — trigger event** — the browser event that fires the autosave, for
example `change` (natural for select lists and checkboxes) or `blur` (natural for
text fields, saving when the field loses focus).

## Who can edit — the access model

A field renders as editable only when the current user has the **Use
editablefields** permission **and** normal **update** access to the entity —
unless **Bypass access check** is on, which drops the update-access requirement. If
access is denied and you enabled the no-access fallback, the field is shown
read-only in the fallback view mode; otherwise nothing is output. See the
[permissions reference](../agent/permissions/permissions.md) in the agent docs for
the exact logic.

## Where the settings are stored

All of these settings live with the field's component in the entity's view-display
configuration (`core.entity_view_display.<entity>.<bundle>.<mode>`), so they export
and deploy like any other display configuration. Because it is display config, you
can give the same field inline editing in one view mode and leave it display-only
in another.
