# Configuration

All of Opensolr Search's configuration lives on one page with ten tabs at
**Configuration → Search and metadata → Opensolr**
(`/admin/config/search/opensolr`). This page walks through them in the order you
would normally use them. You will need an Opensolr account and API credentials
from [opensolr.com](https://opensolr.com/) before you start.

## Before you begin: handle the credentials as secrets

The module connects to the external Opensolr service using **API credentials**.
Treat them like any other secret — do not paste them into files that get committed
to version control, and prefer to supply them through an environment variable
rather than typing them straight into the database where practical.

The recommended pattern on DDEV is to store the value in an environment variable
and reference it from Drupal:

```bash
ddev dotenv set .ddev/.env --opensolr-api-key=YOUR_KEY_HERE
ddev restart
```

That makes the value available as `OPENSOLR_API_KEY` inside the web container
(keep `.ddev/.env` out of version control). You can then reference it from
`settings.php` with `getenv('OPENSOLR_API_KEY')`, or store it in a **Key** entity
using the environment key provider if you prefer to manage it through the Key
module. Also remember that using the crawler means Opensolr stores a copy of your
content on its servers — confirm that is acceptable for the pages you index.

## Settings tab

This is where you connect Drupal to your Opensolr account. Enter your **Opensolr
API credentials / API key** and the details of the index to use. New in the 4.1.0
release, you can point **multiple Drupal sites at one shared index**: create the
index on the first site, then on the others choose **"Use an existing index"** so
one search can span a whole family of sites without document IDs colliding.

## Data Crawler tab

Configure the **web crawler**, which indexes your site from the outside like a
search engine — no load on Drupal. It automatically indexes HTML plus PDF, DOCX,
and XLSX documents. Because the crawler can only index what it can reach, make sure
non-public content is not crawlable.

## Data Ingestion tab

Configure the **Data Ingestion API**, which pushes content directly from Drupal —
useful behind a firewall and for real-time sync on every save and delete. Bulk
ingestion via cron scales to very large sites. You can run ingestion for instant
updates and keep the crawler as a safety net; both produce identical Solr
documents.

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
candidate pool size, and a content-quality boost.

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
run a search to confirm everything is connected.
