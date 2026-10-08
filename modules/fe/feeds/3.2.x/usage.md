Feeds imports and aggregates external data — RSS/Atom feeds, CSV files, OPML, XML sitemaps — into Drupal nodes, users, taxonomy terms and other content entities, with a UI for mapping source columns/elements to fields.

---

Site builders create a **feed type** (a `feeds_feed_type` config entity) that pins one fetcher (where the data comes from: HTTP URL, uploaded file, or server directory), one parser (how to read it: RSS/Atom, CSV, OPML, sitemap), and one processor (what to create: any content entity, e.g. nodes). On the mapping screen they connect each source element to a **target** field plugin, optionally marking targets as unique keys so existing content is updated rather than duplicated. Content editors then create **feeds** (`feeds_feed` entities) of that type pointing at concrete sources; each feed can be imported on demand, in a batch, or periodically via cron. Imports run through a fetch → parse → process pipeline that is queue- and batch-aware for large data sets, dispatches Symfony events at every stage, and can expire old items. Feeds ships Drush commands for headless imports, granular per-feed-type permissions, PubSubHubbub (push) support for real-time feed updates, and is extensible through six plugin types plus the `laminas-feed` reader. The optional Feeds Log submodule records detailed per-item import reports.

---

- Aggregate external RSS/Atom feeds into local nodes for a planet/news site.
- Import a CSV product catalog into commerce or content entities.
- Sync data from a remote system by re-importing an HTTP source on cron.
- Bulk-load users from a CSV with roles and email addresses.
- Import taxonomy terms from a spreadsheet to seed a vocabulary.
- Update existing nodes in place using a GUID/unique-target key.
- Import OPML blogrolls to create multiple feed subscriptions at once.
- Ingest an XML sitemap to mirror another site's URL set.
- Schedule periodic imports (e.g. hourly) with a configurable import period.
- Run one-off imports of a static data file uploaded through the UI.
- Fetch every file dropped into a server directory and import them.
- Map source columns to arbitrary Drupal fields (text, date, link, image, references).
- Download and attach remote images/files to imported entities.
- Set entity references (authors, terms) by matching a source value.
- Delete previously imported items that disappear from the source (expire).
- Trigger imports from scripts or CI with `drush feeds:import`.
- Import all feeds of selected types in one command for a nightly job.
- Receive real-time updates from PubSubHubbub-enabled publishers.
- Give each editor their own feed of a shared feed type via per-type permissions.
- Push raw payloads into an import programmatically (`$feed->pushImport($raw)`).
- Migrate content between sites by exporting CSV and importing with Feeds.
- Build a custom fetcher/parser/processor plugin for a bespoke source.
- Add a custom target plugin to map data into a non-standard field.
- Transform/clean source values before import (with Feeds Tamper).
- Parse JSON or XPath/JMESPath sources (with Feeds Extensible Parsers).
- Lock long-running imports so cron and manual runs don't collide.
- Log detailed per-item import reports for debugging (with Feeds Log).
- Rebuild a search index or feed content lake from periodic aggregation.
