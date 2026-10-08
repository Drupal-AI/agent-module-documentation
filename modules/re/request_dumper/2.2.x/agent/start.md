<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request Dumper — agent orientation

- HTTP middleware `StackMiddleware\RequestDumper` (priority 0). In `handle()` it reads state
  `request_dumper.enable`; only if an always-on path matches OR a timed `end_time` is still in
  the future does it write `{method}-{time}-content.txt` (request body) and `-headers.txt`
  (`$request->headers->all()` incl. cookies/authorization) to `{file_scheme}://request_dumper{path}`.
- Admin form `DumpEnableForm` (`administer site configuration`) sets duration, methods, path
  prefix, file scheme (public excluded), cleanup, and the always-on token URL (token =
  `Crypt::hashBase64(random_bytes(16))`).
- Route `request_dumper.always_dump` `/request-dumper/always/{token}` — `_custom_access`
  `AlwaysDump::access` uses `hash_equals(expected_token, token)` and requires a configured path.

Security review (sound, well-designed debug tool): dumping is OFF by default; enabling requires
`administer site configuration`; dump files go to a NON-public scheme (public explicitly
`unset`), so headers/cookies/PII are not web-exposed; always-on URL uses a random token with
constant-time comparison. Capturing sensitive headers is inherent to the tool and gated. No
finding.
