# Configuration

## Open the settings

Go to **Configuration → Search and metadata → Simple Sitemap XML Settings**. The
form is organised around the choices below; when you save, the sitemap is
regenerated and served at `/sitemap.xml`.

## Choose a generation mode

- **Content Types** *(default, new in 1.1.0)* — build the sitemap from the content
  types you select, with full control over node status and priorities. This is the
  recommended mode for most sites.
- **Menu-based (Legacy)** — build the sitemap from a Drupal menu instead, using the
  menu's hierarchy. Kept for backward compatibility with existing setups.

## Content-type mode options

- **Content types** — tick which content types should be included in the sitemap.
- **Node status filtering** — choose whether to include published nodes,
  unpublished nodes, or both. In practice you'll usually want published only, so
  you don't advertise drafts to search engines.

## Priority assignment

Priority tells crawlers how important a URL is relative to others. Pick the strategy
that fits your site:

- **Default** — the same priority for every URL.
- **Content Type** — priorities assigned per content type.
- **Menu Level** — automatic priority based on how deep the item sits in the menu
  hierarchy.
- **Custom** — specific priorities for individual URLs.
- **Mixed** — combines content-type, custom, and menu-level priorities
  intelligently.

## Exclude URLs

You can exclude specific URLs from the sitemap, and wildcard patterns are supported
so you can remove a whole group of paths at once. Use this to keep utility pages,
admin paths, or anything not meant for search engines out of the sitemap.

## Timestamps and caching

The sitemap uses each node's actual *changed* date for its `lastmod` value, giving
crawlers accurate freshness information. Output is cached for one hour with
automatic invalidation and mode-specific cache keys, so serving the sitemap stays
fast without going stale.

## Save

Save the form. Your sitemap is generated immediately and available at
`/sitemap.xml` — you can open it in a browser to review it, where the XSL styling
makes it human-readable.

## A word on what you include

A sitemap advertises URLs to crawlers; it does not grant access. Listing a URL just
invites crawling, so use the **node status filtering** and **URL exclusions** to
make sure only genuinely public content appears — keep unpublished, private, or
admin URLs out.
