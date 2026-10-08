# Search API Solr NLP — manual setup guide

**Search API Solr NLP** (`search_api_solr_nlp`) brings Apache Solr's **OpenNLP**
natural-language-processing features into a Search API Solr index — things like
named-entity recognition, part-of-speech-aware analysis and sentence detection.

Plain text indexing treats a document as a bag of tokens. That is enough for
keyword search but blind to meaning: it can't tell that "Washington" is a person in
one document and a place in another, or that a phrase is a named entity rather than
three unrelated words. Solr can do better through OpenNLP, which adds language
models for tokenisation, sentence detection, part-of-speech tagging and
named-entity recognition. This module is the wiring that exposes those features to
Search API Solr, so you can build indexes and analysers that understand language
structure — the foundation for entity-aware search, better relevance on
natural-language content, and faceting on extracted entities.

Concretely, it adds new fulltext field types to the Solr config sets that Search
API Solr generates — for example a "nouns" field type that filters text down to its
nouns, which is a great source for autocomplete and spell-check features. Because
OpenNLP relies on trained language models that can be large, this capability lives
in a separate optional module rather than being bundled into Search API Solr
itself.

It depends on **Search API Solr**, whose server it extends, and works on Drupal
10.1 and 11. This release is covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (this pulls the
   pretrained models), enable it, and deploy the Solr config set.

## How it works — a coordinated Drupal-and-Solr setup

This is not a Drupal-only "enable and go" module. OpenNLP needs its language models
and Solr-side configuration present **on the Solr server**, and the Drupal module
cannot supply the models to a running Solr for you — so setup spans both sides.
Once the module is installed, the config sets that Search API Solr generates will
automatically contain all the required files; your job is to make sure your Solr
hosting lets you upload that config set. The default Solr distribution already
includes the OpenNLP libraries. See the [Installation](installation/index.md) page
for the details, including a Solr Cloud note.
