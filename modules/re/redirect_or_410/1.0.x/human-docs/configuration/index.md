# Configuration

Redirect or 410 has no standalone configuration page — it folds its options into
the Redirect module's existing screens. There are two things to know: how to mark
a URL as 410 Gone, and how the **fast 410** behavior works.

## Marking a URL as 410 Gone

1. Log in as a user who can **administer redirects**.
2. Go to **Configuration → Search and metadata → URL redirects → Add redirect**
   (`/admin/config/search/redirect/add`), or edit an existing redirect.
3. In the **status code** selector you'll now see **410 Gone** alongside the
   usual redirect codes. Choose it when the old URL should simply be gone rather
   than pointing anywhere.
4. Save. Requests to that path will now receive an HTTP 410 Gone response,
   matched through Redirect's normal path‑matching behavior.

Use a redirect (301/302) when there is a relevant replacement URL; use **410
Gone** when the content was deleted with no useful replacement and you want it
removed from search indexes.

## From the Redirect 404 report

If the **Redirect 404** submodule is enabled, its report of missing URLs gains an
extra action: mark a URL as **410 Gone** so it stays permanently unavailable.
This is convenient during migrations, redesigns, and SEO clean‑ups where many
old URLs each need a clear decision — redirect, leave as 404, or mark gone.

## Fast 410 responses

The module offers a **fast_410** option that controls what a visitor actually
receives for a gone URL:

- **Fast 410 enabled** — the module returns a lightweight 410 response with a
  short, configurable message and skips rendering a full Drupal page. This is the
  efficient choice for bots, crawlers, and old URLs that are still requested
  often, because it avoids the cost of building a themed page.
- **Fast 410 disabled** — the module renders your site's configured not‑found
  page but sends it with HTTP status **410 Gone**. Visitors get the familiar
  themed error page while clients and search engines still receive the correct
  status code.

Pick fast 410 when performance and crawler signalling matter most; leave it off
when you'd rather every visitor see your normal branded error page.
