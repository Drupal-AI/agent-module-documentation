<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Senthor

Adds an HTTP kernel middleware that sends details of incoming non-admin GET requests to the Senthor WAF API, which decides whether to allow, block (403), or charge (402) the request — aimed at detecting and monetizing AI crawlers.

- Decorates the HTTP kernel with `SenthorMiddleware`.
- Calls the external Senthor API per eligible request.
- Can short-circuit with a 402 or 403 response.
- Passes through crawler/monetization response headers.

---

# Installing & configuring

- Enable the module (`drush en senthor_io`).
- The middleware activates automatically for non-admin GET requests.
- Configure your Senthor account/credentials on the Senthor side.
- The API endpoint is `https://waf-api.senthor.io/api/verify-request` (HTTPS).
- No admin form ships in this module version.

---

# Usage & behaviour

- Only `MAIN_REQUEST` GET requests to non-`/admin` paths are inspected.
- Sensitive headers (`authorization`, `cookie`, `set-cookie`, `x-csrf-token`) are stripped before sending.
- The request URI and client IP are forwarded to Senthor.
- A 403 from Senthor is returned directly to the visitor.
- A 402 (payment required) from Senthor is returned directly.
- A 200 may carry a `payment-response` header copied onto the response.
- Restricted hop-by-hop headers are filtered from Senthor's reply.
- The outbound call uses the default Guzzle client (TLS verification not disabled).
- `http_errors` is FALSE so non-2xx responses are handled, not thrown.
- A 10-second timeout is applied; exceptions yield status 500 and pass-through.
- Every eligible front-end request incurs an external API round-trip (latency/privacy consideration).
- Admin paths are exempt to avoid locking out the backend.
- No local database or config schema is added.
- The module is a thin proxy to the Senthor SaaS.
- Uninstalling removes the middleware decorator.
- Request metadata (headers minus sensitive ones, URL, IP) leaves the site to a third party by design.
