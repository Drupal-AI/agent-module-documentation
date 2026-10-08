<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Senthor — agent orientation

HTTP kernel middleware proxying non-admin GET requests to the Senthor WAF SaaS.

- Version 1.2.x, core ^10. `SenthorMiddleware` decorates the kernel; `SenthorApiClient` POSTs to `https://waf-api.senthor.io/api/verify-request`.
- TLS: default Guzzle client, `verify` NOT disabled — no TLS-downgrade finding. No API key/token in code (auth handled Senthor-side).
- Strips `authorization`/`cookie`/`set-cookie`/`x-csrf-token` before forwarding. Sound.
- Privacy note (not a vuln): forwards request headers + URL + client IP of every eligible front-end request to a third party by design.
