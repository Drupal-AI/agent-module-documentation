<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bing Indexing API pushes your content URLs to Microsoft Bing's Webmaster "SubmitUrlbatch" API so pages are (re)crawled promptly.

---

The `bing_indexing_api.client` service (`BingIndexingApi`) POSTs a JSON `{siteUrl, urlList}` body to `https://www.bing.com/webmaster/api.svc/json/SubmitUrlbatch?apikey=<key>` via Guzzle over HTTPS, logging success/failure. You store the API key and base domain on the Credentials form and choose trigger behaviour on the Settings form: submit on node create/update (optionally published-only), on delete, and/or on unpublish (detected by comparing the original vs new published state in `hook_node_presave`/`hook_node_predelete`). A Bulk Update form lets you submit many URLs at once. All three admin routes are gated by the `administer bing index api` permission.

The API key is stored in module config (as is typical for this API) and only ever sent to Bing over HTTPS with default TLS verification; there are no anonymous or inbound endpoints. Submissions are outbound-only.

---
- Submit a URL to Bing for indexing when a node is created
- Re-submit a URL to Bing when a node is updated
- Submit a URL to Bing when a node is deleted
- Notify Bing when a node is unpublished
- Restrict submissions to published nodes only
- Bulk-submit a batch of URLs to Bing
- Store the Bing Webmaster API key and base domain
- Automate SEO re-crawling on content changes
- Reduce time-to-index for new landing pages
- Log Bing API responses and errors
- Grant a role the `administer bing index api` permission
- Disable auto-submission and use bulk only
- Push a curated list of important URLs after a launch
- Keep Bing's index fresh for a news section
- Trigger reindex from a custom hook via the client service