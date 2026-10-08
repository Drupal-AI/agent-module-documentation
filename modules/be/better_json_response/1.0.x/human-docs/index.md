# Better Json Response — manual setup guide

**Better Json Response** (`better_json_response`) is a small developer utility that
improves Drupal's built‑in JSON response. It extends the standard `JsonResponse`
class with JSON:API‑compatible structure and cache metadata, so custom JSON
endpoints can be both JSON:API‑shaped and properly cacheable — without you having
to build full JSON:API resources.

It is aimed at people building decoupled or API‑style endpoints who want their
hand‑rolled JSON responses to behave like first‑class Drupal responses: carrying
cache tags and contexts so they can be cached and invalidated correctly, and
following JSON:API conventions for consistency.

This is a code‑level tool, not a site‑builder feature. It has no content or access
role of its own and nothing to click — a developer uses the response class from
custom code. It depends on core's **JSON:API** module and supports Drupal 10, 11,
and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no configuration screen. Once the module is enabled, a developer uses its
improved response class in custom controller or route code in place of the plain
`JsonResponse`, and returns it as normal. The returned response then carries the
JSON:API structure and cache metadata the module adds. Refer to the module's own
code and README for the exact class name and usage.
