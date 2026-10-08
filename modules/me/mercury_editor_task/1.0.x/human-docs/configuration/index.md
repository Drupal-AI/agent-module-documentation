# Configuration

Mercury Editor Task has one settings form that controls how the dedicated **Mercury
Editor** task behaves and what its form mode displays.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Mercury Editor → Task**, or navigate
   directly to `/admin/config/content/mercury-editor/task`.

## Settings

The form lets you tune the task and the dedicated Mercury Editor form mode:

- **Task label** — the label shown for the dedicated Mercury Editor task (the tab)
  and for its entry in the node's operations list. Set this to whatever wording
  suits your editors (for example "Layout" or "Page builder").
- **Fields, field groups, and components to display** — specify which field names,
  field groups, and components should appear through the dedicated Mercury Editor
  form mode. This is how you control what the builder route shows, keeping the
  page‑building screen focused on the layout fields rather than every field on the
  node form.
- **Update all existing Mercury Editor form modes** — a checkbox that, when ticked,
  applies your choices to the existing Mercury Editor form modes across the content
  types that use them. Check it when you want your changes rolled out everywhere at
  once rather than only affecting new configuration.

## How the task route behaves

You do not configure this directly, but it is worth knowing: on the
`/node/{node}/mercury-editor` route the module hides the raw Layout Paragraphs
builder widget so editing goes through Mercury Editor rather than the default
widget. (The widget is only *visually* hidden when the Schema.org Devel module's
generate parameter is present, so generated data still submits as expected.) Access
to that route defers to standard node‑edit permissions.

## Save

Click **Save configuration**. If you ticked the update checkbox, existing Mercury
Editor form modes are updated to match. Reload a node's **Mercury Editor** tab to
see the new label and form‑mode contents.
