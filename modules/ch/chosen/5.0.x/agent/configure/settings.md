# Settings

![Chosen settings form](../../../../../../../screenshots/chosen/5.0.x/settings.png)

Config object `chosen.settings` (schema `config/schema/chosen.schema.yml`). UI at
`/admin/config/user-interface/chosen` (route `chosen.admin`, form
`Drupal\chosen\Form\ChosenConfigForm`). Read/write with `drush config:get chosen.settings` /
`drush config:set chosen.settings <key> <value>`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `minimum_single` | int | 20 | Min options before Chosen applies to a single select. |
| `minimum_multiple` | int | 20 | Min options before Chosen applies to a multi select. |
| `disable_search_threshold` | int | 0 | Hide the search box when a single select has fewer than N options. |
| `minimum_width` | int | 0 | Minimum widget width. |
| `use_relative_width` | bool | false | Use `%` widths instead of `px`. |
| `jquery_selector` | string | `select:visible` | Which elements Chosen is applied to. |
| `search_contains` | bool | false | Match search terms anywhere in a word, not just the start. |
| `disable_search` | bool | false | Never show the search box. |
| `allow_single_deselect` | bool | false | Allow clearing a single select. |
| `allow_mobile` | bool | false | Enable Chosen on mobile devices. |
| `add_helper_buttons` | bool | false | Add "select all"/"none" buttons on multi-selects. |
| `placeholder_text_multiple` | label | `Choose some options` | Placeholder for multi-selects. |
| `placeholder_text_single` | label | `Choose an option` | Placeholder for single selects. |
| `no_results_text` | label | `No results match` | Shown when a search has no matches. |
| `max_shown_results` | int | null | Cap results shown (perf for huge selects). |
| `disabled_themes` | sequence<string> | `{}` | Themes for which Chosen styling is disabled. |
| `chosen_include` | int | 2 | Where Chosen runs: admin only / front end only / both. |
