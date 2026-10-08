# Scolta — manual setup guide

**Scolta** (`scolta`) is a Search API backend that gives your Drupal site fast,
AI-enhanced search **without running a separate search server**. It is built on
[Pagefind](https://pagefind.app/): Pagefind builds a static search index at
publish time, and search then runs entirely in the visitor's browser via a
Rust/WebAssembly engine. There is no Solr, no Elasticsearch, and no managed
service to configure or pay for.

On top of that baseline it adds **configurable relevance scoring** (tunable boosts
for title matches, content matches, recency decay, phrase proximity and exact
title matches) and, optionally, **AI-powered query expansion** — when you connect
an LLM provider, Scolta can rewrite queries for better recall, summarise results
and suggest follow-up questions. The AI features are entirely optional; base search
works without any AI provider. Because it plugs in as a standard Search API
backend, it works with Views and other modules that consume Search API indexes,
and it ships Drush commands for building and managing the index (including chunked,
resumable builds with memory budgets for large or shared-hosting sites). It is
maintained by Tag1 Consulting and carries official security-advisory coverage.

**One thing to understand before indexing.** Pagefind builds a **static index that
is served to the browser**, so anything you index is effectively **public** to
anyone who can load the search. Index only public content: respect Search API's
access settings and do not add restricted or unpublished nodes to a Scolta index.

**A note on the install command.** This module's own documentation installs it as
`composer require tag1/scolta-drupal`, whereas our catalog records the package as
`drupal/scolta`. Use the module's documented package name — `tag1/scolta-drupal` —
which also pulls in the `tag1/scolta-php` library (the Pagefind WASM runtime and
frontend assets) automatically. See [Installation](installation/index.md) for the
details.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.
2. [Configuration](configuration/index.md) — creating a Search API server with the
   Scolta backend, building the index, placing the search block, and the optional
   AI provider.

## Where it lives in the admin menu

Scolta is configured through Search API, at **Configuration → Search and metadata →
Search API**, where you create a server that uses the *Scolta Pagefind* backend and
an index that uses it. Its own settings form (for relevance tuning and the optional
AI provider) is reached from there. The search itself appears wherever you place
the **Scolta Search** block via **Structure → Block layout**.
