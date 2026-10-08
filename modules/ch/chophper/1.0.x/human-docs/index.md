# chophper — manual setup guide

**chophper** (`chophper`) provides field formatters that **truncate formatted-text
fields while keeping the HTML valid**. Core's built-in "Trimmed" formatter cuts a
body field at a character count without regard for markup, which can slice through
the middle of a tag and leave broken HTML. chophper does the same job through the
[Chophper PHP library](https://github.com/code-atlantic/chophper), which is aware
of HTML structure and closes tags cleanly, so a truncated summary still renders as
well-formed markup.

It adds two field formatters for text fields:

- **Trimmed (Chophper)** — truncates the field value. It's the equivalent of core's
  Trimmed formatter, but uses Chophper for the cut so the resulting HTML stays
  intact.
- **Summary or trimmed (Chophper)** — renders the field's manual summary when one
  exists; otherwise it falls back to truncating the field value with Chophper.

You apply these entirely from a field's **Manage display** settings — there's no
site-wide settings page. The module depends on core's **Text** module and on the
`code-atlantic/chophper` PHP library, which Composer installs for you.

> **Note:** this project is **not covered by Drupal's security advisory policy**.
> Weigh that against your site's risk tolerance before using it on a production
> site, and keep it updated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   the Chophper PHP library) and enable the module.

There is **no configuration page** for this module. You set it up per field on the
entity's **Manage display** tab, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Structure → Content
types (or any fieldable entity) → *(bundle)* → Manage display**.

## How to use it

1. Go to the bundle's **Manage display** tab (for the view mode you want, such as
   *Teaser*).
2. For a formatted-text field (for example **Body**), choose **Trimmed (Chophper)**
   or **Summary or trimmed (Chophper)** in the **Format** column.
3. Open the formatter settings (the gear icon) to set the trim length, then
   **Update** and **Save**.
4. View a piece of content in that view mode — the field is now truncated with
   valid HTML.
