# Configuration

Menu Link (Field) has no settings page — you configure it entirely per field through
the standard Field UI.

## Add the field to a bundle

1. Go to the bundle's **Manage fields** tab — for a content type this is
   **Structure → Content types → *(your type)* → Manage fields**.
2. Click **Add field** and choose **Menu link** (under the *General* group).
3. Give it a label and save. Note that the field's cardinality is locked to **1** —
   an entity gets a single menu link — so the module hides the cardinality control.

## Field settings

When you configure the field you can set:

- **Available menus** *(required)* — a checkbox list of which menus a link on this
  bundle may be placed in. The default is the site's **Main navigation**. Only the
  menus you tick here appear in the editor's parent selector.
- **Default menu and parent** — the menu and parent position pre-selected for new
  links (must be one of the available menus).
- **Menu link per translation** — a storage-level option; enable it so that content
  translations can each have their own menu link.

## Place the widget (edit form)

On the bundle's **Manage form display** tab, position the **Menu link** widget where
you want it on the edit form. It renders a "Menu settings"-style sub-form:

- **Title** — the menu link text.
- **Description** — optional hover text for the link.
- **Parent** — a menu parent selector, limited to the menus you allowed. The link's
  weight (ordering among siblings) is taken from the chosen placement.

On node types this widget replaces core Menu module's own "Menu settings" section.
Saving the entity creates or updates the menu link automatically; clearing the field
removes it.

## Place a formatter (display)

On the bundle's **Manage display** tab, choose one of the two formatters for the
field:

- **Menu link** — renders the stored link. Its setting **Link to target** (on by
  default) outputs a hyperlink to the target entity/URL; turn it off to render the
  title as plain text.
- **Menu link breadcrumb** — renders the link's menu ancestry as a breadcrumb trail.
  Its settings are **Link to target** (make the crumbs clickable) and **Parents
  only** (show just the ancestors, excluding the link itself).

## Tips

- Because it is a real field, the stored menu name and title are available to
  **Views**, so you can build listings or reports of which entities are placed in
  which menus.
- Group the widget into a vertical tab using the **Field Group** module if you want
  it to sit alongside core's own vertical tabs on the edit form.
