<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Place & configure the Copyright Footer block

The module has **no admin settings page** (`configure: null`). All configuration lives on the
block instance you place through the normal Block layout UI.

## Place it

- UI: *Structure → Block layout* (`/admin/structure/block`), click **Place block** in the
  target region (usually Footer), choose **Copyright Footer** (block id `copyright_footer`,
  listed under category "Custom").
- The block label is hidden by default (`label_display` = FALSE).

## Settings keys

Stored in the block config entity under `settings` (schema `block.settings.copyright_footer`):

| Key | Type | Meaning |
|---|---|---|
| `organization_name` | label | Text shown after the year (e.g. company name). Blank = omitted. |
| `organization_url` | uri | If set, `organization_name` renders as a link to this URL. |
| `year_origin` | integer | Start year. Blank or equal to current year → single-year output. |
| `year_to_date` | integer | End year. Blank → current year is used. |
| `version` | string | If set, appends `ver.<version>`. Blank = omitted. |
| `version_url` | uri | If set (and `version` is set), the version string links here. |

## Output logic (`build()`)

- Current year is computed with PHP `\DateTime` on every render, so it is always up to date.
- `year_origin` empty **or** `year_origin === currentYear` → `Copyright © <year> <org> <version>`.
- Otherwise → `Copyright © <year_origin>-<year_to_date> <org> <version>` where an empty
  `year_to_date` falls back to the current year.
- `version` renders as `ver.<version>`; with `version_url` the number becomes a link.
  `version_url` is ignored when `version` is empty.

## Scriptable placement (drush php:eval)

```php
$block = \Drupal\block\Entity\Block::create([
  'id' => 'copyrightfooter',
  'plugin' => 'copyright_footer',
  'region' => 'footer',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'settings' => [
    'id' => 'copyright_footer',
    'label' => 'Copyright Footer',
    'label_display' => FALSE,
    'organization_name' => 'Acme Corp',
    'organization_url' => 'https://example.com',
    'year_origin' => 2010,
    'year_to_date' => '',
    'version' => '',
    'version_url' => '',
  ],
]);
$block->save();
```

## Read it back

```bash
drush cget block.block.copyrightfooter settings
# or list placed copyright blocks:
drush config:status ; drush cget block.block.copyrightfooter settings.organization_name
```
