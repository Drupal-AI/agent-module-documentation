# Feeds Crawler Fetcher — manual setup guide

**Feeds Crawler Fetcher** (`feeds_crawler_fetcher`) adds a new fetcher to the
[Feeds](https://www.drupal.org/project/feeds) module that can crawl a **set of
URLs** rather than a single source. This is handy when the data you want to
import is spread across several pages — for example a paged listing where each
page has its own URL — and you'd rather point Feeds at the whole list than run a
separate import for each one.

You enter the URLs in a textarea, one per line, on the feed itself. On import the
fetcher retrieves each URL server‑side and passes the content on to the parser
you've chosen. Note that the module is still in development and currently works
with **XML/HTML sources** (pair it with a parser such as the one from
[Feeds Extensible Parsers / `feeds_ex`](https://www.drupal.org/project/feeds_ex)).

The URL list is part of a feed's configuration, so it is entered and maintained
by the people who administer feeds — the same trust boundary as any other Feeds
source URL.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds.

There is **no separate settings page** for this module. The fetcher is selected
and the URLs are entered as part of a feed type / feed, described in "How to use
it" below.

## Where it lives in the admin menu

The fetcher becomes available when you create or edit a feed type at **Structure →
Feed types**. The URL list is entered on individual feeds at **Content → Feeds**.

## How to use it

1. Create a new feed type at **Structure → Feed types** (or edit an existing one).
2. For the **Fetcher**, choose **Crawl a set of url**.
3. Choose a parser suited to your source (XML/HTML — for example a Feeds
   Extensible Parsers parser) and configure the mapping as usual.
4. Add a feed at **Content → Feeds** for that type, and paste one or more URLs into
   the textarea, one per line.
5. Run the import. The fetcher crawls each URL in turn and feeds the content to
   your parser.
