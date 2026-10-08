<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic API — element, service, token

## `country` form element

`\Drupal\country\Element\Country` — `@FormElement("country")`, extends core `Select`. Use it
in any form to get a country dropdown pre-populated with the full country list:

```php
$form['country'] = [
  '#type' => 'country',
  '#title' => $this->t('Country'),
  '#default_value' => 'US',
];
```

Options are injected in `processSelect()` from `country.field.manager::getList()`. It also
supports `#multiple`, `#required`, `#empty_option`, and array `#default_value`.

## `country.field.manager` service

`\Drupal\country\CountryFieldManager` (args: `@country_manager`, `@language_manager`).

- `getSelectableCountries(FieldDefinitionInterface $field_definition)` — the effective
  country list for a field, honouring its `selectable_countries` setting (field-level first,
  then storage-level; falls back to all).
- `getList()` — the full ISO-code → name list (localized, sorted; uses `\Collator` when the
  `intl` extension is loaded, otherwise `asort()`).

```php
$manager = \Drupal::service('country.field.manager');
$all = $manager->getList();                       // ['US' => 'United States', ...]
$choices = $manager->getSelectableCountries($fieldDefinition);
```

Country names themselves come from core's `country_manager`
(`\Drupal::service('country_manager')->getList()`), which this module builds on.

## Token

`country_token_info()` / `country_tokens()` (delegating to `CountryTokensHooks`) add, for
every `country` field on every content entity, a token:

```
[<token_type>:<field_name>:country_original_name]   →  the country name
```

e.g. `[node:field_country:country_original_name]`. Useful in emails, pathauto, etc. The
`token_info` half only registers when the optional `token.entity_mapper` service is available.

## Autocomplete route

`country.autocomplete` → `/country/autocomplete/{entity_type}/{bundle}/{field_name}`,
controller `CountryAutocompleteController::autocomplete` (`_access: TRUE`). It returns a
JSON list of country names (from the trusted core country list) matching the `q` query
string, restricted to the field's `selectable_countries`; a `{bundle}` of `global` returns
the full list. Backs the `country_autocomplete` widget; you rarely call it directly.

## Hook classes (D11.3+)

Hook implementations live in `src/Hook/` as OOP classes with `#[Hook(...)]` attributes —
`CountryHooks` (help, widget/category alters), `CountryTokensHooks` (token info/tokens),
`CountryViewsHooks` (`field_views_data_alter`). The `.module` / `.tokens.inc` / `.views.inc`
files keep thin procedural wrappers marked `#[LegacyHook]` that delegate to these services.
