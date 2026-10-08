Currency Taxonomy creates a `currency` taxonomy vocabulary pre-populated with every ISO 4217 currency, each term carrying its alphabetic ISO code, numeric code and country.

---

On install the module creates a taxonomy vocabulary with machine name `currency` plus three string fields on its terms (`field_currency_iso`, `field_currency_number`, `field_currency_country`) and generates one term per currency from the bundled `currency_codes.json` data file. Term names follow the `Currency Name (ISO code)` format, e.g. `Euro (EUR)`. The vocabulary and its fields are shipped as install-time configuration, so no configuration form is exposed. A `CurrencyTaxonomyService` (service id `currency_taxonomy.service`) provides helper methods to create currency terms and to look one up by ISO code, numeric code or country. A Drush command (`currency-taxonomy:import`, alias `cti`) deletes all currency terms and re-imports them from the data file. Uninstalling the module deletes the `currency` vocabulary (and therefore its terms). Because term creation runs `Term::save()` once per currency, enabling the module does a batch of ~150 saves and can be slow.

---

- Provide a ready-made, standards-based currency vocabulary without hand-entering ISO 4217 data.
- Reference currencies from content types via an entity reference field targeting the `currency` vocabulary.
- Build a currency select/autocomplete widget on nodes, products or profiles backed by the vocabulary.
- Look up a currency term programmatically by alphabetic ISO code (e.g. `EUR`) with `getCurrencyByCode()`.
- Look up a currency term by numeric ISO code (e.g. `978`) with `getCurrencyByNumber()`.
- Look up a currency term by country name (substring match) with `getCurrencyByCountry()`.
- Store a currency's numeric ISO code alongside content for payment or accounting integrations.
- Display currency names and ISO codes in Views by adding the vocabulary's fields as Views fields.
- Filter or facet content by currency using the taxonomy term reference.
- Seed a multi-currency e-commerce or pricing catalogue with a canonical list of currencies.
- Map an external system's ISO codes to Drupal taxonomy terms during migration or import.
- Attach additional custom fields (symbols, exchange-rate ids) to the provided `currency` terms.
- Create a new currency term in code via `CurrencyTaxonomyService::createCurrency()`.
- Re-import the full currency set after editing `currency_codes.json` using `drush currency-taxonomy:import`.
- Reset accidental term edits back to the shipped currency list via the Drush re-import command.
- Populate a country-to-currency lookup table for forms or reports.
- Drive a language/locale-aware currency picker where each term is translatable.
- Tag orders, invoices or transactions with a currency taxonomy term for reporting.
- Provide autocomplete of currencies by name in editorial workflows.
- Use the vocabulary as a controlled list so editors cannot enter invalid currency codes.
- Expose currencies over JSON:API or REST as taxonomy terms for a decoupled front end.
