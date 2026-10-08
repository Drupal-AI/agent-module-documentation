<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extends the Feeds module with a FileMaker Data API fetcher and JSON parser so FileMaker records can be imported into Drupal entities with authentication and batched pagination.

---

The module provides a `filemaker_api_fetcher` Feeds fetcher (extending Feeds' `HttpFetcher`) plus a base JSON parser and item classes. On each run it authenticates against a configured FileMaker auth endpoint using HTTP Basic credentials to obtain a bearer token, then requests records from the feed's source URL with `Authorization: Bearer <token>`. It supports both GET (with `_limit`/`_offset` and custom query parameters) and POST (`_find`-style JSON `query_criteria`) request methods, and pages through results in batches (`batch_size`, up to `max_batches` per run) while persisting the next offset in core `state` (`filemaker_<feedid>_offset`) so long imports resume across runs. Optional throttling (`throttle_enabled`/`throttle_delay`) sleeps between batches. Collected items are written to a temp file as a JSON array and handed to the parser, which decodes and maps each record.

Credentials are never stored in module config: the fetcher reads them from the Key module (`filemaker_auth_endpoint`, `filemaker_username`, `filemaker_password` keys), whose values are typically supplied via `settings.php` config overrides (see README). The FileMaker Data API is served over HTTPS and the module uses Guzzle's default TLS verification (no `verify=>false`), so the token and Basic credentials are protected in transit provided the endpoint is HTTPS. Setup is: enable Feeds + Key, define the three keys, create a Feed type using the FileMaker API fetcher, and map fields with the parser.

---

- Import FileMaker records into Drupal nodes/entities via Feeds.
- Authenticate to the FileMaker Data API and obtain a bearer token.
- Store FileMaker credentials in Key entities, not plain config.
- Supply credentials via settings.php config overrides.
- Fetch records with GET using `_limit`/`_offset`.
- Fetch records with POST using `_find` JSON query criteria.
- Add custom GET query parameters (name=value lines).
- Page through large datasets in configurable batch sizes.
- Cap batches per run with `max_batches`.
- Resume imports across runs via persisted offset state.
- Throttle requests to avoid overwhelming the API.
- Set a delay between throttled batches.
- Reset the offset automatically at end of data.
- Handle FileMaker "Record is missing" (101) as end-of-data.
- Map FileMaker fields to Drupal fields with the parser.
- Skip unwanted items via a parser subclass hook.
- Schedule periodic FileMaker imports on cron.
- Build a Feed type with the FileMaker API fetcher.
- Validate query-criteria JSON before saving.
- Keep FileMaker passwords out of exported configuration.
- Migrate a FileMaker database into Drupal content.
- Import over HTTPS with default TLS verification.