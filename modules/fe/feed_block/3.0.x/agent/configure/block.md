# Configure a Feed Block

There is **no admin settings page** (`configure` is null). A feed is configured entirely through
the fields of a `feed_block` custom block content entity.

## Create & place
1. Structure → Block layout → **Add custom block** → **Feed Block**
   (`/block/add/feed_block`), or via the "Add feed block" button in the Block UI.
2. Fill the fields (below). Save.
3. Place the block in a region (Block UI, Layout Builder, Panels, Context, …).

Creating/editing these blocks uses core Block Content permissions (e.g. `administer block content`
or the per-bundle `create/edit … feed_block block content`) — Feed Block declares none of its own.

## Fields on the `feed_block` bundle
- **RSS Feed** (`field_rss_feed`, type `rss_feed_field`, widget `rss_feed_widget`) — the feed and
  its display options:
  | Widget setting | Stored property | Notes |
  |---|---|---|
  | Feed URL | `feed_uri` | textfield, maxlength 2048. "This must be a valid RSS feed." |
  | Number of items to display | `count` | select 1–100 (default 5) |
  | Display date | `display_date` | checkbox |
  | Date format | `date_format` | core date-format machine name, `custom`, or a "time ago/hence/span" option |
  | Custom date format | `custom_date_format` | PHP `date()` format when `date_format = custom` (default `F j, Y`) |
  | Display description | `display_description` | checkbox |
  | Description trim length | `description_length` | number 0–1024 (0 = no trim) |
  | Remove HTML markup from description | `description_plaintext` | checkbox → `strip_tags` |
- **Intro Text** (`field_intro_text`, text_long) — optional text shown above the items.
- **Read More** (`field_read_more`, link) — optional CTA link rendered with a `button` class
  (`FeedBlockHooks::preprocessField`).

## How items are rendered (`RSSFeedFormatter::viewElements`)
- Fetches `feed_uri` via `performRequest()` and parses with `simplexml_load_string()`
  (`libxml_use_internal_errors(TRUE)`).
- Picks `->item` (RSS), `->entry` (Atom/YouTube), or `->channel->item`.
- For up to `count` items builds `#theme => 'feed_block_rss_item'` with `#title`, `#url`
  (`entry->link['href']` for Atom, else `item->link`), optional `#date` (from `pubDate`/`published`
  via `date.formatter`), and optional `#description` (strip_tags if plaintext, then `Unicode::truncate`).

## Caching
`FeedBlockHooks::blockContentViewAlter` sets the block build's `#cache['max-age']` from config
`feed_block:cache_expiration` (default 86400s = 1 day if unset) and adds the `feed_block` cache tag.
`FeedBlockCacheExpire` (event subscriber) propagates the shortest max-age to the page cache. There
is no schema/UI for `cache_expiration`; set it with `drush config:set feed_block cache_expiration
3600 -y` if you want a shorter feed refresh interval.
