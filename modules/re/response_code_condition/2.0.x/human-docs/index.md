# Response Code Conditions — manual setup guide

**Response Code Conditions** (`response_code_condition`) adds a new **Response
code** option to Drupal's condition system — the same set of checks you already
use to decide when a block should appear. With it, a block can be shown (or
hidden) based on the HTTP status code of the current request, which makes it the
tidy way to put content on error pages such as **403 Access denied** and **404
Not found**.

Under the hood it looks at the error attached to the current request and
compares its status code against a short list you type in — one code per line.
The maintainers designed it for **4xx** codes (401, 403, 404 and friends), so it
matches error responses rather than ordinary pages that return 200. Because it
plugs into the standard condition system, it also honors the familiar **Negate**
checkbox, letting you invert the rule to mean "everywhere except these codes."

There is nothing to configure globally and no settings page of its own — you
simply pick the condition when you place or edit a block and fill in the codes.
It depends only on Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You use the condition
directly on a block, described in "How to use it" below.

## How to use it

1. Go to **Structure → Block layout** and place (or edit) the block you want to
   scope to error pages.
2. Open the block's **Visibility** settings and find the **Response code**
   condition.
3. Enter the status codes you want to match, **one per line** — for example
   `404` on its own, or `403` and `404` on separate lines.
4. Optionally tick **Negate the condition** to show the block *everywhere except*
   those codes.
5. Save the block.

The block now appears only when the request returns one of the listed 4xx
codes — perfect for a "page not found" helper on 404s or a support/contact
prompt on 403s.
