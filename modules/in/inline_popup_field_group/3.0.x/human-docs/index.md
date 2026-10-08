# Inline Popup Field Group — manual setup guide

**Inline Popup Field Group** (`inline_popup_field_group`) adds a new **field group
format** — called *popup* — to the [Field Group](https://www.drupal.org/project/field_group)
module. When you wrap a set of fields in a popup group, those fields are tucked
away behind a button; clicking the button shows them in a simple popup, and
clicking again hides them. It's a tidy way to declutter a busy form or display by
grouping related fields out of the way until they are needed.

What makes this module different from the older
[Popup](https://www.drupal.org/project/popup) field group is *how* it hides the
fields. Rather than using Drupal's dialog library — which moves the fields into a
dialog and, in nested Paragraphs, can remove the original fields and lose their
data on save — this module keeps every field right where it is, inside a fieldset,
and simply shows or hides that fieldset with buttons. Because the fields never
leave the page, all their information is preserved when you save the node. That
makes it dependable inside nested Paragraphs, which was the exact use case it was
built for.

This is a content‑editing and display convenience that affects layout only. It has
no access‑control role: the fields inside a popup group follow their normal field
access, and nothing about who can see or edit a field changes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module along with Field Group.

This module has **no settings form of its own**. You use it exactly like any other
Field Group format, on your entity's form display or view display, as described in
"How to use it" below.

## Where it lives in the admin menu

Inline Popup Field Group adds no Configuration page. You work with it entirely
inside the Field Group tools on **Structure → Content types → *(bundle)* → Manage
form display** (or **Manage display**), where it appears as the *popup* format when
you add or edit a field group.

## How to use it

1. Make sure both this module and the Field Group module are enabled.
2. Go to the **Manage form display** (or **Manage display**) tab for the bundle you
   want to work with.
3. Use Field Group's **Add group** control to create a new group, and choose the
   **popup** ("Popup Fake container") format.
4. Move the fields you want to hide behind the popup into that group.
5. Set the group's **Link text** — this becomes the label of the button shown on
   the page that opens and closes the popup.
6. Save the display. Your grouped fields now sit behind that button, appearing in a
   popup when it is clicked.

> **Styling tip.** The module ships with an SCSS source file
> (`assets/scss/inline_popup_field_group.scss`) and a Gulp setup, so a front‑end
> developer can run `npm install` and `gulp watch` to recompile the styles and
> fully customize the popup's appearance.
