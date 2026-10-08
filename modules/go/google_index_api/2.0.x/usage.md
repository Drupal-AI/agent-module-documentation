<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Index API notifies Google's Indexing API when a page is published, updated or removed, so that URL is recrawled promptly instead of waiting for the next sitemap fetch.

---

Sitemaps are a hint Google acts on at its own pace — fine for a blog, inadequate when content is time-sensitive such as a job posting that closes in three days or a livestream about to start. The Indexing API exists for exactly that: it accepts `URL_UPDATED` and `URL_DELETED` notifications and prioritises those URLs. This module wires it in. The service `google_index_api.client` (`Drupal\google_index_api\Service\GoogleIndexApi`) exposes two methods, `updateUrl($url)` and `deleteUrl($url)`, which POST to `https://indexing.googleapis.com/v3/urlNotifications:publish` through the `google/apiclient ^2.0` library; the module itself implements no entity hooks, so you call the service from your own `hook_ENTITY_TYPE_update`/`_delete`. A settings form at `/admin/config/services/google-index-api` captures the base domain and the Google service-account JSON credential (stored in Drupal State, hence set per environment), and a bulk-update form at `.../bulk-update` runs a Batch job over a pasted or uploaded list of URLs. Everything is gated by the `administer google index api` permission and core requirement is `^10.2 || ^11`. Two constraints to establish before recommending it: Google documents the Indexing API for job-posting and livestream content specifically, not general pages, and the quota is roughly 200 calls per project per day — so submit selectively.

---

- Notify Google when a job posting is published.
- Request prompt recrawl of a livestream page.
- Tell Google a page has been removed.
- Bulk-submit URLs to the Indexing API after a migration.
- Speed up indexing of time-sensitive content.
- Announce a node on publish through your own update hook.
- Remove expired job postings from the index on delete.
- Complement an existing XML sitemap.
- Reduce the delay between publishing and appearing in results.
- Submit a backlog of URLs from a pasted list.
- Submit a backlog of URLs from an uploaded text file.
- Restrict indexing configuration to administrators.
- Authenticate to Google with a service-account credential.
- Set a distinct backend base domain for submitted URLs.
- Track submitted URLs in the site log.
- Notify on unpublish as well as publish.
- Integrate indexing into an editorial workflow.
- Improve visibility of short-lived content.
- Run a one-off recrawl request programmatically.
- Batch-process a large URL list without timing out.
