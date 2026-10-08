# Search API Synonym — manual setup guide

**Search API Synonym** (`search_api_synonym`) lets you manage a dictionary of
search synonyms and common misspellings, then hand it to your search engine so it
treats related words as equivalent. A visitor searching for "car" can be made to
also match "automobile", and someone who misspells a query can still find what they
meant. Each entry is stored as a content entity you manage in the admin UI, with a
base word, one or more synonyms, a type (a genuine *synonym* or a *spelling error*),
and a language.

The point of the module is to get those synonyms **into your search backend**. Out
of the box it exports a **Solr synonyms file** — the format Apache Solr reads — and
you can regenerate that file automatically on cron or on demand from Drush. The
export system is pluggable, so a developer can add support for other search engines,
and the import system is pluggable too: you can bulk-load synonyms from **CSV**,
**JSON**, or an existing **Solr synonyms text file**.

It is built for multilingual sites (synonyms are per-language) and comes with a
Drush command for scripted or scheduled exports, including incremental exports that
only include entries changed since a given time.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent (including the import/export
plugin types and the Drush command), read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (needs Options and Views).
2. [Configuration](configuration/index.md) — manage synonym entries, set up the
   export/cron settings, import from a file, and the permissions.

## Where it lives in the admin menu

The synonym list is at **Configuration → Search and metadata → Search API
Synonyms** (`/admin/config/search/search-api-synonyms`). The **Settings** form (for
export and cron) and the **Import** screen are tabs on that same page.
