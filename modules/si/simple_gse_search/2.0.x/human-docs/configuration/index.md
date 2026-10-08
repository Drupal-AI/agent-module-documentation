# Configuration

Getting Simple GSE Search working is a short, three‑part job: create the search
engine on Google, tell Drupal its ID, and place the search block. This page walks
through the Drupal side.

## Before you start: create a Programmable Search Engine

On Google's Programmable Search Engine (Custom Search) site, create a search engine
for your domain. When it is created, Google gives you a **search engine ID** — the
"CX" code. Copy it; you will paste it into Drupal.

## Open the settings form

1. Log in as a user with the **administer gse search** permission (an administrator
   by default).
2. Go to **Configuration → Search and metadata → Simple GSE Search**, or navigate
   directly to `/admin/config/search/simple_gse_search`.

## Enter your search engine ID

The settings form's key field is the **Client ID / search engine ID (CX code)** you
copied from Google. Paste it in and save. This is the one piece of configuration the
module genuinely needs — the module uses Google's JavaScript approach, so once the
ID is set, Google's widget knows which engine to query.

## Place the search block

The search input is provided as a block. Go to **Structure → Block layout**, place
the Simple GSE Search block in a region where you want the search box to appear
(often a header or sidebar), and save. Visitors then type a query and are taken to
the results page.

## Control who can see results

The results page at **`/search`** is gated by its own **access gse search page**
permission, separate from the admin permission. Grant it to the roles that should be
able to run searches. On a public site you would typically grant it to Anonymous and
Authenticated users; if you want to restrict search to logged‑in users, grant it to
Authenticated only.

## Things to keep in mind

- Results only ever include pages **Google has indexed** — so freshly published
  content may not appear until Google re‑crawls, and content behind a login never
  appears. This is not a tool for searching private or members‑only material.
- The free tier displays **Google branding** and has query limits; the paid tier is
  billed per thousand queries.
- **Search terms are sent to Google.** Note this where queries could be sensitive.
- Remember the **`/search` path collision** with core Search — if both are enabled,
  disable core Search (the module's documentation recommends uninstalling it).
