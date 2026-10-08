# Configuration

DKAN chart works from the moment it's enabled — a **Visualize** tab appears on
dataset nodes with datastore distributions. The settings below control who can
build charts, how numbers are formatted, and how many rows the charts can pull.

## Permissions

Grant these on the permissions page at
**`/admin/people/permissions/module/dkan_chart`** (and the tables permission on
the same page once `dkan_tables` is enabled):

- **`access chart configuration`** — lets a user open the interactive chart
  builder and customize visualizations. Grant it to your editor roles.
- **`access table configuration`** *(from the `dkan_tables` submodule)* — the
  equivalent permission for building the spreadsheet‑style table output.

Viewing an existing visualization is gated by a data‑based check: the embed and
view routes are available when the node actually holds a datastore distribution,
so anonymous visitors can see published charts without holding the builder
permission.

## Number formatting

You can control how numbers are displayed in charts using the
`dkan_chart.number_settings` configuration:

- **decimal_separator** — the character used for the decimal point in the output.
- **thousands_separator** — the character used to group thousands; this separator
  is removed for the underlying value, and the decimal separator is normalised to
  a full stop for computation.

This is helpful when your audience expects European‑style formatting (for example
`1.234,56`). These values live in configuration; set them in your site's settings
or config YAML, for example:

```php
$config['dkan_chart.number_settings'] = [
  'decimal_separator' => ',',
  'thousands_separator' => '.',
];
```

## Datastore rows limit

Charts are built from the DKAN datastore query API, which caps how many rows a
single request returns. That cap is DKAN's **rows limit** setting at
**`/admin/dkan/datastore`**, and it defaults to **500**. If 500 rows isn't enough
to represent your dataset in a chart, raise the limit there — ideally to the
maximum number of rows your datasets contain. Be aware that setting it too high can
lead to timeouts or memory issues.

## Advanced datastore client options

Two further options in `dkan_chart.settings` tune how the modeller reaches the
datastore API:

- **proxy_bypass** — send datastore requests without going through a configured
  HTTP proxy.
- **basic_auth** — forward the current request's HTTP basic‑auth credentials to
  the datastore endpoint, for sites that protect their datastore behind HTTP auth.

These outbound calls target your own site's `/api/1/datastore/query` on the
current scheme and host, over standard TLS.

## Tables plugin (dkan_tables submodule)

If you enabled `dkan_tables`, the `table_plugin` setting in
`dkan_tables.settings` selects the rendering engine: **DataTables** (the default)
or **RevoGrid** (optional and deprecated). Table output appears on the **Tables**
tab, or directly at `node/{ID}/tables`, and can be embedded via
`/node/{node}/embed/tables`.
