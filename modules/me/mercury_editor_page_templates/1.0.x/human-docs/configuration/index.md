# Configuration

Mercury Editor Page Templates is configured in two connected places: an **admin
interface** where you define and organise templates, and the **Mercury Editor
toolbar**, where editors can capture a live page as a new template. First, make sure
Mercury Editor itself is set up for the content types you want to use.

## Permissions

The module provides its own permissions. The key one is **Administer Mercury Editor
Page Templates**, which lets a user manage templates and use the *Save as Page
Template* feature from the editor toolbar. Grant it at **People → Permissions**
(`/admin/people/permissions`) to the roles that should manage templates.

## Manage templates in the admin interface

1. Go to **Configuration → Content authoring → Mercury Editor Page Templates**.
2. **Add a template.** Give it a label, choose the content type(s) it applies to,
   and define its paragraph structure. You can optionally attach a **preview image**
   (PNG, JPEG, or WebP) that appears in the template selector, and provide a
   description.
3. **Organise into groups.** Open the **Groups** tab to create labelled sections,
   assign templates to a group, and drag rows to set their order both between groups
   and within each group. This controls how templates are grouped and sorted in the
   selector editors see.
4. You can also **edit, delete, or disable** templates from this interface — a
   disabled template stays defined but no longer appears in the selector.

Templates are stored as **YAML**, so they can be edited directly and kept in version
control. A template's YAML describes the section layout, the paragraphs and their
field values, style options, and layout regions — including nested paragraphs and
resolved entity/paragraph references.

## Save an existing page as a template

Editors with the *Administer Mercury Editor Page Templates* permission can capture
any page open in Mercury Editor as a reusable template, without leaving the editor:

1. Open a page in Mercury Editor and lay it out as you want the template to look.
2. Click **Save as Page Template** in the Mercury Editor toolbar.
3. In the dialog, choose one of three modes:
   - **New template** — enter a label, a machine ID, and an optional description and
     group, then click **Save**.
   - **Update existing** — if the page was originally created from a template, the
     dialog offers a one‑click **Update** for that template.
   - **Confirm overwrite** — if the machine ID you enter matches an existing
     template, you are asked to confirm before overwriting it.

The current paragraph field values, style options, layout sections and regions, and
nested paragraphs are all captured from the live layout at save time.

## Use templates when creating content

When an editor creates a new page of a content type that has templates, the template
selector presents the available templates (grouped and ordered as you configured),
each with its preview image if one was set. Choosing a template seeds the new page
with that pre‑configured layout and content, ready to edit in Mercury Editor.
