# Filter Tooltips — manual setup guide

**Filter Tooltips** (`filter_tooltips`) turns words in your WYSIWYG content into
inline tooltips driven by a taxonomy vocabulary. You keep a vocabulary of glossary
terms — each term's **name** is the trigger word and its **description** is the
explanation. When one of those words appears in formatted text, the filter wraps
it so readers see the description on hover or click. It is perfect for glossaries,
jargon helpers, and definitions, and it keeps all the definitions centrally
editable as taxonomy rather than scattered through your content.

Matching can be **automatic** — the filter finds occurrences of your term names in
the text and adds tooltips, with an optional limit on how many times per term — or
**manual**, where an editor inserts a tooltip deliberately using the bundled
CKEditor plugin. Either way you choose the trigger event (hover or click), and the
term description is escaped on output so the tooltip text can't inject markup.
Terms without a description are skipped, and the filter avoids nesting tooltips
inside existing links.

Filter Tooltips is a text-format filter, so there is no site-wide settings page.
You enable and tune it per text format, and all of its options live right there on
the filter's own settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no separate configuration page** — every setting lives on the filter
inside a text format, described in "How to use it" below.

## How to use it

**1. Create the glossary vocabulary.** Go to **Structure → Taxonomy**
(`/admin/structure/taxonomy`) and create (or reuse) a vocabulary. Add a term for
each word you want to explain: put the trigger word in the term **name** and the
explanation in the term **description**. Terms with no description are ignored.

**2. Enable the filter on a text format.** Go to **Configuration → Content
authoring → Text formats and editors** (`/admin/config/content/formats`), click
**Configure** on the format you want, and under **Enabled filters** tick **Display
tooltips in text**. Then set the filter's options:

- **Source vocabulary** — the vocabulary whose terms supply the trigger words and
  tooltip text.
- **Automatic vs manual replacement** — automatic finds and wraps matching words
  for you; manual leaves it to editors using the CKEditor plugin.
- **Limit occurrence** — how many times a given word gets a tooltip. Set it to
  `-1` to wrap every occurrence, `1` for only the first, and so on.
- **Excluded tags** — HTML tags (for example `h1`) inside which words should *not*
  be turned into tooltips.
- **Trigger event** — whether the tooltip appears on **click** or on **mouseover**
  (hover).
- **Clear cache** — when ticked, some caches are cleared so that edits to a term
  show up immediately when you save it.

**3. Save the format.** Content rendered with that format now shows tooltips for
your glossary terms.
