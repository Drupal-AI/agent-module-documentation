# Configuration

There are two parts to configuring this module: storing a **Google API key**, and
referencing the **`google_sheets` parser** in a migration definition.

## Store the Google API key

1. Go to **Configuration → Web services → Google Sheets**
   (`/admin/config/services/google_sheets`). You need the core **Administer site
   configuration** permission.
2. Paste your Google API key and save.

Or set it from the command line:

```bash
drush config:set migrate_google_sheets.settings api_key 'AIza...' -y
```

At fetch time the parser appends this key to the request as `?key=<api_key>` — **but
only if the sheet URL doesn't already carry a `key` query parameter**. So you can
override the stored key for a single migration by putting `key=` directly in that
migration's URL. A key is only required for sheets that need one; a fully published /
public sheet may be readable without it.

> **Keeping the key out of config exports.** This form stores the API key as plain
> config. If you'd rather keep the secret out of version control, set it per
> environment from an environment variable in `settings.php`, e.g.
> `$config['migrate_google_sheets.settings']['api_key'] = getenv('GOOGLE_API_KEY');`.

## Reference the parser in a migration

The `google_sheets` parser plugs into an ordinary Migrate Plus `url` source. Point it
at a Sheets API v4 `values` endpoint:

```yaml
source:
  plugin: url
  data_fetcher_plugin: http
  data_parser_plugin: google_sheets
  # v4 endpoint: /spreadsheets/<SHEET_ID>/values/<TAB or range>
  urls: 'https://sheets.googleapis.com/v4/spreadsheets/<SHEET_ID>/values/Game'
  # cache_lifetime: 3600     # optional: seconds to cache the fetched response
  fields:
    - { name: id,    label: 'Unique identifier', selector: 'id' }
    - { name: title, label: 'Title',             selector: 'title' }
    - { name: body,  label: 'Body',              selector: 'body' }
  ids:
    id:
      type: integer
process:
  title: title
  body/value: body
destination:
  plugin: entity:node
```

The important behaviors to understand:

- The endpoint must return JSON with a top‑level **`values`** array (the Sheets v4
  `spreadsheets.values.get` shape).
- **The first row of the sheet is treated as the header row.** Each field's
  `selector` is matched (case‑insensitively) against those column headers, and the
  cell in that column becomes the value. So your `selector` values must equal the
  sheet's first‑row column names.
- **`cache_lifetime`** (optional, per source, default off) caches the decoded
  response for that many seconds to cut down on API calls while you iterate.

`process`, `ids`, `destination`, and dependencies are all standard Migrate / Migrate
Plus configuration. Run the migration with core Migrate or Migrate Tools
(`drush migrate:import <id>`) — this module adds no Drush of its own. See the sibling
[`agent/plugins/data_parser.md`](../agent/plugins/data_parser.md) for the full parser
reference.
