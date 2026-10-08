<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
szentiras.eu Reference Formatter renders text-field Bible references (e.g. "Jn 3,16") as the actual scripture passage, fetched on demand from the szentiras.eu web API.

---

The `SzentirashuFormatter` field formatter displays references, and a proxy route `/szentirashu/proxy/{ref}/{translation}` (gated by `access content`) lets the front end lazy-load passage text as JSON. Both go through `SzentirasService`, which calls the fixed host `https://szentiras.eu/api/ref/{ref}/{translation}` over Guzzle with an admin-configured `X-API-Key` header and caches results (`cache.default`, permanent per reference; translation list cached 24h). An admin settings form (`szentirashu_formatter.settings`, permission `administer szentirashu api`) stores the API key and lets you pick a default translation.

Security review: the proxy route is effectively public (`access content` is granted to anonymous by default), but `$ref` is only `rawurlencode`d into a hardcoded host URL — there is no SSRF (host is fixed) and no dangerous sink; TLS uses Guzzle defaults (not disabled). The main consideration is that unauthenticated visitors can proxy arbitrary reference lookups to szentiras.eu using the site's API key, which could consume the site's API quota — consider caching/rate limits if abused. Typical setup: enter the API key, then add the formatter to a text field holding references.

---
- Display Bible references as full scripture text on nodes.
- Configure the szentiras.eu API key.
- Choose a default Bible translation.
- Lazy-load passage text via the JSON proxy endpoint.
- Cache fetched passages permanently to cut API calls.
- Show references in a chosen translation abbreviation.
- Format a "verse of the day" field.
- Render multiple references in a field.
- Fall back to a default translation label when the API is unreachable.
- Support Hungarian scripture translations from szentiras.eu.
- Add the formatter to an article body reference field.
- Populate a translation select list from the API.
- Handle API errors gracefully with logged messages.
- Provide clickable/expandable scripture snippets.
- Reuse cached translations list across the site.
- Serve passage JSON to front-end scripts.
