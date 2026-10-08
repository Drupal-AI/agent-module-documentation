# Configuration

Setting up Google Programmable Search happens in two places: first on Google's
site (to create the search engine and get its ID), then in Drupal's core Search
pages screen (to create a search page that uses it). The module has no settings
form of its own — all its options live on the search page you create.

## Step 1 — register a Programmable Search Engine on Google

1. Go to Google's **Programmable Search Engine** control panel and sign in with a
   Google account.
2. Create a new search engine. Tell it which site(s) to search — usually your own
   domain, but you can list several domains to search across multiple sites from
   one box.
3. Once created, open the engine's setup/overview and copy its **Search engine
   ID** — a short string sometimes written as `cx`, for example
   `012345678:abcde`. You will paste this into Drupal in the next step.

## Step 2 — add a Drupal search page

1. Log in as a user with the **Administer search** permission (an administrator by
   default).
2. Go to **Configuration → Search and metadata → Search pages**
   (`/admin/config/search/pages`) and click **Add search page**.
3. Choose the **Google Programmable Search** plugin.
4. Give the page a **Label** and a **Path** (the suffix under `/search/`, e.g.
   `google` gives you `/search/google`).
5. Paste your **Search engine ID (cx)** into the plugin's configuration.
6. Set the remaining options (below) and **Save**.

## The search page options, field by field

- **Search engine ID (cx)** — the ID you copied from Google. This is required;
  without it no results can be returned.
- **Results display** — where results appear:
  - *Here* (default) — results are rendered on your own site (this relies on
    Google's JavaScript running in the visitor's browser).
  - *Google* — the search box redirects the visitor to Google's own hosted
    results page at `cse.google.com`.
- **Custom results display** — the Google layout style when showing results on
  your site: *overlay*, *full-width*, *two-column*, *compact*, *results-only*
  (the default), or *google-hosted*.
- **Display Drupal search** *(on by default)* — whether to use Drupal's own search
  input, or Google's built-in input element.
- **Results accessibility** *(on by default)* — adds `role="status"` to the
  results summary so assistive technology announces result counts. Applies only
  when results display *Here*.
- **Watermark** *(off by default)* — show the Google watermark, per Google's
  branding guidelines.
- **Query key** *(default `keys`)* — the query-string parameter that carries the
  search terms. Rename it if you need the search URL to match an existing pattern.
- **Search box width** *(default 40)* — the width of the search input, in
  characters.
- **Results prefix / Results suffix** — HTML shown before and after the results
  area, handy for instructions or a promo.
- **Custom CSS** — the URL of an external stylesheet to load, so you can restyle
  the embedded Google results.
- **Data attributes** — a list of key/value pairs passed straight through to
  Google's search element as attributes (for example `data-gl` for country,
  `data-lr` for language, `data-cr` for country restriction,
  `data-as_sitesearch` to scope to a subdirectory, or `data-safeSearch`). This is
  how you scope results by country, language, or section.

## Optional — make it the site's default search

If you want the site-wide search box to use Google, set this page as the default
on the same Search pages screen (or with
`drush cset search.settings default_page <your-page-id>`). When Google
Programmable Search is the default, the module rewrites the core search block: it
renames the input to your *query key*, and — if *Results display* is set to
*Google* — points the form straight at Google's hosted results page, so
submitting jumps to Google.

## Optional — place the search block

For pages that should not use a standalone `/search/...` route, the module
provides a **Google Programmable Search** block (a combined search box plus
results). Place it in any region from **Structure → Block layout**
(`/admin/structure/block`). One caveat from Google: do **not** put this block on
the search page itself, or the results will fail to display.

## A note on testing

Live results require a real Google Programmable Search Engine ID and the
visitor's browser executing Google's script. In a bare local/test environment you
can create and read the configuration, but no live results come back until the
`cx` points at a genuine engine and Google has crawled the site.
