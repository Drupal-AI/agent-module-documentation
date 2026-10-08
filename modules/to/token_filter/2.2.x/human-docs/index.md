# Token Filter — manual setup guide

**Token Filter** (`token_filter`) is a text‑format input filter that replaces tokens
— placeholders like `[site:name]` or `[node:title]` — with their real values when a
field is rendered. It bridges the popular Token module into Drupal's text‑format
(input filter) system, so authors can drop dynamic values straight into body copy,
custom blocks, and other formatted fields without any custom code.

It handles **global tokens** (site name, current date, the logged‑in user) always,
and **entity tokens** (the current node's title, author, URL, and so on) when the
filtered text is a field on a content entity. When the Token module is installed it
also adds a **"Token browser"** button to CKEditor 5, so editors can pick tokens from
the standard token tree instead of memorizing them. It depends on core's **Filter**
module and the contrib **Token** module (`drupal/token`), which Composer installs
alongside it.

Token Filter does **not** work simply by being enabled — you have to switch the
filter on for each text format where you want tokens expanded. It has no settings page
or permissions of its own; all of its configuration lives on the standard **Text
formats and editors** screen. It also ships a migration mapping so a Drupal 7
`filter_tokens` filter converts to `token_filter` automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it pulls in the Token module).
2. [Configuration](configuration/index.md) — enable and order the filter on a text
   format, and add the CKEditor 5 token browser.

## Where it lives in the admin menu

There is no dedicated Token Filter page. You configure it on the text‑format screen at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`): edit a format, tick the Token Filter checkbox, and
order it in the filter processing list. See [Configuration](configuration/index.md)
for the walk‑through.
