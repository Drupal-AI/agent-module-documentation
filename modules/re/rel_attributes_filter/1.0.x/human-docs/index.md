# Rel Attributes Filter — manual setup guide

**Rel Attributes Filter** (`rel_attributes_filter`) is a text-format filter that
automatically adds `rel` attributes — **`nofollow`**, **`noopener`**, and
**`noreferrer`** — to links in filtered content. Editors don't have to remember
to add them, and they can't forget: the filter applies the attributes at render
time. It's based on the older Noopener filter module, extended to also cover
`nofollow` and `noreferrer`.

Two real problems share this one solution:

- **SEO.** Adding `rel="nofollow"` to user-contributed and outbound links stops
  your site's authority from flowing to spam. This is the standard defence on any
  site with comments or community content.
- **Security.** Adding `rel="noopener"` to links that open in a new tab
  (`target="_blank"`) prevents the opened page from reaching back through
  `window.opener` and navigating your original tab somewhere else — the
  "tabnabbing" pattern. Modern browsers imply `noopener` for `target="_blank"`,
  but older ones do not, and the explicit attribute remains the correct defence.

Handling this in a **text filter** rather than a CKEditor plugin is the right
choice, because a filter applies at render time to *all* content — including
content that predates the rule, content brought in by migration, and content
submitted through an API — where an editor plugin would only affect what is typed
after it was installed.

The module depends only on Drupal core and runs on Drupal 8, 9, 10, and 11. It
has **no configuration page of its own**; you enable and configure it per text
format, as described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** — the filters are turned on and off
per text format, described in "How to use it" below.

## How to use it

The filters live inside Drupal's text-format settings:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the text format you want to affect (for example
   *Basic HTML* or a comment format).
3. Under **Enabled filters**, tick the Rel Attributes filter(s) you want — the
   `nofollow`, `noopener`, and `noreferrer` options.
4. Scroll to **Filter processing order** and check where the filter sits. It must
   run at a point where the rendered `<a>` tags are present in the markup, so if
   attributes are not appearing, adjust its position relative to other filters.
5. Click **Save configuration**.

Repeat for each text format that should apply the rules. From then on, links in
content using those formats carry the chosen `rel` attributes automatically —
including older and imported content, since the work happens at render time.

> **Note:** The module adds these attributes when text is rendered; it does not
> currently alter links via `hook_link_alter`, so it targets links inside
> filtered text, not every link on the page.
