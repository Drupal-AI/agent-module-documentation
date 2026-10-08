# Paragraphs Tabs Widget — manual setup guide

**Paragraphs Tabs Widget** (`paragraphs_tabs_widget`) is an alternative
**editing** widget for Paragraphs fields: it renders each paragraph in a
multi‑value Paragraphs field as its own **tab** in the edit form. Editing a long
list of paragraphs in one long stacked form is unwieldy — this widget lets editors
switch between paragraphs as tabs instead of scrolling through everything at once.

It is purely an editorial‑UX improvement on the back end. It changes how the
paragraph form is presented while editing; it does not change what is stored or
who may edit it. (Note the distinction from front‑end tab modules: this one
affects the *edit* experience, not how content is displayed to visitors.)
Currently it provides a **vertical tabs** widget, built on Drupal core's
`vertical_tabs` render element. It depends on the Paragraphs module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Paragraphs.

There is **no global settings page** for this module — it is switched on per field
from the field's form display, described in "How to use it" below.

## How to use it

The widget is selected on a Paragraphs field's **Manage form display**:

1. Go to **Structure → Content types → *(your type)* → Manage form display**
   (or the equivalent form display for any other entity type that has your
   multi‑value Paragraphs field).
2. Find the Paragraphs field you want to edit as tabs.
3. In that field's **Widget** column, choose the tabs widget provided by this
   module.
4. Save the form display. When editors work with that field, each paragraph
   appears as a tab rather than as one item in a long stack.

> **Good to know:** the widget relies on core's `vertical_tabs` render element,
> which needs very specific markup and can be fragile if a theme alters it. If the
> tabs do not render as expected, check whether your admin theme is overriding
> that markup.
