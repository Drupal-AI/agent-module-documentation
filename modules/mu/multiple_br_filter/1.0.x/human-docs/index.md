# Multiple BR Filter — manual setup guide

**Multiple BR Filter** (`multiple_br_filter`) is a small text‑format filter that
**collapses runs of consecutive `<br>` tags into a single `<br />`**. If you have
ever pasted content from a word processor or an email and ended up with big stacks
of blank lines — each one a `<br>` tag — this filter tidies that up automatically
when the content is displayed.

It works by matching two or more consecutive line‑break tags (in any of the common
forms: `<br>`, `<br/>`, `<br />`, case‑insensitive) and replacing them with one.
The cleanup happens **only at render time** — it is an irreversible transform that
changes the *displayed* output without touching the stored source, so your original
content is preserved exactly as entered.

Setup is entirely through Drupal's standard **Text formats and editors** admin
screen: you enable the filter on whichever text formats need it (Full HTML, Basic
HTML, a comment format, and so on) and position it sensibly in the filter order —
typically after any "Convert line breaks" filter. It depends only on core's Filter
module and has no settings, routes, permissions, or UI of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings form** — the filter is turned on per text format
on the Text formats and editors page, described in "How to use it" below.

## Where it lives in the admin menu

You enable and order the filter at **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`), by editing each text format
where you want it to apply.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the text format you want to clean up (for example
   *Full HTML* or *Basic HTML*).
3. Under **Enabled filters**, tick **Remove multiple consecutive `<br>` tags**.
4. Scroll to **Filter processing order** and place this filter **after** any
   "Convert line breaks" filter, so it runs on the already‑converted output.
5. **Save configuration.**

From then on, content in that format renders with stacked line breaks collapsed to a
single `<br />`, while the stored source stays untouched.
