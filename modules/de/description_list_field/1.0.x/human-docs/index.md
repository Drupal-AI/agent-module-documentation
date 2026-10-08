# Description List Field — manual setup guide

**Description List Field** (`description_list_field`), from the OpenEuropa
project, adds a single field type — also called **Description list** — that stores
repeatable **term / description** pairs and renders them as a semantic HTML `<dl>`
(description list, with `<dt>` terms and `<dd>` descriptions). It is a lightweight
way to capture structured label/value content without reaching for a Paragraphs
bundle or a free-form table.

Each row holds a plain-text **term** and a rich-text **description**, and every
description carries its own **text format** (for example Basic HTML or Full HTML),
chosen per row in the widget. On output, the term is rendered as escaped plain
text (so no markup can be injected from it) and the description is run through its
stored text format. The result is clean, accessible `<dl>` markup that is good for
screen readers and SEO.

It is a good fit for glossary entries, a "Key facts" or specifications block,
FAQ-style question/answer pairs, product attributes, or metadata pairs like
"Published by" / "Contact". It also integrates with TMGMT when that module is
present, treating the term as untranslatable-format plain text during translation
extraction, and it exposes a computed `description_processed` property so code and
REST can read the format-applied description.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is **no module settings page**. You add and configure the field through
**Field UI** — under **Structure → Content types → (your type) → Manage fields**
and the matching **Manage form display** / **Manage display** tabs.

## How to use it

1. On the bundle you want (a content type, taxonomy vocabulary, etc.), go to
   **Manage fields** and choose **Add field**.
2. Pick the **Description list** field type. Give it a label and, since it is a
   list, set the number of allowed values (cardinality) to more than one — or
   unlimited — so editors can add multiple pairs.
3. On the **Manage form display**, the field's widget gives each row a **term**
   text box and a **description** rich-text area with its own **text format**
   selector.
4. On the **Manage display**, use the default formatter — no configuration
   needed. It outputs the pairs as a `<dl>` list.

To customise the markup, copy `description-list.html.twig` into your theme and
override it there.
