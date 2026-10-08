# Minifier HTML Source Output — manual setup guide

**Minifier HTML Source Output** (`minifier_html`) shrinks the size of the HTML your
site sends to browsers. On every HTML response it strips whitespace and comments
from the markup — and from any inline CSS and JavaScript inside it — to reduce the
number of bytes on the wire. On a sample page the module cut output from about
11,365 bytes to 9,656, roughly a 15% saving.

It works the moment you enable it and has **no settings whatsoever** — the
project's own guidance is simply "just install the module, no settings are
required." It has no dependencies, no routes, no permissions, and no configuration
page.

That total absence of configuration is also the catch you need to understand before
you deploy it, because there are **no exclusions** and no way to add any. The
module runs a single whitespace-collapsing regular expression over the *entire*
document, with no special handling for `<pre>`, `<code>`, `<textarea>`, or
`<script>`:

- **`<pre>` / `<code>` formatting is destroyed.** Indentation and line breaks in
  code samples, configuration snippets, poetry, or ASCII diagrams are collapsed, so
  any page that publishes preformatted text loses that formatting.
- **`<textarea>` values are altered — and this can silently corrupt stored
  content.** A textarea's contents are its *value*, not just presentation. When an
  edit form loads with the module active, whitespace inside textareas is collapsed;
  if an editor then saves that form (even after changing only, say, the title), the
  flattened text is written back — destroying paragraph breaks and spacing in the
  body, with the original recoverable only from a previous revision. This affects
  every textarea site-wide, including the one-value-per-line settings forms common
  in Drupal.
- **All HTML comments are removed unconditionally**, and the block-comment pattern
  is applied to script contents, so a JavaScript string containing `/*` can be
  truncated to the next `*/`.

Because of that, the honest recommendation is: if reducing page size is your goal,
do the minification at a **CDN or reverse proxy** instead — those exclude `<pre>`
and `<textarea>` precisely because this problem is well known. Only consider this
module on a site that publishes no code samples and where admin/editing textareas
aren't a concern, and even then, weigh the ~15% saving against the risk of silent
content loss.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (and read the warnings first).

There is **no configuration page** for this module — it has no settings at all, and
therefore no exclusions. The only "off switch" is to uninstall it.

## Where it lives in the admin menu

Minifier HTML adds nothing to the admin menu — no page, block, permission, or
setting. Once enabled it minifies every HTML response automatically. To stop it,
uninstall the module.

## How to use it

There is nothing to use, click, or configure — enabling the module turns
minification on for every HTML response, and uninstalling it turns minification
off. Given the caveats above, decide deliberately whether to enable it at all; if
your content has already been flattened, check node revisions to recover the
original text.
