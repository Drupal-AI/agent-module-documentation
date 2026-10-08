<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request Dumper — agent orientation

Drupal 11-only debug tool (`core_version_requirement: ^11`). No config schema, no permissions of
its own, no drush commands, no plugin types. All state lives in the `request_dumper.enable` State
key/value (removed on uninstall).

- HTTP middleware `StackMiddleware\RequestDumper` (service `http_middleware.request_dumper`,
  priority 0, args `@state`, `@file_system`). In `handle()` it reads State
  `request_dumper.enable`; only if the always-on path matches (`path === always_path`) OR a timed
  `end_time` is still `>= REQUEST_TIME` does it write two files to
  `{file_scheme}://request_dumper{path}`: `{METHOD}-{REQUEST_TIME_FLOAT}-content.txt` (raw
  `$request->getContent()`) and `{METHOD}-...-headers.txt` (`var_export` of
  `$request->headers->all()` — includes cookies/authorization — plus `RequestUri` and
  `DecodedRequestUri`). Timed dumps also require the method to be in `dump_methods` and the path
  to start with `path_prefix` (if set); always-on captures unconditionally. Exceptions are
  swallowed silently. `file_scheme` defaults to `temporary`.
- Admin form `DumpEnableForm` (route `request_dumper.enable_form`,
  `/admin/config/development/request-dumper`, permission `administer site configuration`) sets
  duration (0/60/90/120/300/600/900/1800s), methods (POST/PATCH/GET/PUT/DELETE), path prefix,
  file scheme (`getDescriptions(HIDDEN)` with `public` unset), a cleanup checkbox
  (`deleteRecursive`), and the always-on token URL. Enabling always-on mints the token once as
  `Crypt::hashBase64(random_bytes(16))` and stores it as `always_path`.
- Route `request_dumper.always_dump` `/request-dumper/always/{token}` →
  `AlwaysDump::resultPage` returns `{"result":"success"}` (200, application/json). Access via
  `_custom_access` `AlwaysDump::access`: requires a non-empty stored `always_path` and
  `hash_equals(expected_token, token)` (constant-time).

Security review (sound, well-designed debug tool): dumping is OFF by default; enabling requires
`administer site configuration`; dump files go to a NON-public scheme (`public` explicitly
`unset` from the options), so headers/cookies/PII are not web-exposed; the always-on URL uses a
random token with constant-time comparison. Capturing sensitive headers is inherent to the tool
and gated. No finding.
