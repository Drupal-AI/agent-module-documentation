# Entity Label — manual setup guide

**Entity Label** (`entity_label`) lets site builders define human‑friendly
**singular and plural labels** for each content entity bundle — including the
definite ("the") and indefinite ("a/an") article forms — and then print them
anywhere through **tokens** or a **Twig function**. It's a way to keep consistent,
editor‑facing wording ("Article" / "Articles" / "an article" / "the articles")
without hardcoding those strings all over your templates and messages.

It works by adding a **"Label settings"** group to every bundle edit form — any
config‑entity bundle such as node types, taxonomy vocabularies, or media types.
There you fill in up to five values: the singular label, its definite and indefinite
article forms, the plural label, and its definite article form. The values are stored
as third‑party settings on the bundle, and the module extends the config schema so
they are properly typed and translatable through the config translation UI.

Once set, you can output the labels two ways: **tokens** like `[node:label:singular]`
or `[node:label:plural-definite-article]` (available on any content entity type that
has a bundle), and a **Twig function** `entity_label(entity, 'plural')` for use in
templates. It is a purely presentational metadata module — no routes, no permissions,
no services beyond the Twig extension, and no external calls. Editing the labels
simply rides on the existing permission to edit a bundle.

> **Heads‑up on project status:** at the documented version this project is marked
> **unsupported / obsolete** on Drupal.org. It still functions as described, but
> factor its maintenance status into your decision to adopt it on a new site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no central settings form. Labels are set directly on each bundle's edit
form, and output through tokens or Twig — described in "How to use it" below.

## How to use it

After enabling the module:

1. **Set the labels on a bundle.** Edit a content type, vocabulary, media type, or
   other bundle (for example **Structure → Content types → *(type)* → Edit**). Find
   the **Label settings** group and fill in the forms you need:
   - **Singular** — e.g. "Article".
   - **Singular, definite article** — e.g. "the article".
   - **Singular, indefinite article** — e.g. "an article".
   - **Plural** — e.g. "Articles".
   - **Plural, definite article** — e.g. "the articles".
   Save the bundle.
2. **Print a label in Twig.** In a template:
   ```twig
   {{ entity_label(node) }}                {# singular #}
   {{ entity_label(node, 'plural') }}
   {{ entity_label(term, 'singular_indefinite_article') }}
   ```
   The type argument is one of `singular` (the default),
   `singular_definite_article`, `singular_indefinite_article`, `plural`, or
   `plural_definite_article`.
3. **Print a label with a token.** Use tokens such as `[node:label:singular]`,
   `[node:label:plural]`, or `[node:label:plural-definite-article]` in messages,
   views, or emails — on any content entity type that has a bundle.
4. **Translate the labels (optional).** Because the values are translatable config,
   you can localize them through the config translation UI.
