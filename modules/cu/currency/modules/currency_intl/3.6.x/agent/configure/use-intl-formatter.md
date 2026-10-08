<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Use the Intl amount formatter

Currency Intl adds the amount-formatter plugin `currency_intl` ("Unicode number patterns").
It only takes effect once you make it the **default** amount formatter (the parent module
picks one default for the whole site).

## Via the UI

1. Go to *Configuration → Regional and language → Currency amount formatting*
   (`/admin/config/regional/currency-formatting`, permission
   `currency.amount_formatting.administer`).
2. Select **Unicode number patterns** (the Intl formatter).
3. Save.

## Via config / drush

The choice is stored in config `currency.amount_formatting` → `plugin_id`:

```bash
drush cset currency.amount_formatting plugin_id currency_intl -y   # switch on
drush cget currency.amount_formatting plugin_id                    # read back
drush cset currency.amount_formatting plugin_id currency_basic -y  # revert to Basic
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('currency.amount_formatting')
  ->set('plugin_id', 'currency_intl')->save();
```

After switching, `Currency::formatAmount()`, the `currency_amount` element and the
`currency_localize` filter all render through the Intl `NumberFormatter`.

## Requirement

Needs the PHP `intl` extension. Check the status report (`/admin/reports/status`) — the module
adds a "PHP Intl extension: Loaded / Not loaded" line via `currency_intl_requirements()`.
