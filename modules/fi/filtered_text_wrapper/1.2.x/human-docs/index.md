# Filtered Text Wrapper — manual setup guide

**Filtered Text Wrapper** (`filtered_text_wrapper`) is a text-format filter that
wraps the processed output of a WYSIWYG/CKEditor field in a configurable **prefix**
and **suffix** — for example a `<div class="wysiwyg">` … `</div>` container around
every piece of content saved with that format. Themes often need editor content
inside a known container so scoped CSS (or JavaScript behaviours) can target it,
and this saves editors from typing wrapper markup by hand. It depends only on
core's Filter module.

The prefix and suffix default to `<div class="wysiwyg">` and `</div>`, and you set
them per text format, so a "Full HTML" format can have a different wrapper than a
"Basic HTML" one. The wrapper strings are emitted exactly as you type them and are
*not* re-sanitised, which is fine because only administrators (users with the
**Administer filters** permission) can set them — there is no path for an
untrusted author to influence the wrapper. Because the markup isn't re-filtered,
keep the wrapper to simple container tags and **order this filter after your
allowed-HTML filter** (usually last) so it stays the outermost element and your
body sanitisation still runs on the content itself.

There is no separate settings page — you configure the wrapper on each text format.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings form** — the prefix and suffix live on the filter
inside each text format, described in "How to use it" below.

## Where it lives in the admin menu

You manage the wrapper from the standard **Text formats and editors** page:
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and
   click **Configure** on the format you want to wrap.
2. Under **Enabled filters**, tick **Wrapper**.
3. In the **Wrapper** filter settings, set the **prefix** (emitted before the
   content) and **suffix** (emitted after it). The defaults are
   `<div class="wysiwyg">` and `</div>`; change them to any container tags you
   need, such as a `<section>` or `<article>` wrapper.
4. In the **Filter processing order** section, drag **Wrapper** to run *after* your
   "Limit allowed HTML tags" filter — typically last — so it wraps the
   already-sanitised content as the outermost element.
5. Click **Save configuration**.

To stop wrapping content for a format, simply untick the **Wrapper** filter on that
format.
