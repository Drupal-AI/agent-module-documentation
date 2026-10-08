<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Sidekick

## Setup
1. Enable `sidekick` (deps: node, dynamic_page_cache, token).
2. At `/admin/config/services/sidekick` (permission `administer sidekick configuration`) enter the `api_key` and options — stored in `sidekick.settings`.
3. Grant `sidekick content generation` to editors who may request suggestions.

## How it works (`SidekickService`)
- Reads the key from `sidekick.settings:api_key`.
- Calls the Sidekick API via Guzzle `http_client` (POST/GET) with header `Authorization: Bearer <api_key>`.
- Suggestions are surfaced in the node form through a custom `ImageWidget` and Twig template; results can be cached via `cache.entity`.

## Notes for operators
- TLS verification is Guzzle default (on) — no disabled-verify flag.
- The API key is plaintext in exportable config; consider restricting config export access.
- Each generation is a paid remote call; scope the `sidekick content generation` permission narrowly.
