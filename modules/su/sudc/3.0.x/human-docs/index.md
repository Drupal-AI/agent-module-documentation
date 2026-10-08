# SearchUnify Drupal Connector — manual setup guide

**SearchUnify Drupal Connector** (`sudc`) connects your Drupal site to
**SearchUnify**, a hosted enterprise search platform. Once configured, it renders a
SearchUnify-powered results page on your site, proxies search queries to the
SearchUnify backend, and issues a per-user token for authenticating to SearchUnify.

SearchUnify is a SaaS "unified cognitive" search platform: it indexes content from
across your systems and returns AI-ranked, contextual results, with autocomplete,
analytics, and generative (GPT-style) answers. This connector is the Drupal-side
glue. You store your SearchUnify account details in Drupal, and the module exposes
a dynamic front-end route (`/searchunify/{path}`) that renders SearchUnify's results
template for the matching search configuration, plus a small set of REST endpoints
that forward search and GPT requests to SearchUnify using your site's stored access
token, and one endpoint that returns a signed JWT for the current user.

The module needs configuration before it does anything — you enter your CDN,
provision key, endpoint, JWT expiry, and one or more UID / Search-URL pairs, and the
provision key and UIDs are validated against SearchUnify when you save. It has **no
Drupal module dependencies**, requires **PHP 8.1**, and pulls in the
`firebase/php-jwt` library via Composer for signing tokens. Outbound calls to
SearchUnify go through a service that verifies TLS by default.

**Please read this before exposing it publicly.** The front-end results page and the
`/search-unify/v1/*` REST endpoints are gated only by the *access content*
permission, which anonymous visitors have by default. Two consequences follow from
how the code works, so weigh them for your site:

- The results page and the JWT endpoint place the site's SearchUnify **access token
  into data sent to the client** (the JWT payload carries the access token in a
  form that can be base64-decoded), so an anonymous visitor could read that token.
- The search and GPT endpoints act as an **unauthenticated proxy** to SearchUnify
  using your stored server credentials, meaning anonymous users can drive requests
  through them.

If your site is public and that is not what you intend, restrict the *access
content* permission or lock down these routes. (On the positive side, TLS
verification is on by default in the outbound calls, and there is a dev-only toggle
you should leave enabled in production.)

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the terser sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (PHP 8.1) and
   enable the module.
2. [Configuration](configuration/index.md) — enter your SearchUnify credentials and
   map UIDs to URL paths.

## Where it lives in the admin menu

Settings are at `/admin/config/sudc` (behind *Administer site configuration*), with
an in-module help page at `/admin/config/sudc/help`. The front-end search page
appears at `/searchunify/<your-search-url>` once you have configured a matching UID.
