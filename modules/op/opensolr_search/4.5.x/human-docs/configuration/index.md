# Configuration

All of Opensolr Search's configuration lives on one page with ten tabs at
**Configuration → Search and metadata → Opensolr**
(`/admin/config/search/opensolr`). This page walks through them in the order you
would normally use them. You will need an Opensolr account and API credentials
from [opensolr.com](https://opensolr.com/) before you start.

## Before you begin: the credentials and your content

The module connects to the external Opensolr service using your **Opensolr account
email and API key**, plus the per-index Solr HTTP-auth details that Opensolr
provides. You enter these on the **Settings** tab; the module saves them in its own
configuration (`opensolr_search.settings`) and uses the API key server-side only —
it is never sent to the browser. All calls to Opensolr go over HTTPS with
certificate verification.

Two things to confirm before you turn indexing on:

- **Restrict who can administer it.** The **Administer Opensolr Search** permission
  (restrict access) controls the credentials, the index, and every management
  action. Grant it only to trusted administrator roles at **People → Permissions**.
- **Your content is copied to Opensolr.** The search index is hosted on Opensolr's
  servers, so indexed content leaves your site. If you use the crawler, make sure
  genuinely non-public pages are not reachable by it. The Data Ingestion path
  (4.5.0 and later) only sends content an anonymous visitor is allowed to view.

## Settings tab

This is where you connect Drupal to your Opensolr account. Enter your **Opensolr
account email and API key** and the details of the index to use. You can point
**multiple Drupal sites at one shared index**: create the index on the first site,
then on the others choose **"Use an existing index"** so one search can span a
whole family of sites without document IDs colliding.

## Data Crawler tab

Configure the **web crawler**, which indexes your site from the outside like a
search engine — no load on Drupal. It automatically indexes HTML plus PDF, DOCX,
XLSX, PPTX, ODT, and ODP documents. Because the crawler can only index what it can
reach, make sure non-public content is not crawlable. Start, stop, pause, and
monitor crawl schedules from here.

## Data Ingestion tab

Configure the **Data Ingestion API**, which pushes content directly from Drupal —
useful behind a firewall and for real-time sync on every save and delete. Bulk
ingestion via cron scales to very large sites. You can run ingestion for instant
updates and keep the crawler as a safety net; both produce identical Solr
documents. The ingest job reports how many items were skipped as not publicly
viewable, so a document count below the entity count is explained.

## Facet Mapping tab

Facets are auto-discovered from your schema, but this tab is where you refine them:
map result **thumbnails** to an image, file, or media field; set up **hierarchical
drill-down facets** (multi-level taxonomies navigated like breadcrumbs,
auto-detected from JSON-LD BreadcrumbList data); and control per-facet minimum
counts.

## Search Display tab

Control how results look and behave: list facets, date ranges (with Today / Last
Week / Last Month presets), numeric sliders with thousands separators, result
thumbnails, autocomplete, "Did you mean?" spellcheck, a dark theme, and your
choice of infinite scroll or classic numbered pagination.

## Embeddable tab

Optionally switch to Opensolr's **hosted search UI** — an embeddable widget —
instead of rendering results through the module's own Twig templates.

## Search Tuning tab

Fine-tune relevance: field weights, the balance between semantic (vector) and
lexical (keyword) matching, the available **search modes** (Union, Keywords
Required, Meaning Required, Intersection), minimum-match presets, the vector
candidate pool size, a content-quality boost, and the **Fresh Results Bias
strength**. Whether Fresh is on stays the visitor's per-search choice on the
results page; this slider sets how hard it pushes when they turn it on.

## Analytics tab

View the privacy-first analytics dashboard — queries, clicks, click-through rate,
no-results searches, and top URLs, with hashed IPs.

## Elevation tab

Pin or exclude specific results for specific queries using visual PIN and EXCLUDE
buttons shown directly on the search results.

## Filters tab

Define **persistent filters** — admin-configured Solr `fq` (filter query) rules
that are applied to every search automatically.

## Save

Each tab has its own save action. After entering your credentials on the Settings
tab and choosing how you index (crawler and/or ingestion), index some content and
run a search at `/opensolr-search` to confirm everything is connected.
