# Simple Percentage Field — manual setup guide

**Simple Percentage Field** (`simple_percentage_field`) adds a dedicated
**percentage field type** to Drupal, together with its own editing widget and a
display formatter that can render the value in a progress-bar style rather than as a
bare number. It is handy whenever you want to store and show a percentage or a
"from-to" progress value — a completion rate, a score, a funding level — in a more
graphical way than a plain digit.

You add the field through Drupal's standard **Manage fields** screen, choosing the
**Simple percentage** field type, and you control how it looks on **Manage display**.
The formatter offers a few options: rendering an absolute value, positioning a
numeric prefix or suffix, and optionally showing the field's configured minimum and
maximum values. Usefully, the **Simple percentage** formatter also works with
Drupal core's own numeric fields (float, decimal and integer), so you can apply the
progress-bar display to numbers you already store.

This is a pure field module: it depends only on core's **Field** module, has no
settings page of its own, no permissions, no submodules, and makes no external
calls. It works as soon as you enable it — the setup is simply adding and
configuring a field.

This guide is written for a **human**. If you want terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

1. Go to a content type's (or other entity's) **Manage fields** screen — for
   example **Structure → Content types → Article → Manage fields** — and click **Add
   field**.
2. Choose the **Simple percentage** field type, give it a label, and save.
3. On the field settings, set the required **minimum and maximum** values that frame
   the percentage.
4. On **Manage form display**, editors get the percentage widget for entering
   values; on **Manage display**, choose the **Simple percentage** formatter and set
   its options (absolute value, prefix/suffix and its position, whether to show
   min/max).
5. Edit a piece of content, enter a value, and save — the value renders through the
   formatter you configured.

You can also apply the **Simple percentage** formatter to an existing core float,
decimal or integer field on **Manage display** if you want that graphical treatment
for numbers you already have.
