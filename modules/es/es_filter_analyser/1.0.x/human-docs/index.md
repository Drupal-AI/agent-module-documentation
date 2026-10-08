# ElasticSearch Filter-Analyser Management — manual setup guide

**ElasticSearch Filter-Analyser Management** (`es_filter_analyser`) gives you a
central, UI‑driven way to define the **filters** and **analysers** Elasticsearch
uses to process text — tokenization, stemming, synonyms, stopwords and the like —
without hand‑editing index mappings. It plugs those definitions into the **Search
API** + **Elasticsearch Connector** stack so they are applied automatically when
your index is (re)built.

The module models Elasticsearch's own structure as Drupal configuration entities:
a **filter** wraps and configures a native Elasticsearch filter (for example
choosing a stemmer language), and an **analyser** assembles one or more filters
into a reusable analysis chain. Those analysers can then be assigned field by
field, injected into the field mapping when the index is regenerated, and even used
as a query‑time `search_analyzer`. Because they are configuration entities rather
than code plugins, they are easy to manage, reuse and export.

This is a search‑tuning tool for site builders and developers who want better
relevance and control over how text is indexed and matched. Administration is
gated by the **Administer ES filter/analyser** permission (`administer
es_filter_analyser`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its search‑stack dependencies.

The module does not have a single global "settings" form; instead you create and
manage filter and analyser configuration entities from its admin screens, described
in "How to use it" below.

## How to use it

1. Grant the **Administer ES filter/analyser** permission (`administer
   es_filter_analyser`) to the roles that should manage analysis — usually
   administrators — under **People → Permissions**.
2. From the module's admin interface, create one or more **filters**, each mapping
   to a native Elasticsearch filter and configured as needed (for example a stemmer
   with a chosen language, or a synonym filter).
3. Create one or more **analysers**, combining the filters you defined into a
   reusable analysis chain.
4. Assign an analyser to the fields that should use it. When the Elasticsearch
   index is rebuilt, the module injects the filters and analysers into the index
   settings and field mappings automatically, and can apply a search‑time analyser
   when queries run.
5. Rebuild/reindex your Search API index so the new analysis takes effect, then
   test a few searches to confirm the relevance behaviour you were after.
