# Multiselect Dropdown — manual setup guide

**Multiselect Dropdown** (`multiselect_dropdown`) replaces a tall column of
checkboxes with a compact, select-like control: a single toggle button that opens
a dialog full of checkboxes. The button shows a running summary — "No Items
Selected", "3 Items Selected", "All Items" — so editors and visitors can pick
several values from one tidy widget instead of scrolling a long list.

Under the hood it's a native `<dialog>` driven by plain, modern JavaScript (using
`core/once`, no jQuery), with accessibility in mind — checkboxes carry
`role="option"`, the toggle has an aria-label, and there's optional screen-reader
help. It can show a live search box for long option lists, "Select all" /
"Select none" buttons, nested/indented hierarchical options (handy for taxonomy
trees), and it can become a full-screen modal on small phones while staying inline
on desktop.

You get two ready-to-use pieces: a **form render element**
(`#type => 'multiselect_dropdown'`) for custom forms, and a **field widget** you
can assign on *Manage form display* to multi-value option fields. Two optional
submodules extend it further — one turns it into a Views exposed filter (via
Better Exposed Filters), the other loads a dialog polyfill for older browsers.

This guide is written for a **human** building fields and forms through the admin
UI. If you want terse, token-cheap references for an AI coding agent (the render
element's every `#…` property, theming hooks, required data attributes), read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   choose the optional submodules.

## Where it lives in the admin menu

There's no global settings page. You configure the widget where the field lives:
**Structure → Content types → *(your type)* → Manage form display**
(or the equivalent for any entity), by selecting **Multiselect Dropdown** as a
field's widget and clicking its gear icon.

## How to use it

**As a field widget (the common case):**

1. Add or pick a multi-value option field — the widget applies to
   **Entity reference**, **List (text)**, **List (integer)**, and **List (float)**
   fields whose cardinality is **not 1** (i.e. it allows more than one value).
   Single-value fields won't offer this widget.
2. Go to the bundle's **Manage form display**, and in the field's *Widget* column
   choose **Multiselect Dropdown**.
3. Click the gear to configure the labels and search. The settings include:
   - **Toggle labels** — the accessible aria label plus the text shown for none /
     one / several / all selected. The one/several labels use `%d` as the count
     placeholder (e.g. "%d Items Selected").
   - **Select-all / Select-none button labels** — leave blank to hide those
     buttons.
   - **Search field** — set a *Search title* to switch on a live filter box; you
     can then set its placeholder, how the label is displayed, and a
     **character threshold** (how many characters someone types before filtering
     starts, default 3). Leave the search title blank for no search box.
4. Save. The field now renders as the compact dropdown on the entity's edit form.

Note: the field widget does not include the in-dialog *submit* / *clear* buttons —
those belong to the Views/exposed-filter context. In a field form, ticking and
unticking simply updates the underlying checkboxes.

**As an exposed Views filter:** enable the `multiselect_dropdown_bef` submodule
(see [Installation](installation/index.md)); it registers a Better Exposed Filters
widget so a Views exposed taxonomy/list filter can be presented as this dropdown,
including keeping the dialog open across AJAX filter submissions.

**In a custom form:** developers can use the element directly with
`'#type' => 'multiselect_dropdown'` and the `#…` properties documented in the
[`agent/`](../agent/api/element.md) docs.
