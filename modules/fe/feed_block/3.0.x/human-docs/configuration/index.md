# Configuration

Feed Block has **no global settings page**. A feed is configured entirely through the
fields of a *Feed Block* custom block. You create as many as you need, each pointing
at its own feed with its own display options.

## Create and place a feed block

1. Go to **Structure → Block layout** and choose **Add custom block → Feed Block**
   (or navigate to `/block/add/feed_block`).
2. Fill in the fields (below) and **Save**.
3. **Place** the block in a region — via the Block UI, Layout Builder, Panels, or
   Context.

Creating and editing these blocks uses core's block-content permissions (for example
*Administer block content*, or the per-bundle *create/edit Feed Block block content*
permissions).

## The RSS Feed field, option by option

The main field is **RSS Feed**, whose widget controls both the source and the
presentation:

- **Feed URL** — the address of the RSS or Atom feed (up to 2048 characters). It must
  be a valid feed.
- **Number of items to display** — how many of the most recent items to show, from 1
  to 100 (default 5).
- **Display date** — whether to show each item's publish date.
- **Date format** — which format that date uses: any of your site's core date
  formats, a **custom** PHP format, or one of the relative options ("time ago",
  "hence", "span").
- **Custom date format** — used only when *Date format* is set to **custom**; a PHP
  `date()` pattern (default `F j, Y`).
- **Display description** — whether to show each item's description/summary text.
- **Description trim length** — a maximum length for the description, 0–1024
  characters (0 means no trimming).
- **Remove HTML markup from description** — when ticked, strips HTML tags from the
  description so only plain text is shown.

Two more fields round out the block:

- **Intro Text** — optional text displayed above the feed items.
- **Read More** — an optional link rendered below the items as a call-to-action
  (styled as a button).

## Which feed formats are supported

The field understands standard **RSS** (`<item>` elements), **Atom** (`<entry>`
elements — this is how a YouTube channel feed is handled, using the entry's link
`href`), and RSS wrapped under `channel`. For each item it renders the date, the
linked title, and the description.

## Caching and refresh interval

Feed output is cached so the remote feed isn't fetched on every page load. By default
each feed block is cached for **86400 seconds (one day)**. There is no UI for this
value, but you can shorten it from the command line — for example, to refresh hourly:

```bash
drush config:set feed_block cache_expiration 3600 -y
```

## Overriding the markup (theming)

The item markup is intentionally simple and easy to override:

- **Per-item template.** Copy `feed-block-rss-item.html.twig` from the module into
  your theme's `templates/` directory, adjust it, and clear caches (`drush cr`). Its
  variables are `date`, `url`, `title`, and `description`.
- **Whole-block template.** The module adds a `block__feed_block` theme suggestion, so
  you can add a `block--feed-block.html.twig` to wrap the entire block.
- **CSS.** Only a minimal `feed_block/feed_block` library is attached; remove or
  replace it in your overridden template if you'd rather style from scratch.
