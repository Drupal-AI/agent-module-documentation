# Configuration

Configuring Aggregator means three things: adding the feeds you want to pull in,
tuning the global settings (retention and listing size), and granting the right
permissions. Feed importing itself happens on cron.

## Grant the permissions first

At **People → Permissions** (`/admin/people/permissions`) there are two:

- **View news feeds** (`access news feeds`) — lets a role see the public listing
  at `/aggregator` and view feeds and items. Grant this to whichever visitors
  should read aggregated content (often *anonymous* and *authenticated*).
- **Administer news feeds** (`administer news feeds`) — lets a role add and manage
  feeds, import OPML, refresh feeds, and change settings. **Grant this only to
  trusted roles.** Because the site fetches feed URLs server‑side, someone with
  this permission could point a feed at an internal address (a low‑threat form of
  SSRF). This is a restricted permission for that reason.

## Add a feed

1. Go to **Configuration → Web services → Aggregator**
   (`/admin/config/services/aggregator`) — this lists your feeds.
2. Add a feed at `/aggregator/sources/add`. Give it:
   - a **Title**,
   - the feed **URL** (the RSS/Atom/RDF address), and
   - a **refresh interval** — how often cron should re‑check it.
3. Save. On the next cron run (for feeds whose interval has elapsed), the module
   downloads the feed and stores its articles.

You can also **refresh a single feed on demand** and **delete a feed's stored
items** from the overview page.

## Import feeds from OPML

If you have an OPML file exported from another reader, import several feeds at
once at **`/admin/config/services/aggregator/add/opml`**.

## Global settings form

Open the settings form at
`/admin/config/services/aggregator/settings`. What appears depends on which
plugins are active:

- **Fetcher / parser / processor selection** — radios and checkboxes for these
  only appear when more than one plugin of that type is installed. With just the
  default plugins, you won't see a choice here — only the processor settings
  below.
- **Discard items older than** (`items.expire`) — how long imported items are
  kept before the default processor trims them. The default is roughly 16 weeks.
  (This setting is contributed by the default processor, so it shows only while
  that processor is active.)
- **Items shown per feed on listing pages** (`source.list_max`) — caps how many
  items appear per feed on listing pages. Default 3.

Save the form to apply. These settings live in the exportable `aggregator.settings`
config object.

You can also set them from the command line, for example:

```bash
drush config:set aggregator.settings source.list_max 10 -y
drush config:set aggregator.settings items.expire 2419200 -y   # 4 weeks
```

## Show a feed in a block

A ready‑made **"Aggregator feed"** block lists the latest items from one feed.
Place it from **Structure → Block layout** (`/admin/structure/block`) and, in its
settings, choose the feed and how many items to show.

## Views and re‑publishing

If Views is enabled, the module ships two views — `aggregator_rss_feed` (to
re‑publish an aggregated feed as your own RSS) and `aggregator_sources` (to filter
items by source) — that you can customise like any other view. Imported item
bodies are rendered through a restricted `aggregator_html` text format that
sanitises untrusted feed HTML.
