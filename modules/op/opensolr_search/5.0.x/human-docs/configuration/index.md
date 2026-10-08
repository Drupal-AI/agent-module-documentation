# Configuration

All of Opensolr Search's configuration lives on one page with ten tabs at
**Configuration → Search and metadata → Opensolr**
(`/admin/config/search/opensolr`). This page walks through them in the order you
would normally use them. You will need an Opensolr account and API credentials
from [opensolr.com](https://opensolr.com/) before you start.

## Before you begin: handle the credentials as secrets

The module connects to the external Opensolr service using your **account email
and API key**, and once an index is selected it also stores the per-index **Solr
HTTP-auth username and password** that Opensolr returns. All of these are held in
the module's configuration object (`opensolr_search.settings`). Treat them like any
other secret:

- **Restrict the `administer opensolr search` permission** to trusted roles — it
  exposes credential fields and destructive index actions (reset/delete the hosted
  index).
- **Keep the values out of exported, committed configuration.** If you export
  configuration to a Git repository, the API key and Solr password would be
  committed with it. The module reads the API key from Drupal configuration, so you
  can keep the real value out of the exported files by overriding it from
  `settings.php` with a standard Drupal config override, for example:

  ```php
  // settings.php — keep the real key in an environment variable, not in config export.
  $config['opensolr_search.settings']['api_key'] = getenv('OPENSOLR_API_KEY');
  ```

  On DDEV you can set that environment variable with
  `ddev dotenv set .ddev/.env --opensolr-api-key=YOUR_KEY` then `ddev restart`
  (keep `.ddev/.env` out of version control).

The Settings form never re-displays a saved API key — the field is a password
field that stays blank, and you re-enter the key only when you want to change it.

Also remember that using the crawler means Opensolr stores a copy of your content
on its servers, and everything indexed is served to anonymous searchers — confirm
that is acceptable for the pages you index, and make sure non-public content is not
crawlable. (The Data Ingestion path additionally skips any content an anonymous
visitor is not allowed to view.)

## Settings tab

This is where you connect Drupal to your Opensolr account. Enter your **Opensolr
account email and API key**, pick a **server region**, and either create a new
index or attach to an existing one. You can point **multiple Drupal sites at one
shared index**: create the index on the first site, then on the others choose
**"Use an existing index"** so one search can span a whole family of sites without
document IDs colliding. Credentials are validated against the Opensolr API before
they are saved. The connection is made over HTTPS to the fixed Opensolr hosts.

## Data Crawler tab

Configure the **web crawler**, which indexes your site from the outside like a
search engine — no load on Drupal. It automatically indexes HTML plus PDF, DOCX,
XLSX, PPTX, and ODT documents (tick **include attached files** to add them).
Because the crawler can only index what it can reach, make sure non-public content
is not crawlable. From here you can start, stop, pause, force a re-crawl, and watch
crawl statistics.

## Data Ingestion tab

Configure the **Data Ingestion API**, which pushes content directly from Drupal —
useful behind a firewall and for real-time sync on every save and delete. Bulk
ingestion ("Ingest All Now") runs as a background job processed by cron in batches.
You can run ingestion for instant updates and keep the crawler as a safety net;
both produce identical Solr documents. Ingestion only sends content an anonymous
visitor may view.

## Facet Mapping tab

Facets are auto-discovered from your schema, but this tab is where you refine them:
map result **thumbnails** to an image, file, or media field; set up **hierarchical
drill-down facets** (multi-level taxonomies navigated like breadcrumbs,
auto-detected from JSON-LD BreadcrumbList data); and control per-facet minimum
counts.

## Search Display tab

Control how results look and behave: list facets, date ranges (with Today / Last
Week / Last Month presets), numeric and **duration** sliders with thousands
separators, result thumbnails, autocomplete, "Did you mean?" spellcheck, a dark
theme, and your choice of infinite scroll or classic numbered pagination.

## Embeddable tab

Optionally switch to Opensolr's **hosted search UI** — an embeddable widget —
instead of rendering results through the module's own Twig templates.

## Search Tuning tab

Fine-tune relevance: field weights, the balance between semantic (vector) and
lexical (keyword) matching, the available **search modes** (Union, Keywords
Required, Meaning Required, Intersection), minimum-match presets, the vector
candidate pool size, the content-quality boost, and the **Fresh Results Bias**
strength (how hard the results-page Fresh toggle pushes newer documents up).

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
