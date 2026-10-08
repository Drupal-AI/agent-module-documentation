<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Fetcher POST adds a Feeds fetcher plugin (`httpfetcherpost`) that downloads a source with an HTTP **POST** instead of a GET, letting you attach custom request headers and a POST body — either raw content (`BODY`) or `KEY: VALUE` form fields (`FORM_PARAMS`).

---

Core Feeds (`drupal/feeds`) ships an HTTP fetcher that only ever issues a GET, so any source that requires a POST — an API that takes a query in the request body, a SOAP endpoint, a search or reporting service that expects a POST describing what to return, or an endpoint that simply rejects GET — is unreachable without writing a custom fetcher class per integration. This module supplies that general case: it defines a `HttpFetcherPost` plugin that **extends** core's `HttpFetcher` and overrides the request method so the download is performed with `POST`. It reuses core's fetcher-level settings form (`auto_detect_feeds`, `request_timeout`, `always_download`, PuSH options) and adds a **feed-level** form (`HttpFetcherPostFeedForm`, extending core's feed form) with three extra fields stored per feed: **Headers** (a textarea of `KEY: VALUE` lines, parsed by the regex `/(.*?): (.*)/` into Guzzle request headers), **POST parameters** (a textarea), and **POST variant** — a required radio choosing `FORM_PARAMS` (each `KEY: VALUE` line becomes a form field, Guzzle sends `application/x-www-form-urlencoded`) or `BODY` (the textarea is sent verbatim as the raw request body, e.g. a JSON or XML/SOAP payload). At fetch time `get()` builds the Guzzle options (sink, timeout, headers, plus `BODY` or `FORM_PARAMS`), merges any cached ETag/Last-Modified conditional headers, and calls `$this->client->requestAsync('POST', $url, $options)->wait()`. The URL is the feed's own **Feed URL** source field, inherited unchanged from core's HTTP fetcher; the fetched response is handed to whatever Feeds parser and processor the feed type is configured with — this module only changes how the bytes are retrieved. Three things worth planning. First, the headers and POST parameters are entered on the **feed content entity** and stored **plaintext** in the database (the `feeds_feed` entity's fetcher configuration) — there is no Key/token-reference support, so any API key or bearer token you put in a header or body lives unencrypted in the DB, and on a fetch failure the caught `RequestException` is re-thrown as a `FetchException` whose message **includes the full headers and POST body**, which Feeds then surfaces to the importing user and the log. Second, **POST is not idempotent by convention**: a retry on timeout, a re-queued import, or an overlapping cron run may cause the far end to act twice — fine for a read-only report, not for anything that records the request. Third, the response is **untrusted input to the parser** exactly as with a GET source, so you are trusting whoever controls the endpoint. Configuration is entirely admin-side: enable the module, edit a Feed Type (Structure > Feed types) and select the *"Download from URL additional POST parameters"* fetcher, then create/edit a Feed (Content > Feeds) to enter the URL, headers, POST parameters and variant.

---

- Fetch a Feeds source from an endpoint that only accepts POST.
- Import from a JSON API that takes its query in the request body.
- Send a raw JSON payload as the request body (`BODY` variant) and parse the JSON response.
- POST an XML/SOAP envelope to a legacy web service and feed the response.
- Submit `application/x-www-form-urlencoded` fields (`FORM_PARAMS` variant) to a form-style API.
- Add an `Authorization` header to authenticate a Feeds fetch.
- Add a `Content-Type: application/json` header alongside a raw JSON body.
- Import search results from an API that expects a POST search specification.
- Fetch a filtered or paginated dataset by sending filter/page parameters in the POST body.
- Import product or inventory data from a supplier API requiring POST.
- Pull a report from a reporting endpoint that expects a POST describing what to return.
- Import from a partner API whose spec mandates POST rather than GET.
- Add multiple custom headers (API key, tenant id, accept-language) to each Feeds request.
- Reuse core Feeds parsers/processors (RSS, CSV, JSON via extra parsers) over a POST-only source.
- Benefit from core's conditional-request caching (ETag / Last-Modified) on a POST source.
- Set a per-feed request timeout for a slow POST endpoint via the inherited fetcher settings.
- Replace a bespoke custom fetcher plugin that was written only to change GET into POST.
- Drive scheduled/cron imports from a POST API through the standard Feeds import pipeline.
- Fetch from an internal microservice that exposes data only over a POST route.
- Import from a JSON-RPC style endpoint that requires a POST body.
