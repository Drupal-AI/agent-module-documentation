# htmLawed HTML filter/purifier — manual setup guide

**htmLawed HTML filter/purifier** (`htmlawed`) adds a single text‑format input
filter that runs your content through the bundled htmLawed PHP library to
restrict, correct, and purify HTML. In plain terms: it decides which HTML tags
and attributes are allowed in a text format, strips anything unsafe or
disallowed, and cleans up broken markup along the way.

You don't configure htmLawed from a settings page of its own. Instead you turn on
the **htmLawed** filter inside one or more of Drupal's text formats (Basic HTML,
Full HTML, or your own), and each format gets its own htmLawed policy. Because it
both restricts tags *and* balances/repairs markup — closing unclosed tags,
correctly nesting elements, fixing chopped‑off HTML — it can replace core's
"Limit allowed HTML tags" and "Correct faulty and chopped off HTML" filters with
one more configurable filter.

htmLawed is often used as a security tool: with its `safe` mode on it drops
scripts, `on*` event attributes, and dangerous URLs to defend against stored XSS,
and it can whitelist exactly the tags you trust. It does **not** turn URLs into
links or convert newlines into paragraphs — pair it with other filters for that,
and generally run it *last* so it validates whatever the earlier filters produced.

> htmLawed's main **Config.** setting is written as PHP array syntax and is
> evaluated as PHP when the filter runs. Editing it requires core's *Administer
> filters* permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable and tune the filter on a text
   format, field by field.

## Where it lives in the admin menu

htmLawed has **no standalone settings page**. You work with it inside the text
format screens at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`). Open a format, enable the *htmLawed*
filter, and configure it there. Its built‑in help (including the full library
reference) is at `/admin/help/htmlawed`.
