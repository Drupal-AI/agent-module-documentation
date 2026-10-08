<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Account ID & project entities

## Account ID — config `optimizely.settings`

- Form: route **`optimizely.settings`** → `/admin/config/system/optimizely/settings`
  (`AccountSettingsForm`), permission `administer optimizely`.
- Stores `optimizely.settings:optimizely_id` (integer, your Optimizely **account ID**) via the
  `AccountId` helper. Read/write:

```bash
drush cget optimizely.settings optimizely_id
drush cset optimizely.settings optimizely_id 123456 -y
```

Saving the form also refreshes caches for the paths of all enabled projects.

## Projects — config entity type `optimizely`

Each experiment target is a config entity `optimizely.optimizely.<id>` (schema
`optimizely.optimizely.*`). Fields:

| Field | Type | Meaning |
|---|---|---|
| `id` | string | machine id |
| `label` | label | human name |
| `code` | integer | Optimizely **project/experiment code** → snippet `//cdn.optimizely.com/js/<code>.js` |
| `state` | boolean | enabled (only enabled projects load) |
| `paths` | string | newline-separated path patterns; `*` = wildcard, `*` alone = sitewide |

The shipped **`default`** project (`optimizely.optimizely.default`, `paths: '*'`, `code: 0`) is
sitewide and **cannot be deleted** — only disabled.

Manage via the UI (all under `administer optimizely`):

| Route | Path |
|---|---|
| `entity.optimizely.collection` | `/admin/config/system/optimizely` (list) |
| `entity.optimizely.add_form` | `/admin/config/system/optimizely/add` |
| `entity.optimizely.edit_form` | `/admin/config/system/optimizely/{optimizely}` |
| `entity.optimizely.delete_form` | `/admin/config/system/optimizely/{optimizely}/delete` |

### Scriptable example

```php
\Drupal::entityTypeManager()->getStorage('optimizely')->create([
  'id' => 'homepage_test',
  'label' => 'Homepage test',
  'code' => 987654,
  'state' => TRUE,
  'paths' => "/node/1\r\n/blog/*",   // newline-separated patterns
])->save();
```

Read back: `drush cget optimizely.optimizely.homepage_test`. Toggle: set `state` false to disable.

## How the snippet loads

`hook_page_attachments()` loads all projects with `state = TRUE`, then for the current request
matches the internal path **and** its URL alias against each project's `paths` (via
`optimizely.lookuppath` / `optimizely.pathchecker`). On a match it appends
`<script src="//cdn.optimizely.com/js/<code>.js">` to `#attached['html_head']` and tags the page
with cache tag `optimizely:<path>`. `*` matches sitewide; trailing `*` matches a prefix.
