<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds FileMaker (feeds_filemaker) — agent index

**Feeds fetcher + JSON parser importing FileMaker Data API records with token auth and batched pagination.**

- **Version:** 2.0.x (2.0.0) · **Package:** Feeds
- **Core:** >=10.3 · **Requires:** feeds, key
- **Fetcher:** `filemaker_api_fetcher` (`FileMakerApiFetcher` extends Feeds `HttpFetcher`). Config: `request_method` (GET/POST), `query_criteria` (JSON), `query_parameters`, `batch_size`, `max_batches`, `throttle_enabled`, `throttle_delay`.
- **Auth:** POST to `filemaker_auth_endpoint` with HTTP Basic (`username:password`), returns bearer token used as `Authorization: Bearer`.
- **Credentials:** read from Key module keys `filemaker_auth_endpoint`, `filemaker_username`, `filemaker_password` (set via settings.php overrides — never in module config).
- **Pagination:** persists next offset in core `state` (`filemaker_<feedid>_offset`); resets on end-of-data / FileMaker error 101.
- **Parser:** `FileMakerJsonParserBase` (abstract) + `FileMakerItem`.

**Security:** No routes/permissions of its own (operates within Feeds admin, which is permission-gated). Credentials sourced from Key, not stored in config. Outbound calls use Guzzle default TLS verification — no `verify=>false`, no disabled SSL; token/Basic creds protected in transit when the configured endpoint is HTTPS. No unverified inbound callback. No security findings.

See [api/fetcher.md](api/fetcher.md)