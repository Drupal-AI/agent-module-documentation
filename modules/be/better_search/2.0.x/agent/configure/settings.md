<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Better Search

Settings form: `/admin/config/search/better-search` (route `better_search_settings`,
`BetterSearchSettingsForm`, a `ConfigFormBase`). Permission:
`administer Better Search settings`. All values are stored in one config object,
**`better_search.settings`**.

## Config keys (defaults from `config/install/better_search.settings.yml`)

| Key | Default | Meaning |
|---|---|---|
| `placeholder_text` | `search` | Placeholder shown in the search input |
| `theme` | `0` | Animation style, integer 0–3 (see theming/styles.md) |
| `size` | `20` | `#size` of the input (form option list 10–30) |
| `searchpage_enable` | `true` | Also restyle the core search-results page form (`search_form`) |
| `searchpage_submit_not_visible` | `true` | Add `visually-hidden` to the submit button on search pages |
| `input_name` | `keys` | The search field's array key in the form |
| `block_form_id` | `search_block_form` | The form id the alter targets (besides `search_form`) |

`input_name` and `block_form_id` are under an "Advanced settings" details element — change them
to make the styling apply to a custom or contrib search form.

## Read / write with drush

```bash
drush cget better_search.settings
drush cset better_search.settings theme 1 -y            # switch to Expand on Hover
drush cset better_search.settings placeholder_text 'Search this site…' -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('better_search.settings')
  ->set('theme', 2)->set('size', 24)->save();
```

## How it is applied

`better_search_form_alter()` runs on every form; it only acts when `$form_id` equals the
configured `block_form_id` **or** `search_form`. When it matches it:

1. attaches the CSS library for the chosen `theme`,
2. injects `<div class="icon"><i class="better_search"></i></div>` as a `#prefix` (or `#suffix`
   for `theme` 3) on the `input_name` element,
3. sets the `placeholder` attribute and `#size`,
4. hides the submit button (`visually-hidden`; Bootstrap-aware).

For the search-results page (`search_form`) the same happens under the `basic` form key, only
when `searchpage_enable` is true, with submit hidden when `searchpage_submit_not_visible` is true.

There is **no config schema** shipped, so values are stored as-is (note `theme`/`size` are
integers).
