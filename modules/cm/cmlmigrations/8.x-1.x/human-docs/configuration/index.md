# Configuration

CML Migrations is configured on its own settings page (`cmlmigrations.settings`),
and imports are run from there and via Drush.

## Before you import: field naming

The migrations expect the CML Starter field structure. In particular:

- The product's taxonomy term field must be named **`field_catalog`**.
- The product's image field must be named **`field_image`**.

If your product type uses different field names, the migration won't map data
correctly — align the fields (or install CML Starter, which provides them) first.

## The settings page

Open the module's settings page to configure the migrations. This page also provides
the **`product_uuid` fill / clear buttons**:

- Use **fill** to populate the `product_uuid` field on existing variations.
- Use **clear** if you want to reinstall the migrations from a clean state.

Remember to run `drush entity-updates` after installing or updating the module so the
`product_uuid` field exists.

## Running the migrations

Imports are driven through the Migrate framework. The module provides **Drush
commands** to run the CML migrations — this is the usual way to import taxonomy,
variations and products received from 1C. You can also trigger and inspect the
migrations from the settings page, and the module includes debugging tools for the
exchange.

## Treat imported data as external input

The data being imported originates from the 1C exchange, so treat it as untrusted
external input. The module operates entirely through the Migrate framework and has
no runtime access role of its own.
