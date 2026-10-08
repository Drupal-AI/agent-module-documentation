<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom patterns — the `styleguide_pattern` config entity

Custom styleguide entries are `styleguide_pattern` **config entities** (`ConfigEntityType`,
`config_prefix: styleguide_pattern`, `admin_permission: administer style guide`). Config names:
`simple_styleguide.styleguide_pattern.<id>`.

## Fields (config_export)

| Field | Type | Notes |
|---|---|---|
| `id` | string (machine name) | entity id, `simple_styleguide.styleguide_pattern.<id>` |
| `label` | string | admin label |
| `pattern` | string | **raw HTML** rendered in the styleguide |
| `description` | blob/text | rich-text (full_html) note; stored as `{value, format}` from the form |
| `weight` | integer | draggable order on the collection + on the styleguide page |

## Manage in the UI

- Collection (draggable list): `/admin/config/styleguide/patterns`
  (route `entity.styleguide_pattern.collection`).
- Add: local action "Add styleguide pattern" → `/admin/config/styleguide/patterns/add`
  (`entity.styleguide_pattern.add_form`). Fill Label, Description (rich text), Pattern (raw
  HTML), and the machine-name id.
- Edit / Delete: `…/patterns/{id}/edit`, `…/patterns/{id}/delete`.
- New patterns are auto-assigned `weight = max(existing) + 1` (added at the bottom).

All of these require the **`administer style guide`** permission.

## Create programmatically / via config

```php
use Drupal\simple_styleguide\Entity\StyleguidePattern;
StyleguidePattern::create([
  'id' => 'card',
  'label' => 'Card',
  'pattern' => '<div class="card"><h3>Title</h3><p>Body</p></div>',
  'description' => ['value' => '<p>Use for teasers.</p>', 'format' => 'full_html'],
  'weight' => 0,
])->save();
```

Read back / inspect:

```bash
drush config:get simple_styleguide.styleguide_pattern.card
drush config:status        # shows it as exportable config
```

Because these are config entities they export with `drush config:export` and deploy across
environments like any other config. On the `/simple-styleguide` page each custom pattern is
rendered via the `simple_styleguide_pattern` theme hook (see theming/templates.md), sorted by
`weight`.
