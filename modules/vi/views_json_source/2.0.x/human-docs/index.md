# Views JSON Source — manual setup guide

**Views JSON Source** (`views_json_source`) lets you build a Drupal View whose rows
come from a JSON document — a remote REST/JSON API or a local JSON file — instead of
the site's database. It adds a new Views **query backend**, so once you point a View
at a JSON source you get all the usual Views goodness (fields, filters, sorts,
contextual filters, pagers, and styles like table or grid) on top of external data.
It's a clean way to surface a third‑party feed inside your Drupal theme, aggregate
data from a headless service, or prototype against a static fixture and later swap in
the live API.

You create a normal View but choose **JSON** as what it shows, then set the source in
the View's **Query settings**: the JSON URL or local path (Drupal tokens like
`[site:url]` are allowed), and an **apath** pointer to the array of records inside
the document. The apath mini‑syntax walks the decoded JSON with `/`‑separated keys —
`data/records` descends into nested objects, `nid=2/related` picks a matching array
element, and `%` acts as a wildcard filled by a contextual filter. Nested objects are
flattened so a key like `author/name` becomes addressable. You can send request
headers (as JSON, token‑replaceable — handy for auth), use GET or POST with a request
body, and handle single‑object responses as well as lists.

The module ships Views handlers that all target a JSON key via an apath: a **field**
(with an optional "trusted HTML" raw‑render toggle), a **filter** (with operators
like equals, contains, starts/ends with, regex, and length comparisons, evaluated in
PHP), a **sort** (natural, case‑insensitive), and three **contextual‑filter**
handlers for filling a row value, an apath `%`, or a `%` in the request URL. Remote
responses are cached to avoid hammering the API, and a `PreCacheEvent` lets developers
rewrite the payload before it's cached (for example, to unwrap an API envelope). The
module depends only on core **Views**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

You build JSON‑backed views in the normal **Views UI** (**Structure → Views**,
`/admin/structure/views`). The module also adds one small global settings page at
**Configuration → User interface → Views JSON Source settings**
(`/admin/config/user-interface/views-json-source-settings`), covered under
[Caching](#caching) below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Create a new View and, for **View settings → Show**, choose **JSON**.
3. Open **Advanced → Query settings** and set:
   - **JSON file** — the URL of your API, or a `/`‑relative path to a local JSON
     file. Tokens such as `[site:url]` are allowed, and a `%` in the URL can be
     filled by the URL‑parameter contextual filter.
   - **Row apath** *(required)* — the apath to the array of records inside the
     response, for example `data/records`.
   - Optionally set **headers** (a JSON string of request headers, values
     token‑replaced), switch **request method** to POST with a **request body**,
     tick **single payload** if the response is one object rather than a list, and
     leave **show errors** on while developing.
4. Add **fields** and set each one's **Key Chooser** to the apath of the JSON key you
   want in each row (nested keys look like `author/name`). Add filters and sorts the
   same way, targeting a key.
5. Save and view — your rows now come from the JSON source, styled by whatever Views
   format you picked.

## Caching

Remote JSON responses are cached so your View doesn't call the API on every request.
The cache lifetime is controlled by a single global setting, **cache TTL**, on the
settings page above (default **86400** seconds, i.e. one day). Lower it if your data
changes often:

```bash
drush cset views_json_source.settings cache_ttl 3600 -y
```

Local JSON files (a path with no host) are read fresh and not cached. To transform a
payload before it's cached — for instance to unwrap an envelope or strip large unused
fields — subscribe to the module's `PreCacheEvent` from a custom module.
