# First Paragraph — manual setup guide

**First Paragraph** (`first_paragraph`) provides a field formatter for body-style
text fields that displays **only the first paragraph** of the text. It's a simple,
predictable way to build teaser and summary displays: whatever an editor writes as
their opening paragraph is exactly what appears in the teaser listing. It depends
only on core's Field module.

It exists because core's "trim to N characters" summarising can produce
unpredictable, mid-sentence teasers, and splitting the body into a separate summary
field adds editorial overhead. With First Paragraph, editors don't have to manage a
second field or worry about where the cut-off lands — the first paragraph *is* the
teaser. It renders authored content only, so it has no access-control role.

Because it's a field formatter, there is no site-wide settings page — you switch it
on per field, on whichever display (view mode) should show the shortened version.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You select the formatter on a
field's display, described in "How to use it" below.

## How to use it

1. Go to the entity you want to affect — for example **Structure → Content types →
   *(your type)* → Manage display** (`/admin/structure/types`).
2. Choose the **display / view mode** where you want the shortened text, typically
   **Teaser**. (Use the tabs or the "Custom display settings" at the bottom to enable
   and edit the Teaser display if it isn't already.)
3. Find your body-style text field and, in its **Format** column, select the **First
   Paragraph** formatter.
4. Click **Save**.

Content shown in that view mode will now display only its first paragraph, while the
full display (for example the Default view mode on the full node page) can continue
to show the complete body.
