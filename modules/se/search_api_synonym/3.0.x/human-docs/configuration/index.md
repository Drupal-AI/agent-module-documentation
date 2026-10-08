# Configuration

Working with Search API Synonym has three parts: managing the synonym entries,
configuring how and where they are exported, and (optionally) importing entries in
bulk. Everything lives under **Configuration → Search and metadata → Search API
Synonyms** (`/admin/config/search/search-api-synonyms`).

## 1. Manage synonym entries

The main page is a list of your synonym records. Use **Add** to create one, and
**Edit** / **Delete** on each row. A record has:

- **Word** — the base term (for example "car").
- **Synonyms** — the equivalent term(s) (for example "automobile").
- **Type** — either **Synonym** (a genuine equivalent) or **Spelling error** (a
  common misspelling that should still match).
- **Language** — the language the record applies to, for multilingual sites.

There is also a **Delete all** action to clear the whole dictionary at once.

Managing entries here requires the **Administer search api synonyms** permission.

## 2. Export and cron settings

Open the **Settings** tab (`/admin/config/search/search-api-synonyms/settings`;
requires **Administer search api synonym configuration**). This controls how the
synonyms are written to a file the search backend can read:

- **Export plugin** (`cron.plugin`, default **Solr**) — the format to export. Solr
  is built in; other formats appear here if a module provides them.
- **Interval** (`cron.interval`, default **86400** seconds = 24 hours) — how often
  cron regenerates the export file.
- **Type** (`cron.type`, default **all**) — export all records, only synonyms, or
  only spelling errors.
- **Filter** (`cron.filter`) — optionally skip terms depending on whether they
  contain spaces (`nospace`, `onlyspace`, or `all`).
- **Separate files** (`cron.separate_files`, default **on**) — write separate files
  per type and language instead of one combined file.
- **Export if changed** (`cron.export_if_changed`, default **on**) — only rewrite
  the file when synonyms have actually changed since the last run, to avoid
  needless work.
- **File export location** (`cron.file_export_location`) — the directory or stream
  where the generated file(s) are written. Point this at the location your Solr
  server reads its synonyms from.

Save the form. From then on the file is regenerated on cron according to your
settings.

## 3. Import synonyms in bulk

Open the **Import** tab (`/admin/config/search/search-api-synonyms/import`;
requires **Import search api synonyms**). Choose an import format, upload a file,
and the module parses the rows into synonym entries:

- **CSV** — a `word,synonym,type` file.
- **JSON** — a structured JSON file.
- **Solr** — an existing Solr synonyms text file.

The upload is validated against the chosen format's allowed file extensions before
it is parsed. The shipped `examples/` files show the expected shape of each format.

## 4. Export from the command line

You can export on demand (or from your own scheduler) with Drush instead of waiting
for cron:

```bash
drush search-api-synonym:export --plugin=solr --langcode=da --type=all --filter=all
```

Useful options: `--langcode` (required — the language to export), `--type`
(`synonym`, `spelling_error`, or `all`), `--filter`, `--incremental` (a Unix
timestamp to export only entries changed after that time), and `--file` (the output
filename). The command prints the path of the file it wrote. Its aliases are
`sapi-syn:export` and `sapi-syn-ex`.

## Permissions

At **People → Permissions** the module defines:

| Permission | Gates |
|------------|-------|
| **Administer search api synonyms** | Full access to the synonym list — add, edit, delete, and delete-all. |
| **Administer search api synonym configuration** | The export/cron **Settings** form. |
| **Import search api synonyms** | The **Import** screen. Only lets a holder create synonym records from a validated upload, so it is reasonable to grant to a content-team role. |
| **View search api synonyms** | View synonym entities. |
