# Feeds FileMaker — manual setup guide

**Feeds FileMaker** (`feeds_filemaker`) imports records from a **FileMaker Data
API** into Drupal, using the [Feeds](https://www.drupal.org/project/feeds)
framework. It adds a fetcher and a JSON parser: on each run it authenticates
against your FileMaker server to obtain a bearer token, then pulls records — a
one‑off import, or a scheduled one via cron — and maps FileMaker fields onto your
Drupal fields.

The fetcher (**FileMaker API fetcher**) handles the details that make FileMaker
imports awkward otherwise:

- **Authentication** — it POSTs your credentials (HTTP Basic) to the FileMaker
  auth endpoint and uses the returned bearer token for the record requests.
- **GET or POST queries** — GET with `_limit`/`_offset` and custom query
  parameters, or POST with a `_find`‑style JSON query so you can filter records
  (for example surname = Smith, city = Dundee).
- **Batched, resumable pagination** — it pages through large datasets in
  configurable batch sizes (up to a per‑run maximum) and remembers the next offset
  in Drupal's state system, so long imports resume across runs.
- **Throttling** — an optional delay between batches to avoid overwhelming the API.

Credentials are never stored in the module's configuration. Instead the fetcher
reads them from the **Key** module — three keys for the auth endpoint URL, the
username, and the password — whose values are typically supplied via `settings.php`
config overrides so passwords stay out of exported configuration. The FileMaker
Data API is served over HTTPS and the module uses the default TLS verification, so
credentials and the token are protected in transit as long as the endpoint is
HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Feeds and Key, and set up the credential keys.

There is **no separate settings page** for this module. The fetcher and parser are
configured on a feed type, described in "How to use it" below.

## Where it lives in the admin menu

Feeds FileMaker adds no admin page of its own. Its fetcher and parser appear as
options when you create or edit a feed type at **Structure → Feed types**. The
credential keys are managed under the Key module at **Configuration → System →
Keys**.

## How to use it

1. Define the three **Key** entities the fetcher expects —
   `filemaker_auth_endpoint`, `filemaker_username`, and `filemaker_password` — and
   supply their values (see [Installation](installation/index.md) for the
   recommended `settings.php` override approach).
2. Create a feed type at **Structure → Feed types**. For the **Fetcher**, choose
   the **FileMaker API fetcher**.
3. In the fetcher settings, choose the **request method** (GET or POST). For POST,
   supply the `_find` **query criteria** as JSON; for GET, add any custom query
   parameters. Set the **batch size**, an optional **maximum batches per run**, and
   optional **throttling** (enable it and set a delay of at least one second).
4. Choose the **FileMaker parser** and set the feed's **source URL** to the
   FileMaker Data API records endpoint.
5. Choose a processor (typically the **node** or another entity processor) and map
   FileMaker fields onto your Drupal fields.
6. Run the import from the feed, or set a periodic import so it runs on cron. For
   large datasets, prefer background/periodic processing, since very large imports
   can time out through the web UI.
