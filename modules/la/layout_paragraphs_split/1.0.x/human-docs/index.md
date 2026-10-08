# Layout Paragraphs Split — manual setup guide

**Layout Paragraphs Split** (`layout_paragraphs_split`) adds a button to the
**CKEditor 5** toolbar that splits a text‑based
[Layout Paragraphs](https://www.drupal.org/project/layout_paragraphs) component
into two at the cursor — and then opens the "add" control between them so you can
drop a new component in the gap.

It solves a very specific editing annoyance. When someone pastes a long block of
text into a single paragraph and then wants to "enrich" it — a call‑to‑action, an
image, a quote — halfway through, they normally have to manually cut the second
half, create a new paragraph below, paste the text back in, and then add the new
component in between. This button does all of that in one click: it cuts the text
after the cursor, closes the edit dialog, duplicates the paragraph to create a new
one below, pastes the cut text into it, and finally opens the "add" button between
the two so you can insert any component type your field allows.

It is designed for the common case of a paragraph type with a **single rich‑text
field**. Splitting a paragraph type that contains several CKEditor 5 fields may
behave unexpectedly, so keep it to simple text components.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no separate settings page** for this module. The only setup step is to
add its button to a text format's CKEditor 5 toolbar, described in "How to use it"
below.

## Where it lives in the admin menu

The Split button is enabled per text format at **Configuration → Content authoring
→ Text formats and editors** (`/admin/config/content/formats`). It then appears in
the CKEditor 5 toolbar whenever you edit a rich‑text paragraph through the Layout
Paragraphs widget.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the text format your Layout Paragraphs rich‑text fields use (for example *Full
   HTML* or *Basic HTML*).
2. In the **CKEditor 5 toolbar configuration**, drag the **Split** button from the
   list of available buttons up into the active toolbar, then save the format.
3. Edit a piece of content that uses a Layout Paragraphs paragraph‑reference field.
   Open a paragraph that has a rich‑text field and place your cursor where you want
   the text to break.
4. Click the **Split** button. The paragraph is divided in two at the cursor, and
   the "add" control opens between the two halves so you can insert a new component
   of any type the field allows.
