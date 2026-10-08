# Auto Taxonomy Term Translation — manual setup guide

**Auto Taxonomy Term Translation** (`auto_term_translate`) brings Auto Node
Translate's machine-translation workflow to taxonomy terms. Term translation is
the part of a multilingual build that tends to be left until last and then done
by hand — a site with a few hundred tags, categories, or product attributes
needs every one translated for the language switcher to work properly. This
module makes that a bulk operation instead of a manual slog.

It adds two things: a **translate tab on an individual term**, and — more
usefully — a **bulk form for a whole vocabulary** at
`/vocabulary/{vocabulary}/bulk-auto-translate-form` that runs every term through
whichever translation provider Auto Node Translate is configured with. Because
it reuses that provider, the term text is sent to the same translation service
you have already set up for nodes (for example Google Cloud Translation or
LibreTranslate) — so be aware term content leaves your site for translation.

Access is handled carefully, which is worth noting because a bulk translate form
is exactly the kind of route that often gets a single flat permission. The
module first defers to core's content-translation access for the entity, and
only falls back to its own permission, **`use bulk auto translate`** (marked
"restrict access"). Grant that permission only to trusted editors.

One editorial caution to pass on: single-word terms are the weakest case for
machine translation — there is no surrounding context to disambiguate them, and
a term is often the label a whole section of the site is filed under. Treat the
bulk output as a first pass and have someone review it, not as a finished
translation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm its dependencies.

## Where it lives in the admin menu

This module has no settings form of its own — it reuses Auto Node Translate's
settings (route `auto_node_translate.settings`), which is where you choose and
configure the translation provider. Auto Taxonomy Term Translation adds a
**translate** tab on each taxonomy term and a **bulk auto-translate** form for
each vocabulary (`/vocabulary/{vocabulary}/bulk-auto-translate-form`).

## How to use it

1. Make sure Auto Node Translate is installed and its translation provider is
   configured (see that module's own docs). This module sends term text through
   that provider.
2. Grant **`use bulk auto translate`** to the roles that should be able to run
   bulk term translation, at **People → Permissions**.
3. To translate a single term, open it and use its **translate** tab.
4. To translate a whole vocabulary, go to
   `/vocabulary/{vocabulary}/bulk-auto-translate-form`, choose the target
   language(s), and run it.
5. Review the results — machine-translated single-word terms especially should
   be checked by a human before you rely on them.
