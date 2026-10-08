<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The autocompletion_configuration entity

Config entity type `autocompletion_configuration` (class `AutocompletionConfiguration`), stored as
`search_autocomplete.autocompletion_configuration.<id>`. Admin UI (the `configure` route
`autocompletion_configuration.list`) at `/admin/config/search/search_autocomplete` — an entity list
with Add / Edit / Delete.

## Fields (config_export)

| Key | Meaning |
|---|---|
| `id`, `label` | Machine name / human label. |
| `selector` | **CSS selector** of the input field to autocomplete (e.g. `#edit-keys`). Empty for the search block config, which targets it specially. |
| `status` | Enabled (autocompletion active). |
| `minChar` | Characters typed before suggestions appear. |
| `autoSubmit` | Submit the form automatically when a suggestion is chosen. |
| `autoRedirect` | Redirect to the suggestion's URL when chosen. |
| `maxSuggestions` | Max suggestions displayed. |
| `noResultLabel` / `noResultValue` / `noResultLink` | Custom "no results" message + optional link. `[search-phrase]` is substituted. |
| `moreResultsLabel` / `moreResultsValue` / `moreResultsLink` | Custom "view all results" entry. |
| `source` | Suggestion source: either a callback URI, or `view_id::display_id` (resolved to the view path + exposed filters). |
| `theme` | CSS filename for the dropdown theme (e.g. `basic.css`). |
| `editable` / `deletable` | Whether this config may be edited / deleted in the UI. |

## Shipped defaults (enabled on install)

| id | selector | source |
|---|---|---|
| `search_block` | `''` | `autocompletion_callbacks_nodes::nodes_autocompletion_callback` |
| `search_form_content` | (content search) | `autocompletion_callbacks_words::words_autocompletion_callback` |
| `search_form_users` | (user search) | `autocompletion_callbacks_users::users_autocompletion_callback` |

Backed by the optional views `autocompletion_callbacks_nodes`, `autocompletion_callbacks_users`,
`autocompletion_callbacks_words`.

## Create via drush php:eval

```php
$storage = \Drupal::entityTypeManager()->getStorage('autocompletion_configuration');
$storage->create([
  'id' => 'my_search', 'label' => 'My Search',
  'selector' => '#edit-keys', 'status' => TRUE,
  'minChar' => 3, 'maxSuggestions' => 10,
  'source' => 'autocompletion_callbacks_nodes::nodes_autocompletion_callback',
  'theme' => 'basic.css', 'editable' => TRUE, 'deletable' => TRUE,
])->save();
```

Read: `drush cget search_autocomplete.autocompletion_configuration.my_search`, or
`->getSelector()` / `->getSource()` / `->getStatus()` on the loaded entity.

## Module settings

`search_autocomplete.settings:admin_helper` (boolean, default `FALSE`) — enables an in-page helper tool
that lets you build a configuration by clicking a field on the site.
