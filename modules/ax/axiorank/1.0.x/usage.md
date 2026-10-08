<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AxioRank Agent Verification is a thin client of the AxioRank inbound verify service that checks which AI agents reach your REST, JSON:API, admin, and dynamic endpoints, then optionally blocks them.

A REQUEST event subscriber (`VerifyRequestSubscriber`, priority 28 — after auth, below the router) gates each main request through `Gate::shouldVerify()`, builds a header-stripped envelope (`EnvelopeBuilder`), and posts it to the AxioRank verify endpoint (`AxiorankClient`) with a 1-second timeout. Under monitor posture the verdict is only recorded; under enforce it returns a 403/401 solely when the server's own `enforced` flag is set. The client is fail-open by design: any timeout, network error, non-2xx, or malformed response yields a synthetic allow verdict, and a 401 (bad site key) is flagged to the administrator but still fails open. Cookie/authorization headers are never forwarded. Configuration (site key, posture, scopes) is at `/admin/config/services/axiorank` behind `administer axiorank`; a CSRF-protected test-connection route validates the key.

Use it to observe or enforce AI-agent access policy across your site's machine-facing endpoints without risking taking the site down when the verify service is unreachable.
---
Verifies inbound AI-agent requests via the AxioRank endpoint with monitor/enforce modes; fails open on any error.
---
- Monitor which AI agents hit your REST/JSON:API endpoints
- Enforce blocking of unverified agents on armed endpoints
- Run in monitor mode to observe before enforcing
- Scope verification to selected route types
- Configure the AxioRank site key and base URL
- Test the AxioRank connection from the admin UI (CSRF-protected)
- Fail open automatically when the verify service times out
- Keep serving traffic when the site key is rejected (401)
- Strip cookies/authorization from forwarded envelopes
- Return 403 for a block verdict, 401 for a challenge verdict
- Record local activity counters for the settings page
- Apply a short (1s) verify timeout to avoid latency
- Gate HTML, JSON:API, and core REST from one subscriber
- Surface a bad-site-key warning to administrators
- Restrict configuration behind "administer axiorank"
- Disable redirects on the verify call for safety
- Roll out agent policy without CLI/cron impact
