# Decoupled Router — manual setup guide

**Decoupled Router** (`decoupled_router`) solves a routing problem that appears in
decoupled ("headless") Drupal sites. When a JavaScript front end (React, Vue,
Next.js, Gatsby, and so on) owns the URLs, it still needs a way to turn a
human-friendly path like `/blog/hello-world` into the actual Drupal entity behind
it, so it can then fetch that entity's data over JSON:API or REST. This module
provides exactly that lookup.

It adds a single JSON endpoint, **`GET /router/translate-path?path=<path>`**. You
call it with any front-end path or path alias and it returns the entity behind
that URL — its type, bundle, id, uuid, and label — along with the resolved and
canonical URLs, any redirect information, and, when JSON:API is enabled, the
JSON:API "individual" resource link the front end needs to load that entity's
fields. Aliases and canonical system paths (like `/node/42`) both resolve to the
same entity, unknown paths return a cacheable 404, and restricted or unpublished
content returns a 403 rather than leaking data.

This is a developer-facing integration module: there is **no admin UI** and it
adds no permissions of its own (the endpoint uses core's *access content*
permission). It depends on core's Path alias module, and it will optionally
follow editorial redirects if the **Redirect** module is installed and enrich its
response with JSON:API links if **JSON:API** is enabled.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the full JSON response
shape and the alter hook — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Decoupled Router has no settings page. Once enabled, the
`/router/translate-path` endpoint is live and your front end can start calling
it.

## How to use it

From your decoupled front end, make a `GET` request such as:

```
GET /router/translate-path?path=/about-us
Accept: application/json
```

The response describes the entity behind that path, including (when JSON:API is
enabled) the `jsonapi.individual` URL you then fetch to get the entity's data.
Point your front-end router at this endpoint whenever it needs to map an incoming
URL to content — for example in a Next.js `getServerSideProps` or a Gatsby
`getStaticPaths` style data-fetching step.

### The one setting

The module has no form, but it does ship a single configuration value,
`absolute_resolved_urls` (default `true`). When true, the `resolved` and redirect
URLs in the response come back absolute (`https://host/path`); set it to false to
get site-relative URLs (`/path`), which is handy when your front end is on the
same domain. The entity's canonical URL is always absolute. Change it with Drush
or in code:

```bash
# relative URLs
drush config:set decoupled_router.settings absolute_resolved_urls 0 -y
# absolute URLs (default)
drush config:set decoupled_router.settings absolute_resolved_urls 1 -y
```

Because this key is a boolean, pass `0`/`1` (or use `--input-format=yaml`) rather
than a bare `false`, which Drush mis-parses as true.
