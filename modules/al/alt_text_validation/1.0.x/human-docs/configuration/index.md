# Configuration

Alt-Text Validation has two things to configure: the **settings form** (a master switch plus
cron options) and the **rules** (what counts as bad alt text and what to do about it). The
audit report is then populated separately.

## Settings form

Go to **Configuration → Content authoring → Alt-Text Validation**
(`/admin/config/content/alt-text-validation`), which requires the *administer alt text
validation* permission. It stores three values:

| Setting | Default | What it does |
|---|---|---|
| **Validation enabled** (master switch) | On | When off, rules are **not** enforced on save — but the report still works. Use this for report-only mode while you gather data before enforcing. |
| **Cron enabled** | On | Rebuild the audit report automatically on cron. |
| **Cron delay** | 7 (days) | How many days between automatic cron rebuilds. |

## Rules

Rules live at `/admin/config/content/alt-text-validation/rules` (same permission). Each rule has:

- a **rule type** (below),
- a **comparison string / limit** where relevant,
- an **action** — **prevent** (block the save with an error), **warn** (show a message but allow
  the save), or **off** (disabled), and
- a **message** shown to the editor (also used as the rule's label in the report).

### Rule types

| Type | Flags the alt text when… |
|---|---|
| `alt_is_filename` | it is exactly the image filename |
| `alt_is_title` | it is exactly the image's title attribute |
| `not_empty` | it is empty |
| `length_limit` | it is longer than the configured character limit |
| `not_begin_with` | it starts with the given phrase (case-insensitive) |
| `not_equal` | it equals the given phrase (case-insensitive) |
| `not_contain` | it contains the given phrase (case-insensitive) |
| `not_end_with` | it ends with the given phrase (case-insensitive) |
| `regex_match` | it matches the given regular expression (supply a full PCRE pattern, delimiters included) |

### The six shipped defaults

All ship as **prevent**: no empty alt text, alt must not equal the filename, alt must not equal
the title, alt must not contain "copyright", alt must not begin with "image of", and alt must
not begin with "photo of". Adjust any of them to *warn* or *off* to fit your site — a common
first move is to set them all to *warn*, roll out, then promote to *prevent* later.

## The audit report

The report is a View at **Reports → Alt Text Report** (`/admin/reports/alt-text-report`),
requiring the *view alt text validation reports* permission. It reads a custom audit table
rather than live content, so **it must be populated before it shows anything**. There are three
ways to populate it:

1. **Cron** — with *Cron enabled* on, the audit rebuilds on the schedule set by *Cron delay*.
2. **Batch button** — the report header has a **Rebuild the report** button that runs the audit
   as a batch process.
3. **Drush** — run `drush alt-text-validation:queue-audit` (alias `atv-queue`), then run cron.

The audit uses Drupal's Queue API, walking every content entity and pulling alt text from image
fields and from `<img>` tags inside text fields. On large sites it can span several cron runs;
the report header shows start/finish times and status, and you can watch the queue drain with
`drush queue:list`. A typical command-line run:

```bash
drush alt-text-validation:queue-audit
drush cron        # repeat until the queue drains
drush queue:list  # watch atv_entity_instances shrink
```

Once populated, download the report as CSV using the export link at the bottom of the View (that
download comes from the Views Data Export dependency). The report is an ordinary View, so you
can add columns, filters, and exposed filters like any other.

> There is also a development-only Drush command, `drush alt-text-validation:fill-audit-test`
> (alias `atv-fat`), that wipes the audit table and fills it with a few hard-coded demo rows.
> Use it only for testing, never on real data.

## For developers

The rule types are hard-coded (there is no plugin system for adding new ones without code), and
the audit is driven by services (`Auditor`, `ValidationTools`, `AuditStorage`) and queue
workers. See [`agent/api/services.md`](../agent/api/services.md) and
[`agent/configure/settings.md`](../agent/configure/settings.md) for the internals and extension
points.
