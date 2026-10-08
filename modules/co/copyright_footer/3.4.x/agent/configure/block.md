<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Place & configure the Copyright Footer block

The module has **no admin settings page** (`configure: null`). All configuration lives on the
block instance you place through the normal Block layout UI. Class:
`Drupal\copyright_footer\Plugin\Block\CopyrightFooter` (implements `CopyrightFooterInterface`).

## Place it

- UI: *Structure → Block layout* (`/admin/structure/block`), click **Place block** in the target
  region (usually Footer), choose **Copyright Footer** (block id `copyright_footer`, category
  "Custom").
- The block label is hidden by default (`label_display` = FALSE, from `defaultConfiguration()`).

## Configuration form

![Copyright Footer block configuration form](../../../../../../../screenshots/copyright_footer/3.4.x/config-form.png)

`blockForm()` renders these fields; values are stored in the block config entity under `settings`
(schema `block.settings.copyright_footer`):

| Key | Form #type | Meaning |
|---|---|---|
| `organization_name` | textfield (label) | Text shown after the year. Blank = omitted. |
| `organization_url` | url (uri, nullable) | If set, `organization_name` renders as a link. |
| `year_origin` | textfield, maxlength 4 | Start year. Blank or equal to current year → single-year output. |
| `year_to_date` | textfield, maxlength 4 | End year. Blank → current year is used. |
| `version` | textfield | If set, appends `ver.<version>`. Blank = omitted. |
| `version_url` | url (uri, nullable) | If set (and `version` is set), the version links here; ignored when `version` is empty. |
| `all_rights_reserved_position` | radios | `none` (do not display) / `organization` (after org name) / `version` (after the version). Constants on `CopyrightFooterInterface`. |
| `copyright_format` | textfield, maxlength 512 | Optional custom token format; blank = default translated output. |

`all_rights_reserved` (boolean) exists only in the schema as a deprecated back-compat setting;
`getAllRightsReservedPosition()` maps a legacy truthy value to `organization` until the block is
re-saved, after which `blockSubmit()` `unset()`s it.

## Validation (`blockValidate` / `validateConfigurationForm`)

- Year fields are trimmed; each must match `^\d{4}$` (4 digits) if non-empty.
- `year_origin` must be ≤ `year_to_date` when both are valid.
- `organization_url` and `version_url` must be valid absolute URIs (`UrlHelper::isValid($url, TRUE)`).
- `copyright_format` may only use the supported tokens; any other bracketed `[token]` is rejected
  with an "Unsupported token(s)" error (`findUnsupportedTokens()`).

## Output logic (`build()`)

- Current year = request time formatted `Y` in the **site timezone** (`system.date` →
  `timezone.default`), so rollover is correct per region and never needs editing.
- `year_origin` empty **or** `year_origin === currentYear` → single year; otherwise
  `year_origin-year_to_date` range (empty `year_to_date` → current year).
- Default (no `copyright_format`): `t('Copyright © @year @organization @version', …)` or the range
  variant. When `organization_url`/`version_url` are set, the org/version text is wrapped with
  `Link::fromTextAndUrl()` (URL built via `buildSafeUrl()` → `Url::fromUri()` after
  `UrlHelper::isValid`). `version` renders as `ver.<version>`.
- "All Rights Reserved." is appended via `appendAllRightsReserved()` after the org name or version
  per `all_rights_reserved_position`.
- Custom format: `buildCustomFormat()` splits the string on `[token]` boundaries, substitutes the
  supported tokens, and emits each piece as `#markup` (safe generated links) or `#plain_text`
  (escaped literal text). Tokens: `[copyright]`=©, `[year]`=single year or range,
  `[start-year]`, `[end-year]`, `[organization-name]`, `[version]`.

## Caching (`getCacheMaxAge()`)

- Both `year_origin` and `year_to_date` set → `Cache::PERMANENT`.
- Otherwise → `min(parent max-age, seconds until the next site-local Jan 1)` so the auto-year
  refreshes when the year changes.

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
    'year_origin' => '2010',
    'year_to_date' => '',
    'version' => '',
    'version_url' => NULL,
    'all_rights_reserved_position' => 'organization',
    'copyright_format' => '',
  ],
]);
$block->save();
```

## Read it back

```bash
drush cget block.block.copyrightfooter settings
drush cget block.block.copyrightfooter settings.organization_name
```
