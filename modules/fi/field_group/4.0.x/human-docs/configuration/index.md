# Configuration

Field Group has no global settings form. You configure it per entity display, on
the same **Manage form display** and **Manage display** tabs where you already
arrange fields. The same steps apply to any fieldable entity — content types,
media types, taxonomy vocabularies, users, paragraphs, and so on.

## Choose where the group should appear

There are two places you can add groups, and they are independent of each other:

- **Manage form display** (`.../form-display`) — groups here shape the **edit
  form**. This is where you turn a long editing form into a set of tabs, or tuck
  advanced fields into a collapsed "Details" section.
- **Manage display** (`.../display`) — groups here shape the **rendered output**
  visitors see on the page. Use these to wrap display fields in structured,
  themeable markup.

For a content type, both live under **Structure → Content types → (your type)**.
Remember that each *view mode* (Default, Teaser, Full, …) has its own display, so
you can group fields differently for a teaser than for the full page.

## Add a group

1. Open the **Manage form display** or **Manage display** tab you want to work on.
2. Click the **Add group** action link at the top of the fields table.
3. Choose a **format type** (see the list below) and give the group a **label**.
4. Save. The new group appears as a row in the table.

## Move fields into the group

Back in the fields table, drag each field's handle so the field sits **underneath**
the group's row and is indented under it — that nesting is what puts the field
inside the group. You can drag a whole group under another group the same way, so
groups can nest to build multi‑level layouts (for example, several Tab groups
inside one Tabs container).

## Tune the group's settings

Each group has a gear / settings icon on its row. Open it to reach that format's
own small settings form. Which options you see depends on the format you picked —
common ones include the visible **label**, the wrapper **HTML element** and CSS
**classes**, whether a collapsible section starts **open or closed**, the tab
**direction**, and how required‑field markers behave.

## The built‑in format types

| Format | Works on | What it is |
|--------|----------|------------|
| **Fieldset** | form, display | A classic `<fieldset>` with a legend/label around the grouped fields. |
| **Details** | form, display | A collapsible section (HTML `<details>`); you choose whether it starts open or closed. |
| **Details sidebar** | form | A Details element rendered off in a sidebar region, like core's node "Authoring information" panel. |
| **Tab** | form, display | A single tab. Place several Tab groups inside a Tabs container. |
| **Tabs** | form, display | The container that holds Tab groups; a direction setting makes the tabs vertical or horizontal. |
| **HTML element** | form, display | An arbitrary wrapper tag (with your own classes and attributes) around the grouped fields — handy for hooking a design system onto the markup. |
| **Accordion** / **Accordion item** | form, display | A jQuery‑UI accordion, provided only if you enabled the deprecated `field_group_accordion` submodule. |

## Save and deploy

Click **Save** on the display tab when you are done. Field groups are stored as
part of the display configuration, so they behave like any other config: running
`drush config:export` captures them, and they deploy between environments along
with the rest of your configuration.
