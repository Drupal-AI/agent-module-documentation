# Turn tokens on for a Views filter

No admin settings page. You enable tokens **per filter** inside a View.

## In the Views UI

1. Edit the View, open a **string / numeric / date / datetime / combine / list-field /
   geofield-proximity** filter's settings.
2. Tick **Use tokens**. A token-browser link appears (token types `view`, `current-page`).
3. Put a token in the filter **Value**, e.g. `[current-user:uid]`, `[site:name]`,
   `[current-page:query:q]`.
4. Save the View. On execution the value is token-replaced before the query runs.

Only filters whose plugin id the module replaces show the checkbox (see start.md list). The
checkbox comes from `TokensFilterTrait::buildOptionsForm()`; the option is defined by
`defineOptions()` as `use_tokens` (default FALSE).

## Where it is stored

Inside the View config entity `views.view.<id>`, on the filter handler:

```yaml
display:
  default:
    display_options:
      filters:
        title:                 # the filter's id
          id: title
          field: title
          plugin_id: string
          operator: '='
          value: '[site:name]'
          use_tokens: true      # <-- added by this module
```

Read/set it with drush:

```bash
drush cget views.view.myview display.default.display_options.filters.title.use_tokens
drush cset -y views.view.myview display.default.display_options.filters.title.use_tokens true
drush cset -y views.view.myview display.default.display_options.filters.title.value '[current-user:name]'
```

## How resolution works

`TokensFilterTrait::preQuery()` runs when the filter executes:

```php
$this->value = $this->token->replace($this->value, ['view' => $this->view], ['clear' => TRUE]);
```

- Token types available: `view` and `current-page`.
- `clear => TRUE` means unmatched/empty tokens resolve to an empty string.
- Grouped (exposed) filters are handled too: `convertExposedInput()` tokenises the selected
  group item's value.
- Date filters use `TokensDateFilterTrait`; geofield proximity uses `TokensGeofieldFilterTrait`.

The `use_tokens` boolean is added to each affected filter's config schema at runtime by
`token_views_filter_config_schema_info_alter()` — you will not find it in a `config/schema`
file.
