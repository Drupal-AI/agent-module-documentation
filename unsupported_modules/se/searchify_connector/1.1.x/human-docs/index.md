# Searchify Connector — manual setup guide

**Searchify Connector** (`searchify_connector`) connects your Drupal site to the
**Searchify** hosted search/AI service so you can offer Searchify-powered search
to your visitors. It adds a public search page and a streaming endpoint that
forward a visitor's query to Searchify's API and stream the results back onto the
page.

The problem it solves is integration plumbing: rather than building your own
client for the Searchify SaaS, the module gives you a ready-made search page at
`/searchify` and a server-sent-events (SSE) stream at `/searchify/stream`. Your
Searchify API credentials are configured through the admin interface and kept
**server-side** — the key is never exposed to the visitor's browser. It depends
only on core's **System** module and supports Drupal 10 and 11.

A note on the package name: you install this with the Composer package
**`drupal/searchifyai`**, even though the module's machine name is
`searchify_connector`. That difference is expected — use `drupal/searchifyai`
for the `composer require` command and `searchify_connector` for `drush en`.

The module needs configuration before it does anything useful — you must supply
your Searchify API credentials. One thing to keep in mind: the `/searchify` page
and `/searchify/stream` endpoint are **public by design**, because they are a
site-search feature. Since every query hits the paid Searchify API, consider
adding rate-limiting so that anonymous traffic cannot run up your API bill.

This guide is written for a **human** setting things up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Searchify API credentials
   and understand the public endpoints.

## How to use it

Once your credentials are configured, visitors reach the search feature at
`/searchify`. They enter a query, and results stream in from Searchify via the
`/searchify/stream` SSE endpoint. Because the API key lives on the server, the
browser only ever sees results, never the credential.
