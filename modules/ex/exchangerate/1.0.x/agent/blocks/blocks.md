<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exchange Rate — blocks, converter form & templates

Both blocks are core Block plugins (category "Exchange Rate"); place them at `/admin/structure/block`. Each injects `exchangerate.api`.

## `exchangerate_block` — Exchange Rate (rates display)
`src/Plugin/Block/ExchangeRateBlock.php`. Renders `#theme => 'exchangerate_block'` (`templates/exchangerate-block.html.twig`), attaches library `exchangerate/exchangerate_styles`, cache tag `config:exchangerate.settings`, `max-age 0`.

Block settings (`blockForm()`/`blockSubmit()`, stored in block config):
- `show_base_currency` (bool) + `base_currency_text` (string label).
- `description` (`text_format`, allowed formats = all `filter_format` ids; rendered with `check_markup()`, and embedded file UUIDs are tracked via `file.usage` when the `editor` module is present).
- `layout` — `layout-1`…`layout-6` (list / flex cards / CSS grid / grid rows / dark gradient / striped table; CSS in `css/exchangerate-block.css`).
- Display options: `decimal_places` (0–8, overrides global), `show_flags`, `show_symbol`, `show_name`, `show_last_updated`.
- `countries` — a draggable table (`selected` + `weight` per currency code); selected rows are shown, ordered by weight. Rates are formatted via `ExchangeRateApi::formatRate()`.

## `currency_converter_block` — Currency Converter
`src/Plugin/Block/CurrencyConverterBlock.php`. `build()` renders `CurrencyConverterForm` via the form builder, passing block defaults, and attaches `core/drupal.ajax` + `exchangerate/exchangerate_converter`. Block settings: `default_base_currency`, `default_target_currencies` (comma list), `decimal_places` (0–8, default 2). Cache max-age 600 + tag `config:exchangerate.settings`.

### `CurrencyConverterForm`
`src/Form/CurrencyConverterForm.php`, form id `currency_converter_form` (a plain `FormBase`, not a route form — instantiated by the block). Fields: `base_currency` (autocomplete → `exchangerate.autocomplete`), `amount` (number, >0), `target_currencies` (autocomplete-multiple), and a `Convert` submit with an AJAX callback `convertCurrency()`.
`convertCurrency()` validates input, calls `ExchangeRateApi::convert()` per target, builds `#theme => 'currency_conversion_results'`, and returns an `HtmlCommand` replacing `#currency-conversion-results`. Errors (empty fields, unknown currency, empty rates) render into the same results theme with `has_errors`.

## Theme hooks (`exchangerate.module`, `hook_theme()`)
- `exchangerate_block` — vars `rates, countries, base_currency, extra_data`.
- `currency_conversion_results` — vars `results, errors, amount, base_currency, base_currency_flag, base_currency_symbol, has_results, has_errors` (`templates/currency-conversion-results.html.twig`).
- `currency_converter_block` — var `form`.

Templates use standard Twig auto-escaping (no `|raw`); the rich-text block description is the only markup path and is filtered through `check_markup()` against an allowed text format. Override templates by copying them into a theme's `templates/` dir; override styles by targeting `.exchangerate-block.layout-N`.
