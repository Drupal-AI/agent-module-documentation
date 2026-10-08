# Search API CLIR — manual setup guide

**Search API CLIR** (`search_api_clir`) brings *cross-language information
retrieval* to Search API. The name is a mouthful, but the idea is simple: it lets
a search in one language surface content that only exists in another. If a visitor
searches in German but the only matching article is in English, CLIR makes that
English fallback show up — even for full-text searches, where a naive fallback
would fail because "black" and "schwarz" are different words.

Here is the problem it solves. Search API can already index a piece of content in
its original language and offer it as a fallback when a translation is missing.
That works fine for filtered, non-full-text searches. But full-text search matches
on the *words* people type, so an English fallback never matches a German or French
query. CLIR closes that gap by adding a machine translation of the fallback content
to the index. It assumes the output of a machine-translation service (DeepL,
Google, Microsoft — wired up through TMGMT) is good enough to make the content
findable, so a query in the interface language can reach content that was only ever
written in the fallback language.

This module needs configuration and a few moving parts before it does anything —
it is not an on-enable feature. You set up a TMGMT "Continuous Job" for each
target language, add a "Language (with fallback)" field to your index, turn CLIR
on in the index's edit form, and re-index. It depends on core's **Language**
module, **Search API**, and **TMGMT Locale** (`tmgmt_locale`), and it provides its
own permissions. Two caveats are worth knowing up front: CLIR currently works
**only with the Search API Solr backend** (other backends can't hold several
language-specific fields in one record), and the fallback language must be your
site's default language.

This guide is written for a **human** setting the module up through the admin UI.
If you are an AI agent, read the sibling [`agent/`](../agent/start.md) docs
instead — they are terser and cheaper to consume.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies.

## How to use it

Search API CLIR has no settings page of its own; you drive it through TMGMT and
your Search API index. Once the module and its dependencies are enabled, the
workflow is:

1. Add a TMGMT **Continuous Job** and activate **Search API CLIR** on it for every
   language you want to target.
2. Add a **Language (with fallback)** field to your Search API index.
3. Open your index's edit form and **enable CLIR**.
4. Re-index your content.
5. Run `drush clir-rt --auto-accept` (or wait for cron, if you have enabled CLIR
   for cron in the index edit form), then re-index again so the accepted machine
   translations are written into the index.

Keep in mind that re-indexing is not yet triggered automatically for every piece
of content when a machine translation is added and accepted, so a manual re-index
after the translation step is part of the normal routine.
