# Details Summary Field Formatter — manual setup guide

**Details Summary Field Formatter** (`details_summary_field_formatter`) is a field
formatter that renders an existing text field's value inside a native HTML
`<details>` element, with a clickable `<summary>` heading to expand and collapse
it. It's ideal for FAQs, "question and answer" content, long descriptions, terms,
or anything that reads better when tucked behind a heading the reader can open on
demand.

You don't create a new field with this module — you change how an *existing* text
field is displayed. On a text field's **Manage display** you pick the "Details with
Summary" formatter, choose whether the disclosure starts open or closed, and set a
custom summary label (or leave it blank to fall back to the field label). It works
with the `text`, `text_long` and `text_with_summary` field types, and multi-value
fields get one `<details>` block per value.

It's a lightweight, safe display-only module: the field body is rendered through
Drupal's text-format pipeline, and your custom summary is sanitised before display,
so it introduces no cross-site-scripting surface. It has no permissions, routes,
database tables or external calls, and is covered by Drupal's security advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. All of its options live on the
formatter itself, in Field UI's **Manage display**, described below.

## Where it lives in the admin menu

The module adds no admin settings page. You use it under **Structure → Content
types (or other entity types) → *(bundle)* → Manage display**.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage display**.
2. For a text field (`text`, `text_long`, or `text_with_summary`), change its
   **Format** to **Details with Summary**.
3. Click the gear/settings icon and configure:
   - **Expanded** — leave on (the default) to render the details open, or turn it
     off to render it collapsed until the reader clicks the summary.
   - **Custom Summary** — the heading text shown on the summary line. Leave it
     blank to use the field's own label instead.
4. Save the display. Each field value now renders inside its own collapsible
   `<details>` block.

> **Tip:** For untrusted authors, pair the field with a **text format** that
> restricts allowed HTML — the formatter respects that format's filtering.
