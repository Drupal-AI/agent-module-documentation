# Configuration

Before you configure the base module, make sure you have **installed and set up a
data provider submodule** (see [Installation](../installation/index.md)) — the
lookup cannot work without one.

## Open the settings form

1. Log in as a user who can administer site configuration.
2. Go to **Configuration → Web services → Waste collection → Settings**, or
   navigate directly to `/admin/config/services/waste-collection/settings`.

## Settings

- **Data provider** — choose which installed provider plugin supplies the
  schedule data (for example the CSV or Whitespace provider). This is the key
  setting: nothing works until an active provider is selected. Each provider has
  its own configuration (for CSV, the source files; for Whitespace, the API
  credentials) documented in that submodule's README.
- **Base path** — the front-end path under which the lookup lives. The default is
  `/waste-collection-schedule`. Residents' property search and schedule pages hang
  off this path, so `/{base_path}/find?postcode=…` and `/{base_path}/view/{uprn}`
  follow whatever you set here.
- **Public holiday support** *(optional)* — when enabled, the module fetches the
  UK public-holiday list from `https://www.gov.uk/bank-holidays.json` and uses it
  to detect routine collection dates that fall on a holiday. Use the **Ignored
  holidays** field to exclude any of the gov.uk holidays you don't want treated as
  disruptions.

Click **Save configuration** to store the settings.

## Configuring via settings.php (optional)

If you prefer to keep this configuration in code rather than the database, you can
set it in your environment's `settings.php`:

```php
$config['localgov_waste_collection.settings']['active_data_provider'] = 'example_data_provider';
$config['localgov_waste_collection.settings']['waste_collection_path'] = '/my-custom-path';
```

Replace the values to match the provider you enabled and the base path you want.

## A note on data handling

Every lookup carries a resident's **address or postcode**, which is personal
data. If your provider forwards those queries to an external API, make sure it
uses HTTPS and that the provider's credentials are stored as secrets rather than
committed to configuration. Disclose the third-party lookups in your site's
privacy policy.
