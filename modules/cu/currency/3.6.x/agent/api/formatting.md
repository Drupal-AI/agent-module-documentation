<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatting amounts (element, filters, formatter plugins)

## `Currency::formatAmount()`

The simplest path — every `currency` entity can format an amount using the site's default
amount formatter and the resolved locale:

```php
$usd = \Drupal::entityTypeManager()->getStorage('currency')->load('USD');
$usd->formatAmount('1234.5');   // "USD 1,234.50" with the default currency_basic formatter
// signature: formatAmount($amount, $use_currency_precision = TRUE, $language_type = LanguageInterface::TYPE_CONTENT)
```

## Amount formatter plugins

`@CurrencyAmountFormatter` plugins turn `(currency, amount)` into a string. The default is
`currency_basic` (`Basic::formatAmount()`): it resolves a `currency_locale` via
`currency.locale_resolver`, then `number_format()`s with that locale's separators and prepends
the sign/code. The site default is chosen on the amount-formatting form
(`/admin/config/regional/currency-formatting`, `currency.amount_formatting`), stored in config
`currency.amount_formatting` → `plugin_id`. Manager service:
`plugin.manager.currency.amount_formatter`.

## The `currency_amount` render/form element

`@FormElement("currency_amount")` collects a monetary value (amount + currency select) and
parses it with the `currency.input` parser. Use it in a form:

```php
$form['price'] = [
  '#type' => 'currency_amount',
  '#title' => $this->t('Price'),
  '#default_value' => ['amount' => '9.99', 'currency_code' => 'USD'],
];
```

## Text-format filters (for editors)

Enable these on a text format at `/admin/config/content/formats`:

- **`currency_exchange`** — converts money inline: `[currency:FROM:TO:amount]`, amount optional
  (defaults to 1). Example `[currency:EUR:USD:100]`. Falls back to the raw token if no rate.
- **`currency_localize`** — formats amounts found in the text using the amount formatter.

Both use the `commercie/currency` input parser and the exchange/format services above.
