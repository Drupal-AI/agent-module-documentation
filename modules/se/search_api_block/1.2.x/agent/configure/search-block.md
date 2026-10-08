<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Search API form block

There is **no admin settings page** (`configure: null`). You configure the module by
**placing the block** `search_api_form_block` and filling its settings, which are stored on
the block config entity `block.block.<id>` under `settings`.

## Prerequisite

You need an existing **Search API view page** with an exposed keyword filter (or any page
that accepts the keyword as a query parameter). The block only *submits to* that page; it
runs no search of its own. Note the page path (e.g. `/search`) and the machine name of the
exposed filter (default core name is `keys`).

## Settings keys (schema `block.settings.search_api_form_block`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `action_url` | string (required) | `''` | The Search page path the form submits to, e.g. `/search`. Must start with `/`. Supports tokens. Labelled "Search page" in the UI. |
| `action_method` | `get`\|`post` | `get` | Form submit method. `get` puts the keyword in the URL query string. |
| `input_name` | string | `''` (falls back to `keys`) | Name of the search input = the exposed filter's machine name. |
| `input_placeholder` | label | `''` | Placeholder text. Supports tokens. |
| `submit_value` | label | `''` (falls back to "Search") | Submit button label. Supports tokens. |
| `input_label` | label | `''` (falls back to "Search") | The input's title/label. Supports tokens. |
| `input_label_visibility` | string | `invisible` | `invisible`\|`before`\|`after`\|`attribute`. |
| `pass_get_params` | boolean | `FALSE` | If TRUE, existing GET params in `action_url` are re-emitted as hidden fields so they survive submission. |

`blockValidate()` rejects an `action_url` that does not start with `/` (after token
replacement): "The path '%path' has to start with a slash."

## Place via the UI

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in a region, find **Search API form**, click **Place block**.
3. Fill **Search page** (e.g. `/search`), **Submit method**, **Input name** (e.g. `keys`).
4. Optionally open **Customization** for label, label visibility, placeholder, submit label.
5. Tick **Pass GET parameters** if the target path already carries query params to preserve.
6. **Save block**.

## Place / configure via drush php:eval (scriptable)

```php
use Drupal\block\Entity\Block;
$theme = \Drupal::config('system.theme')->get('default');
Block::create([
  'id' => 'my_search',
  'plugin' => 'search_api_form_block',
  'region' => 'content',
  'theme' => $theme,
  'settings' => [
    'id' => 'search_api_form_block',
    'label' => 'Site search',
    'label_display' => '0',
    'action_url' => '/search',
    'action_method' => 'get',
    'input_name' => 'keys',
    'input_placeholder' => 'Search…',
    'submit_value' => 'Go',
    'input_label' => 'Search',
    'input_label_visibility' => 'invisible',
    'pass_get_params' => FALSE,
  ],
])->save();
```

## Read it back

```bash
drush cget block.block.my_search settings
# settings.action_url, settings.input_name, settings.action_method, settings.pass_get_params …
```

Or in PHP: `Block::load('my_search')->get('settings')['action_url']`.
