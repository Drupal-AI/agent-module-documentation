<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create, manage & place simple blocks

Simple blocks are **config entities** (`simple_block`). Each has a machine `id`, a `title`, and
formatted `content`.

## The config entity shape

Config object: `simple_block.simple_block.<id>`

```yaml
id: promo_notice
title: 'Promo notice'
content:
  value: '<p>Welcome to [site:name]!</p>'
  format: full_html
```

`config_export` is exactly `id`, `title`, `content`. `getContent()` defaults to
`['value' => '', 'format' => filter_default_format()]` when empty.

## Via the UI

Admin UI: **`/admin/structure/block/simple-block`** (route `entity.simple_block.collection`,
title "Simple blocks"). Needs `administer blocks`.

- **Add simple block** (`simple_block.form_add`, `/admin/structure/block/simple-block/add`):
  enter **Title**, an auto-generated **Internal name** (machine id), and **Content** (a
  formatted text area; "Global tokens are allowed").
- **Edit** / **Clone** / **Delete** actions per row (routes `entity.simple_block.edit_form`,
  `entity.simple_block.clone_form`, `entity.simple_block.delete_form`).

## Via drush / PHP

```php
\Drupal\simple_block\Entity\SimpleBlock::create([
  'id' => 'promo_notice',
  'title' => 'Promo notice',
  'content' => ['value' => '<p>Welcome to [site:name]!</p>', 'format' => 'full_html'],
])->save();
```

Read it back:

```bash
drush cget simple_block.simple_block.promo_notice
drush config:status | grep simple_block         # see it as exportable config
```

## Placing the block

Each simple block is exposed as a **derived block plugin** `simple_block:<id>` (category
"Simple block"). Place it like any block:

- Block layout (`/admin/structure/block`) → *Place block* → find your block by title.
- Or in code/config, a `block` config entity with `plugin: 'simple_block:promo_notice'`.

The rendered output is the block's `content.value` run through its `format`, with **global
tokens** replaced (e.g. `[site:name]`). If the referenced entity is missing, users with
`administer blocks` see an "add simple block" hint instead.

## Tokens

Content is passed through `\Drupal::token()->replace()`, so **global** tokens (site, current
user, date, etc.) work. There is no entity context, so entity-specific tokens won't resolve.

## Deployment

Because these are config entities, `drush config:export` writes
`simple_block.simple_block.<id>.yml` into your config sync directory; commit and deploy like any
config. (Saving a block clears the block plugin cache so its derivative updates.)
