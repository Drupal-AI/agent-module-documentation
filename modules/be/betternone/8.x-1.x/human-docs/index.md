# Better None Widget Option — manual setup guide

**Better None Widget Option** (`betternone`) lets you customise the "- None -"
empty option that Drupal shows on options/select field widgets (select lists,
radio buttons). Instead of the generic "- None -", you can give the empty
choice a friendlier, more meaningful label per widget — for example "Choose a
category" — so editors are less likely to be confused about what the empty
option means.

It works on any widget that extends core's options widget base
(`OptionsWidgetBase`), which covers the standard select and radios widgets used
by list fields, entity-reference fields, taxonomy term selects and similar. The
custom label is stored alongside the widget as third-party settings on the
entity's **form display** — there is no separate config entity, and each form
mode / content type can have its own label.

This is a pure form-display enhancement: it has no admin settings page, no
routes, no permissions and no services, and therefore no security surface. You
configure it inline while editing a field's widget under Manage form display.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no central settings page — you set the empty label per field widget:

1. Go to the entity type you want to change, for example a content type at
   **Structure → Content types → *(your type)* → Manage form display**
   (`/admin/structure/types/manage/{type}/form-display`).
2. Find the field whose widget is a select or radios (options-based) widget and
   click the gear/cog icon to edit its widget settings.
3. Fill in the custom empty-option label that Better None adds to the widget
   settings form, then click **Update** and **Save**.

The chosen label appears in place of "- None -" on that widget, and is shown in
the widget's settings summary so you can see it at a glance. Repeat per field or
per form mode to give different fields different empty prompts.
