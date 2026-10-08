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

## `country.field.manager` service

`\Drupal\country\CountryFieldManager` (args: `@country_manager`, `@language_manager`).

- `getSelectableCountries(FieldDefinitionInterface $field_definition)` — the effective
  country list for a field, honouring its `selectable_countries` setting (falls back to all).
- `getList()` — the full ISO-code → name list (localized, sorted; `ext-intl` improves
  non-English sorting).

```php
$manager = \Drupal::service('country.field.manager');
$all = $manager->getList();                       // ['US' => 'United States', ...]
$choices = $manager->getSelectableCountries($fieldDefinition);
```

Country names themselves come from core's `country_manager`
(`\Drupal::service('country_manager')->getList()`), which this module builds on.

## Token

`country_token_info()` / `country_tokens()` add, for every `country` field on every content
entity, a token:

```
[<token_type>:<field_name>:country_original_name]   →  the country name
```

e.g. `[node:field_country:country_original_name]`. Useful in emails, pathauto, etc.

## Autocomplete route

`country.autocomplete` → `/country/autocomplete/{entity_type}/{bundle}/{field_name}`,
controller `CountryAutocompleteController::autocomplete` (`_access: TRUE`). Backs the
`country_autocomplete` widget; you rarely call it directly.
