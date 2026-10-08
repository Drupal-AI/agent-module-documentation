# Regex Text Replacement — manual setup guide

**Regex Text Replacement** (`regex_text_replacement`) adds a **text-format filter**
that applies regular-expression find-and-replace to content at render time. You
configure it as a simple list of `pattern||replacement` lines, and the filter
rewrites the output every time an affected field is displayed — without touching
the stored text.

The use case is almost always **inherited content**. A migration brings in
thousands of nodes with a legacy domain in every link, or a tracking parameter on
every image, or an old shortcode syntax nobody wants to update by hand. Editing
the stored text is the honest fix but is sometimes impossible — the source keeps
getting re-imported, the change needs to be reversible, or nobody will sign off on
a bulk update of the body field. A render-time filter handles exactly those cases:
the stored content stays untouched and the displayed output is corrected. Unchecking
the filter reverses the whole thing.

It depends only on core's **Filter** module and works on any text format. Failures
are handled gracefully: a bad pattern is logged and skipped rather than throwing,
so a mistake degrades to "no replacement" instead of a broken page.

Because regex on real content can be a footgun, there are a few important cautions
— catastrophic backtracking, filter ordering, and the fragility of regex on HTML —
covered in [Configuration](configuration/index.md). Read them before you deploy a
pattern to a busy site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the filter to a text format,
   write `pattern||replacement` lines, and the cautions that matter.

## Where it lives in the admin menu

Regex Text Replacement has no dedicated settings page of its own. Instead it adds a
filter you enable and configure **per text format**, at **Configuration → Content
authoring → Text formats and editors** (`/admin/config/content/formats`) — edit a
format, tick the **Regex Text Replacement** filter, and set its patterns.
