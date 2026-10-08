# Views integration

## Default view

`config/install/views.view.domain_path_redirect.yml` ships a view (id `domain_path_redirect`, label
"Domain Path Redirect") on `base_table: domain_path_redirect` / `base_field: rid`, depending on
`domain_path_redirect`, `link`, `redirect`, `user`, `views`. It provides the fields for the admin
listing (domain, source, destination, status code, etc.). Because it is installed config you can
edit or clone it via the normal Views UI.

## Views data override

`Drupal\domain_path_redirect\DomainPathRedirectViewsData` extends `EntityViewsData` and swaps the
filter on the `domain` field to the custom `domain_autocomplete` filter:

```php
$data['domain_path_redirect']['domain']['filter']['id'] = 'domain_autocomplete';
```

## Filter plugin `domain_autocomplete`

`Drupal\domain_path_redirect\Plugin\views\filter\DomainAutocomplete` (`@ViewsFilter("domain_autocomplete")`)
extends `InOperator`. It replaces the raw domain-id filter with a **domain entity autocomplete** so
admins filter the redirect list by typing domain names instead of picking IDs.

- `valueForm()` renders an `entity_autocomplete` (`#target_type => domain`, `#tags => TRUE`,
  comma-separated).
- `valueValidate()` / `validateExposed()` reduce the autocomplete selections to a sorted array of
  domain `target_id`s (with grouped-filter and exposed-input handling in `acceptExposedInput()`).
- `adminSummary()` loads the selected domains and shows their labels in the Views admin summary.

Config schema for this filter's exposed settings is in
`config/schema/domain_path_redirect.schema.yml` (`views.filter.domain_autocomplete`).

To reuse it in a custom view over `domain_path_redirect`, add a filter on the `domain` field — the
views-data override makes `domain_autocomplete` the filter for that field automatically.
