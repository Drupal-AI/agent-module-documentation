# Configuration

Before you begin, make sure the **Simple XML Sitemap** module is installed and
configured — this module simply adds custom links into the sitemap it generates.

## Open the custom-links form

1. Grant the **Administer custom sitemap links** permission to the relevant role
   (see [Installation](../installation/index.md)).
2. Go to **Configuration → Search and metadata → Simple XML Sitemap → Custom
   Arbitrary Links**, or navigate directly to
   `/admin/config/search/simplesitemap/custom-arbitrary-links`.

You'll see a table listing any custom links you've already added (empty on a fresh
install).

## Add a link

Click **Add new link** to insert a blank row — thanks to AJAX, the row appears
without a page reload. For each row, fill in these fields:

- **URL** — the address to include in the sitemap. You can type it in several
  shapes — `link`, `/link`, or `example.com/link` — and the module normalizes it
  automatically to a consistent form.
- **Priority** — how important this URL is relative to others on your site, the
  standard sitemap priority value.
- **Change frequency** — how often the page is expected to change (for example
  daily or weekly), a hint for crawlers.
- **Last modified** — the last-modified date to advertise for this URL.
- **Language** — the language to associate with the link, useful on multilingual
  sites.

## Save and regenerate

Click **Save** to store your links in the module's database table. If you tick
**Regenerate all sitemaps**, the module rebuilds `sitemap.xml` immediately (through
the Simple XML Sitemap generator) so your new links appear straight away. If you
leave it unticked, the links are still saved and will show up the next time your
sitemaps are regenerated.

## Remove a link

Each row has a **Remove** button that deletes that link from the database. As with
adding, this happens inline without reloading the page.

## Where the links end up

Your custom links are merged into the Simple XML Sitemap output right alongside the
normal entity URLs — crawlers see a single sitemap containing both. This is a
convenient way to make sure marketing landing pages, non-entity routes, or
multilingual entries are discoverable even though they aren't backed by a Drupal
entity.
