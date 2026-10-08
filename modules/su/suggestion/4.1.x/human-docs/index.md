# Suggestion — manual setup guide

**Suggestion** (`suggestion`) adds auto-complete search suggestions to your site.
As a visitor types in a search box, it offers completions drawn from what your site
actually contains — so people search using your content's real vocabulary instead of
guessing. It works alongside standard Drupal search, Search views, and Apache Solr,
but it is not reliant on any of them.

A search box with no suggestions leaves visitors guessing your wording, and the
guesses are often wrong — someone types "car park" on a site that says "parking".
Suggestion fixes that by building its own n-gram index from your content and serving
type-ahead completions from it, keeping the suggestions current automatically as
content changes. It draws on **three sources**: the **titles** of the content types
you choose (a starting point that needs a reasonable amount of content to be useful),
**priority suggestions** you add by hand in the admin interface (scored highest, for
when the automatic set is not good enough), and **surfer searches** — the terms real
visitors actually search for, which organically strengthen good suggestions over
time. In every case the strings are tokenized (lower-cased, stopwords and very
short/long words removed) and broken into different-length n-grams that are scored
for ordering.

The module needs a little setup and, usually, some tuning: because the number of
suggestions is tied to how much content you have, the thresholds often need adjusting
to get good results. It has **no module dependencies**. Administration lives at
`/admin/config/suggestion` behind the *Administer suggestion* permission, and the
autocomplete endpoint is deliberately open so any visitor's search box can use it.

**One thing worth checking on sites with restricted content.** Indexing filters on
publication status, so unpublished nodes never contribute suggestions. However, the
filter is *publication status*, not *node access* — so content that is published but
restricted by a node-access module (for example Group or a realm-based access module)
is still indexed, and its wording can surface as a suggestion. If your site has
per-node access restrictions, review what is being indexed.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the terser sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose content types, tune the
   thresholds, and manage suggestions.

## Where it lives in the admin menu

Settings are at **Configuration → Suggestion** (`/admin/config/suggestion`), behind
the *Administer suggestion* permission. Individual suggestions can be edited or
removed at `/admin/config/suggestion/edit/{ngram}`. The autocomplete data is served
from `/suggestion/autocomplete`, which powers the type-ahead in your search box.
