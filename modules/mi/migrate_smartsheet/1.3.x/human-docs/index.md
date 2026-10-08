# Migrate Smartsheet — manual setup guide

**Migrate Smartsheet** (`migrate_smartsheet`) is a developer module that adds a
Migrate *process plugin* (`smartsheet`) for working with data from the
[Smartsheet](https://www.smartsheet.com/) API. The Smartsheet API returns each
sheet as two parallel JSON arrays — a `columns` array that maps column names to
numeric column IDs, and a `rows` array where every row carries a `cells` array
keyed by those same column IDs. That's awkward to map onto Drupal fields
directly. This plugin does the lookup for you: given a row's `cells` array and a
`column_id`, it returns that column's value for the row.

It can also do a lightweight conditional mapping: set a `compare_value` and the
plugin returns your `return_true_value` or `return_false_value` depending on
whether the cell matches — handy for turning a Smartsheet status column into, say,
a published flag or a taxonomy term.

Importantly, this module supplies **only the process plugin**. It does *not*
fetch data from Smartsheet or handle authentication — that is done by a separate
source plugin in your migration (typically the **Migrate Plus** URL/HTTP source),
which is where your Smartsheet **API key** lives. The module depends on core
**Migrate**, plus **Migrate Plus** and **Migrate Tools**, and adds no admin pages
or permissions — you use it entirely from your migration YAML.

Because the source fetches from the Smartsheet API over the network, be mindful
of two things: your server needs outbound HTTPS egress to `api.smartsheet.com`,
and your **API token is a secret** — never hard‑code it into a committed
migration file. See Installation for how to store it safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and store your Smartsheet API token securely.

There is **no configuration page** for this module — it has no settings form.
You use it from your migration definitions, as described below.

## How to use it

Your migration's **source** (a Migrate Plus HTTP source pointed at the Smartsheet
API, authenticated with your token) must expose the row's `cells` array. Then map
each column through the `smartsheet` process plugin:

```yaml
process:
  title:
    plugin: smartsheet
    source: cell_array      # the row's cells array
    column_id: 123456789    # the Smartsheet columnId to match
    return_key: 'value'     # which cell key to return (e.g. value / displayValue)
```

For a conditional mapping:

```yaml
  field_flag:
    plugin: smartsheet
    source: cell_array
    column_id: 123456789
    return_key: 'value'
    compare_value: 'Done'
    return_true_value: 1
    return_false_value: 0
```

The plugin matches the cell whose `columnId` equals your `column_id` and returns
the requested `return_key`. It throws a `MigrateException` if the value passed in
isn't traversable or if `column_id` is missing, so misconfiguration fails loudly
rather than silently. Run the migration with `drush migrate:import` (from Migrate
Tools).

> **Finding column IDs:** query the Smartsheet API's `columns` array once to look
> up the numeric `columnId` for each column you want to map, then use those IDs in
> your `smartsheet` process steps.
