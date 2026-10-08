# Cache Register — manual setup guide

**Cache Register** (`cache_register`) is a developer helper that makes Drupal's cache
API easier to work with from your own code. Instead of writing the usual boilerplate
to get, set, and invalidate cache items and cache tags, you use the module's service
to do the same things with less code.

There is nothing to click and nothing to configure — this is a code-facing
convenience, not a feature with a UI. It wraps core caching and has no role in
content or access control. You install it because another module (yours or a
contrib one) uses it, or because you want to lean on it in code you are writing.

The module is broad in its core support, working across Drupal 8, 9, 10, and 11.

This guide is written for a **human** working through installation. If you want
terse, token-cheap references for an AI coding agent — including how the service is
meant to be called — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — Cache Register adds no admin pages, routes, permissions, or settings form.
It exists purely as a service for other code to call.

## How to use it

Enable the module, then use its cache-helper service from your own module's code to
get, set, and invalidate cache items and tags with less boilerplate than the raw
core API. See the [`agent/`](../agent/start.md) docs for the developer-facing usage.
