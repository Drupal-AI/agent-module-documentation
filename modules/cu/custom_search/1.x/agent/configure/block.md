# The Custom Search block

Block plugin id **`custom_search`** (`CustomSearchBlock`). Place it via **Structure → Block
layout → Place block → "Custom Search"**, or in code. Its configuration lives in the block
config entity under `settings` (schema `block.settings.custom_search`).

## Settings groups

- **`search_box`** — the text input: `label_visibility` (bool), `label`, `placeholder`,
  `title` (hint), `size` (int), `max_length` (int), plus `weight`/`region`.
- **`submit`** — the button: `text`, `image_path` (use an image instead of a text button),
  `weight`/`region`.
- **`content`** — content-type selector: `page` (which search page to submit to), `types`
  (allowed content types), a `selector` (`type` = select/checkboxes, `label`,
  `label_visibility`), an `any` option (`text`, `restricts`, `force`), `excluded` types,
  `weight`/`region`.
- **`taxonomy`** — one or more taxonomy selectors: each has `type` (selector type), `depth`,
  `label`, `all_text` ("- Any -" text), `weight`/`region`.
- **`criteria`** — extra query criteria toggles: `or`, `phrase`, `negative`, each with
  `display` (bool), `label`, `weight`/`region`.
- **`searchapi`** — `page`: a Search API page id to submit to (route to Search API instead of
  core search).
- **`languages`** — language selector settings.

## Example (place a scoped block with drush/PHP)

```php
use Drupal\block\Entity\Block;
Block::create([
  'id' => 'custom_search_news',
  'plugin' => 'custom_search',
  'region' => 'content',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'settings' => [
    'id' => 'custom_search',
    'label' => 'Search news',
    'search_box' => ['label_visibility' => FALSE, 'placeholder' => 'Search news…', 'size' => 30, 'max_length' => 128],
    'content' => [
      'types' => ['article' => 'article'],   // limit to Articles
      'selector' => ['type' => 'select', 'label_visibility' => TRUE, 'label' => 'Type'],
    ],
  ],
])->save();
```

The visitor's chosen content types / taxonomy terms / criteria are appended to the search
query when they submit, narrowing the core (or Search API) search.
