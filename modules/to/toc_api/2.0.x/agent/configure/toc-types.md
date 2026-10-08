<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `toc_type` config entity

A TOC's appearance/behaviour is a **config entity** of type `toc_type`
(`Drupal\toc_api\Entity\TocType`, config prefix `toc_api.toc_type.`). Presets are reusable:
code loads one with `TocType::load('<id>')->getOptions()` and hands the options to
`TocManager::create()`.

- **Admin UI:** `/admin/structure/toc` (route `entity.toc_type.collection`, the `configure`
  route). Add/edit/delete at `/admin/structure/toc/add|manage/{id}`.
- **Permission:** `administer table of contents types` (gates the whole collection).
- **Bundled types (config/install):** `default`, `simple`, `simple_numbered`, `full`,
  `full_numbered`.

## `options` keys

| Key | Meaning | Default (`default` type) |
|---|---|---|
| `template` | Which `toc_<template>` theme hook renders it: `tree`, `menu`, `responsive`, `default` | `responsive` |
| `title` | TOC heading text | `Table of Contents` |
| `title_wrapper` / `wrapper` | HTML tag around the title / the whole TOC | `h3` / `div` |
| `block` | Allow rendering in a block (hidden in UI; for submodules) | `false` |
| `header_count` | Min top-level headers before the TOC shows at all | `2` |
| `header_min` / `header_max` | Header level range included (1–6) | `2` / `4` |
| `header_allowed_tags` | Inline tags permitted inside a header/link | `<em> <b> …` |
| `header_id` | Anchor id strategy: `title`, `key`, or `number_path` | `title` |
| `header_id_prefix` | Prefix for `key`/`number_path` ids | `section` |
| `header_exclude_xpath` | XPath of headers to skip | `//*[contains(@class, 'hidden') or @hidden]` |
| `top_min` / `top_max` / `top_label` | Header range that gets a "Back to top" link + its label | `2` / `2` / `Back to top` |
| `number_path` | Show the full numbering path in each header | `true` |
| `number_path_separator` | Separator between path parts | `.` |
| `number_path_truncate` | Drop empty (`0`) leading/trailing path parts | `true` |
| `default.number_type` | List style: `decimal`, `upper-alpha`, `lower-alpha`, `upper-roman`, `lower-roman`, `disc`, `circle`, `square`, `none` | `decimal` |
| `default.number_prefix` / `default.number_suffix` | Text around each number | `''` / `') '` |
| `headers.h1`…`h6` | Per-level overrides of `number_type`/`number_prefix`/`number_suffix` | (empty) |

The schema lives in `config/schema/toc_api.toc_type.schema.yml`; `config_export` is
`id`, `label`, `options`.

## Read a type back

```bash
drush cget toc_api.toc_type.default
drush cget toc_api.toc_type.full_numbered options.default.number_type
```

## Create / edit a type from code (scriptable)

```php
use Drupal\toc_api\Entity\TocType;

TocType::create([
  'id'    => 'sidebar_menu',
  'label' => 'Sidebar menu',
  'options' => [
    'template'     => 'menu',
    'title'        => 'On this page',
    'header_min'   => 2,
    'header_max'   => 3,
    'header_count' => 2,
    'default'      => ['number_type' => 'none', 'number_prefix' => '', 'number_suffix' => ''],
  ],
])->save();
```

Or edit an existing one: `\Drupal::configFactory()->getEditable('toc_api.toc_type.default')
->set('options.template', 'tree')->save();`. Note the UI's save form recomputes `options`
from four detail groups (general/header/top/numbering) and prunes header overrides outside
the `header_min`–`header_max` range or without a "custom" checkbox — so when scripting, write
the full `options` map directly rather than relying on partial merges.
