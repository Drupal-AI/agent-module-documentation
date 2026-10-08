Currency Field adds a field type that lets editors pick a currency from the full ISO 4217 list instead of typing a code into plain text.

---

Currency Field ships a single field type (`currency_field`) with a matching select widget (`currency_widget`) and formatter (`currency_formatter`), available on any fieldable entity. The complete ISO 4217 currency list is bundled locally in `currencies.yml` (sourced from the currency-codes dataset), so the field never calls an external API. Each row carries an alphabetic code (e.g. `USD`), a numeric code, a currency name, the issuing entity/country, a minor-unit count, and an optional withdrawal date. A per-field storage setting (`display`) chooses which of those columns labels the select options — Alphabetic Code, Country Name, or Currency Name — while the stored value is always the value of that same chosen column, saved as a string in a `varchar(255)` column. The formatter simply HTML-escapes the stored value for output. Two procedural helpers, `currency_field_currencies()` and `currency_field_currency_options()`, expose the same data to any other module. The module has no configuration page, no permissions, no dependencies beyond Drupal core, and is maintained for fixes rather than new features.

---

- Add a "Currency" field to a content type so editors select the currency for a price, invoice, or product.
- Store a currency alongside a numeric amount field to record money in a specific denomination.
- Replace a free-text currency text field with a validated ISO 4217 select list to eliminate typos.
- Configure the field to store and show alphabetic codes (`USD`, `EUR`, `GBP`) for machine-friendly data.
- Configure the field to display full currency names ("US Dollar", "Euro") to editors while storing the same.
- Configure the field to key options by country/entity name for a geographically framed picker.
- Add the field to a taxonomy term, user, or media entity — any fieldable entity — not just nodes.
- Attach it to a Paragraph or custom entity bundle to build a structured price component.
- Use it in a commerce or fares context (e.g. GTFS Fares) to tag a fare product's price with a currency.
- Present a required currency select with no empty option, or an optional one with a blank first choice.
- Rely on the bundled dataset so the picker works offline with no API keys or external services.
- Keep historical records valid: withdrawn currencies remain in the dataset with their withdrawal date.
- Generate realistic sample content — `generateSampleValue()` picks a random currency for Devel/Content generation.
- Call `currency_field_currencies()` in custom code to get the full decoded ISO 4217 list as an array.
- Call `currency_field_currency_options()` to build a Form API `#options` array keyed/labelled by any two columns.
- Populate a custom form's select element with currency options without re-implementing the dataset.
- Map a stored numeric code back to a currency or country name using the same dataset.
- Standardize currency entry across multiple content types by reusing one field type.
- Export/import currency values as plain string codes through Feeds, migrations, or the JSON:API.
- Filter or facet content by currency code in Views, since the value is a plain stored string.
- Build reports that group entities by their selected currency code.
- Localize the option labels through Drupal's translation of the currency/country names where applicable.
