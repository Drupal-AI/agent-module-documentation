# Onomasticon — manual setup guide

**Onomasticon** (`onomasticon`) turns a taxonomy vocabulary into an automatic
glossary. A text filter scans your content, finds any words that match glossary
terms, and wraps them in a tooltip (or other markup) carrying the term's
definition — so jargon is explained wherever it appears, without you annotating
each article by hand. Editors maintain the definitions once, in taxonomy, and every
page follows automatically.

The filter is careful about markup: rather than running regular expressions over
raw HTML, it parses the text into a proper HTML5 document and walks it, so
replacements never land inside a tag name or an attribute. It also carries a cache
tag for the glossary vocabulary, which means editing or adding a term automatically
refreshes the rendered pages that use it — no manual cache clear needed.

There's plenty to tune per text format: which vocabulary is the glossary, which
field holds the definition, which HTML tag wraps matches, which tags to skip,
tooltip orientation, cursor, and how the definition is attached. A companion
CKEditor button lets editors mark a passage that should be **excluded** from
glossary processing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

### 1. Build the glossary vocabulary

Create a taxonomy vocabulary (**Structure → Taxonomy**) and add a term for each
glossary word, putting the explanation in the term's **description** (or in a
custom field, if you'd rather — see the settings below).

### 2. Turn the filter on for a text format

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit the format your content uses, and enable
the **Onomasticon Filter** in the *Enabled filters* list. Then set its options:

| Setting | What it controls |
|---|---|
| **Vocabulary** | Which vocabulary holds the glossary terms. **Leave this empty and the filter does nothing** — so always pick one. |
| **Definition field** | The machine name of the field holding the definition; empty means use the term description. |
| **Run definition filters** | Whether to run the definition through Drupal's text filters. ⚠️ The UI warns this **can cause infinite loops and break your site** if definitions themselves contain glossary terms — use with care. |
| **Tag** | The HTML tag that wraps each match. |
| **Disabled tags** | Tags to skip (never annotate inside them); anchors and the wrapping tag are added to this list automatically. |
| **Implementation** | How the definition is attached to the match. Note a `title`‑attribute implementation strips any markup, since attributes can't hold HTML. |
| **Orientation** | Whether the tooltip appears above or below the term. |
| **Cursor** | The mouse cursor shown over a glossary term. |

Save the format. Now any content in that format automatically annotates its
glossary terms.

### 3. Let editors exclude passages

With the filter enabled, editors get a CKEditor button (supported for both
CKEditor 4 and CKEditor 5) to mark a selection as **excluded** from glossary
processing — useful where a word shouldn't be treated as a term in a particular
spot.

> **Performance note:** every render walks the document and matches it against the
> vocabulary, which isn't free on very large bodies or huge vocabularies. Rely on
> the render cache, and avoid enabling the filter on formats used for enormous
> documents.

## Where it lives in the admin menu

There's no dedicated settings page — Onomasticon is configured on each **text
format** at *Configuration → Content authoring → Text formats and editors*
(`/admin/config/content/formats`), and its terms live in a **Taxonomy** vocabulary.
