# Code Filter — manual setup guide

**Code Filter** (`codefilter`) provides a text-format filter that handles
`<code>...</code>` and `<?php ... ?>` tags so authors can post code without
manually escaping `<` and `>` into `&lt;` and `&gt;`. Content between those tags
is escaped once and rendered as a formatted `<pre><code>` block — and, for PHP,
it adds basic syntax highlighting. It is one of the oldest modules in the
ecosystem (drupal.org itself uses it) doing a job that has not really changed.

The problem it solves is the constant fight between code and the filter chain:
angle brackets get stripped or interpreted, ampersands double-escape, the editor
turns straight quotes into curly ones, and a snippet that was correct in the
field comes out wrong on the page. On a documentation site that is not cosmetic —
a reader copies exactly what they see, so a mangled snippet is a broken
instruction. Code Filter takes the direct approach: escape the content once, wrap
it, and leave it alone.

There is an important security point, and it is the opposite of what "filter"
sometimes implies: **this filter's job is escaping, and the escaping is what
makes it safe.** Content between the tags becomes plain text, so a `<script>` in a
code sample is *displayed*, not executed. That safety depends on **filter order**
— Code Filter must run in the right position relative to any HTML-permitting
filter in the same text format. It is worth checking the order when you set it
up.

The complementary point: it **escapes**, it does not do full **syntax
highlighting** (beyond the basic PHP colouring). Rich language highlighting is a
separate concern handled by modules like Highlight.js or Prism — and if you
combine them, make sure the highlighter operates on Code Filter's escaped output
rather than fighting it.

It has no dependencies and no configuration form of its own; you enable it as a
filter within a text format. It supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings page** — you turn the filter on inside a text
format, described in "How to use it" below.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose the text format your authors use for code (for example *Basic HTML* or
   *Full HTML*), or create a dedicated one, and click **Configure**.
3. Under **Enabled filters**, tick the **Code filter** (the option to handle
   `<code>` and `<?php ?>` tags).
4. Check the **Filter processing order** section. Code Filter needs to run in the
   correct position relative to any HTML-permitting filter so the escaping is not
   undone — adjust the order if needed.
5. Save the format. Authors can now wrap code in `<code>...</code>` or
   `<?php ... ?>` and have it rendered safely as a code block.
