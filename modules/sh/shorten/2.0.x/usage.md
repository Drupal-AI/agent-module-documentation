Shorten URLs shortens long URLs through external shortening services (is.gd, TinyURL, Bit.ly and ~25 others). It offers a shortening page, two blocks, a token, and a `shorten_url()` API, with a configurable primary + backup service and result caching.

---

The module's core is the procedural `shorten_url($original, $service)` function (in `shorten.module`): it looks up the chosen service from `hook_shorten_service()` implementations, builds the request URL, and fetches the shortened URL via `shorten_fetch()` — using either Guzzle (`shorten_method = php`) or cURL — timing out after `shorten_timeout` seconds (default 3). If the primary service fails it falls back to the configured backup service, and finally to the original URL. Responses are validated to start with `http(s)://`. Two admin forms configure it: `/admin/config/services/shorten` (general settings — method, primary/backup service, timeout, cache durations, per-service visibility; permission `administer site configuration`) and `/admin/config/services/shorten/keys` (API keys for Bit.ly/BudURL/Goo.gl/etc.; permission `manage Shorten URLs API keys`). A user-facing page at `/shorten` (permission `use Shorten URLs page`) lets a user paste a URL and get a short one via AJAX, optionally choosing the service; two blocks (`shorten`, `shorten_short`) expose the same form and a "short URL for the current page". It also provides `hook_token_info`/`hook_tokens` so `[url:shorten]` (and legacy `[node:short-url]`) resolve to a shortened URL, and fires `hook_shorten_create()` after each shortening. Three optional submodules ship in the project: `record_shorten` (log shortened URLs + a report/Views data), `shorten_cs` (add custom services through the UI), and `shortener` (an input filter). Note: shortening is delegated to third-party services — the module fetches `https://<service>/…?url=<your-url>`, it does not create local short codes or redirects itself.

---

- Shorten a long URL from the `/shorten` page and copy the result.
- Add a "Shorten URLs" block so visitors can shorten arbitrary URLs.
- Show a short URL for the current page via the "Short URL" block.
- Shorten a URL programmatically in custom code with `shorten_url($long)`.
- Render a shortened URL in text/templates with the `[url:shorten]` token.
- Choose a default shortening service (is.gd, TinyURL, Bit.ly, migre.me, qr.cx, …).
- Configure a backup service used automatically when the primary is down.
- Add Bit.ly / BudURL / Goo.gl / Fwd4.me / Ez API keys on the Keys form.
- Let users pick which service to use per shortening (optional service selector).
- Hide specific services from the block/page selector (disallowed services list).
- Cache shortened URLs for a set duration to avoid repeat API calls (default 3 weeks).
- Cache failed lookups briefly (default 30 min) so a down service doesn't hammer the API.
- Use cURL or PHP HTTP as the fetch method, whichever is available/faster.
- Set a request timeout so slow services don't block page rendering.
- Register your own shortening service via `hook_shorten_service()`.
- React to each shortening event via `hook_shorten_create()`.
- Log every shortened URL and view a report with the `record_shorten` submodule.
- Add on-domain services (ShURLy) so short URLs live on your own domain.
- Add bespoke shortening services through the UI with the `shorten_cs` submodule.
- Shorten links automatically in text via the `shortener` input filter submodule.
- Prefer the aliased (path-alias) form of a URL when shortening.
- Swap "http://" for "www." in output where a service returns it (shorter display).
