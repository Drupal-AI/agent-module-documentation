<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migration JsonAPI (migration_jsonapi) — agent index

**migrate_plus data parser (`jsonapi`) that builds and paginates Drupal JSON:API request URLs.**

- **Version:** 1.1.x (dev checkout, branch 1.1.x)
- **Core:** >=10.0; PHP 8.1
- **Depends:** migrate, migrate_plus
- **Plugin:** `@DataParser(id="jsonapi")` extending migrate_plus `Json`.
- **Key source config:** `jsonapi_host`, `jsonapi_prefix`, `jsonapi_endpoint`, `jsonapi_query_params`, `jsonapi_langcodes`, `jsonapi_query_param_keys`; requires `urls: []`.
- **Security:** developer/CLI migration tool; no routes, permissions or UI; requests use migrate_plus's HTTP fetcher (standard TLS); URLs logged to the `jsonapi` channel.

See [api/parser.md](api/parser.md).
