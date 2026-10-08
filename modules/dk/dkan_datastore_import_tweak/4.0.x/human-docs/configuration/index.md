# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **`/admin/dkan/parser-settings`**.

The form has two fields, both fixed dropdowns.

## Delimiter

The character that separates columns in your CSV files. Choose the one that
matches your data supplier's format:

- **Comma** (`,`) — the default, standard CSV.
- **Semicolon** (`;`) — common in European exports, where the comma is used as a
  decimal separator.
- **Whitespace** — for space‑separated data files.

If your imports are splitting columns in the wrong places, the delimiter is almost
always the setting to change.

## Quoting character

The character used to wrap field values that contain the delimiter or other
special characters:

- **Double quote** (`"`) — the default.
- **Single quote** (`'`) — choose this when your source files quote values with
  apostrophes/single quotes.

## Save and re‑import

Click save. The chosen delimiter and quote are stored in the
`dkan_datastore_import_tweak.parser_settings` configuration and applied to every
subsequent datastore import — the module injects them into DKAN's parser when an
import runs. To fix an already‑broken import, correct the settings here and then
re‑import the dataset's resource.

Because both values come from fixed dropdowns (not free‑form text), they can't be
used to inject anything into the parser or the MySQL `LOAD DATA` statement.

## MySQL importer (submodule)

If you enabled **dkan_datastore_mysql_import_tweak**, no extra configuration is
needed — the same delimiter you set here is automatically applied to DKAN's MySQL
importer's `LOAD DATA` path.

## Keeping settings across environments

The parser settings are stored as exportable configuration, so you can roll them
between environments with Drupal's config sync like any other setting.
