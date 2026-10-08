# Data Field — manual setup guide

**Data Field** (`datafield`) provides a single, highly flexible composite field type whose
storage columns you define yourself. Think of it as a multi-value, multi-column
"spreadsheet" field: one Data Field on an entity can hold a table of rows, where each row has
several sub-columns you configured — a label, a number, a date, an entity reference, a file,
and so on. It is a lighter-weight alternative to Paragraphs (and similar to Triple Field or
Paragraphs Table) when all you need is structured, repeating tabular data in one field.

The power is in the per-column configuration. For every sub-column you choose a **storage
type** (string, text, JSON, integer, float, decimal, boolean, email, telephone, URI, several
date/time flavours, entity reference to nodes/users/taxonomy, or file/image), a **widget**
for editing it (textfield, number, select/radios/checkboxes, autocomplete, media library,
date pickers, color, and many more), and a **formatter** for displaying it. The whole field
is then rendered through a **wrapping formatter** — an HTML table (with Bootstrap-table or
DataTables options), a Google/Highcharts chart, a collapsible details block, an ordered or
unordered list, or a JSON export for a decoupled front end.

Data Field also ships integrations for Feeds (import rows), GraphQL Compose, tokens and REST,
plus keyboard shortcuts for fast inline data entry. It has no admin settings page and no
permissions of its own — everything is configured per field.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is no settings page. You configure a Data Field in the same three places you configure
any field — but with more choices at each step. Add a field of type **Data Field** to a
bundle, then work through:

**1. Storage settings — define the sub-columns.** On the field's storage settings, add each
sub-column with a machine name and a storage type (string, integer, decimal, boolean, date,
JSON, entity reference, file, and so on). A new field starts with one `value` string column;
add more to build your table. Set **cardinality to unlimited** if you want each entity to
hold multiple rows (the usual case).

**2. Field settings — per-column limits and labels.** Give each sub-column a label, and where
relevant set allowed values, min/max, required, on/off labels for booleans, or the target
entity type and bundles for entity-reference columns.

**3. Manage form display — pick a widget per column.** The field uses the *Data Field table*
widget by default. Inside it, choose the editing widget for each sub-column (textfield,
number, select, autocomplete, media library, date/time, color, and more) and options like
placeholder, size and step. Editors then add, duplicate (Ctrl+D), reorder (arrow keys) and
delete rows inline.

**4. Manage display — pick the wrapping formatter.** Choose how the whole field renders:

| Formatter | Renders as |
|---|---|
| **Table** (`data_field_table_formatter`) | An HTML table with optional Bootstrap-table / DataTables sorting and paging, plus a per-column sub-formatter for each column. |
| **Chart** (`data_field_chart`) | A Google Chart or Highchart built from the numeric columns. |
| **Details** (`data_field_details`) | A collapsible `<details>` block. |
| **List** (`data_field_html_list` / `data_field_unformatted_list`) | An ordered/unordered or plain list. |
| **JSON export** (`data_field_json_export`) | A JSON blob for a decoupled front end. |

Each column inside the Table formatter also has its own sub-formatter (string, number, date,
entity-reference label/id/entity, file/image, mailto, telephone link, "time ago", JSON, Twig
template, and more), so you control exactly how each column is displayed.

Because a Data Field is not a normal per-sub-value entity field, core field widgets and
formatters do **not** apply to the sub-columns — the widgets and formatters listed above come
from Data Field's own plugin system. That system is extensible: other modules can add custom
sub-column types, widgets and formatters. See the [`agent/`](../agent/start.md) docs
(`plugins/subplugins.md`) if you need to build one.
