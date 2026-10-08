# CKEditor Soft hyphen (shy) — manual setup guide

**CKEditor Soft hyphen Plugin** (`shy`) is a tiny editor add-on that lets authors
insert an invisible **soft hyphen** — `&shy;` — at the cursor, either with a toolbar
button or the **Ctrl+Hyphen** shortcut. A soft hyphen tells the browser "you *may*
break the word here if you need to," and it only ever shows a visible hyphen when a
break actually happens. It's the clean way to control where long words, URLs, or
German-style compound nouns wrap in narrow columns.

The module has two coordinated parts: a **CKEditor 5 plugin** that adds the *Soft
hyphen* toolbar button (and stores the mark as a `<shy>` element in the content), and
a text-format **filter** called *Cleanup SHY markup* that converts that stored markup
into the real soft-hyphen character on output. Both are needed, and both are enabled
per text format — there is no global settings page.

Enabling the module alone does nothing visible: you have to add the button and turn on
the filter on each text format where you want the feature. The module depends only on
core's **CKEditor 5** module. See [Configuration](configuration/index.md) for the
per-format setup, which is quick but has one gotcha (the button won't appear until the
filter is enabled).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — adding the button and filter to a text
   format.

## Where it lives in the admin menu

There's no settings page of its own. You set it up per text format at **Configuration
→ Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — edit a format that uses CKEditor 5, add the *Soft
hyphen* toolbar button, and enable the *Cleanup SHY markup* filter.
