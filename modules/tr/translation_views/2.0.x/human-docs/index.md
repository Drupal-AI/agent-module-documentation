# Translation Views — manual setup guide

**Translation Views** (`translation_views`) exposes a set of translation‑related
**fields and filters** to Views, so you can build translation dashboards and worklists
for any translatable entity. Out of the box, Views can list content but tells you little
about *translation status*; Translation Views fills that gap — for each row it can show
whether the item is translated into a chosen language, whether that translation is
outdated, when it last changed, how many translations exist, and handy "add / edit
translation" operation links.

The key idea is a **target language**. You add a "Target language" exposed filter to
your view, and the translation fields then report against whichever language the user (or
you) selects — "is this node translated into French yet?", "is the French translation
out of date?", and so on. This makes it easy to build per‑language editorial queues:
one reusable view, driven by the target‑language selector, that any translator can point
at their language.

There is **no settings form, no permissions, and no configuration of its own** — you do
everything inside the Views UI. The module depends on core's **Content Translation** and
**Views** modules, and it ships a ready‑made demo view, "Content translation jobs", at
`/translate/content` that you can use as‑is or clone for other entity types. One
important caveat: the translation fields and filters only appear for entity types that
are translatable **and** have content translation enabled — so turn on translation for
your entity type first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

There is no admin page for the module itself. You work entirely in the **Views** UI
(**Structure → Views**, `/admin/structure/views`), where the new fields and filters
appear under a group named "{Entity} translation" for any translation‑enabled entity
type. The bundled demo dashboard lives at **/translate/content**.

## How to use it

1. Enable content translation for your entity type at **Configuration → Regional and
   language → Content language and translation** — the translation fields won't exist
   until you do.
2. Create or edit a view of that entity type (**Structure → Views**).
3. Add the **Target language** filter and expose it. Its exposed identifier is
   `translation_target_language`; the visitor's choice drives which language the
   translation fields report on.
4. Add translation fields such as **translation status** (translated / not into the
   target), **outdated**, **translation count**, **changed time**, and **operation
   links** (add/edit in the target language).
5. Optionally add a **translation count** filter to find under‑translated content, or an
   **outdated** filter to build a "needs review" queue.

Tip: the shipped **Content translation jobs** view at `/translate/content` is a working
example — duplicate it as a starting point for media, taxonomy terms, or your own
translatable entities.
