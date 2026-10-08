# Search API Recombee — manual setup guide

**Search API Recombee** (`search_api_recombee`) is a Search API *backend* that
indexes your content into [Recombee](https://www.recombee.com), a hosted
(SaaS) personalization and recommendation engine. Rather than powering ordinary
keyword search, its job is to feed content into Recombee so the recommendations
Recombee generates are as good as possible. It's built for performance and is
suitable even for large commercial sites, and because it can index more than one
site into the same Recombee account, it supports federated recommendations across
several Drupal sites.

An important expectation-setter: this backend **does not support facets or
searching**. It is purely for *indexing* content into Recombee. To actually track
users and display the recommendations that come back, you pair it with the
companion **Recombee** module, which handles user tracking and rendering
recommendation results from the Recombee API. The maintainers strongly advise
configuring that companion module so the index this backend populates is the one
driving the results shown to visitors.

The module depends on the **Search API** and **Recombee** modules, provides its own
permission, and works on Drupal 10.2+ and 11. It was developed by Morpht in close
collaboration with the Recombee team.

**Privacy and security matter here, and significantly so.** Your indexed content is
sent to and stored in Recombee, a third-party service, and the personalization
relies on **user-behavior data** being sent to Recombee as well. That has real
consequences: store the Recombee API credentials as secrets (never in exported
config or code), obtain appropriate user consent and disclose the data sharing in
your privacy notices — behavioral tracking to a third party carries GDPR/ePrivacy
obligations — and consider data-residency requirements for where that data is
stored.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the companion Recombee module.
2. [Configuration](configuration/index.md) — connect your Recombee database, index
   your content, and pair it with the Recombee module.

## How to use it

Search API Recombee appears as a backend option when you add a Search API server.
Point it at your Recombee database with the proper credentials, index the content
you want Recombee to learn from, and configure the companion Recombee module to
track users and display the resulting recommendations. See
[Configuration](configuration/index.md) for the walkthrough.
