<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config object

## Form

Class `Drupal\social_media_platforms\Form\SettingsForm` (`src/Form/SettingsForm.php`), extends
`Drupal\Core\Form\ConfigFormBase`.

- Form id: `social_media_platforms_settings`.
- Editable config: `social_media_platforms.settings`.
- Route: `social_media_platforms.settings` → path `/admin/config/services/social-media-platforms`,
  `requirements: _permission: 'administer social media platforms'`.
- Menu link: under `system.admin_config_services` (*Configuration › Web services*), weight 10.

Being a `ConfigFormBase`, submission carries a CSRF form token automatically.

### Display options (fieldset)

Three controls bound to config via `#config_target`:

| Element | `#type` | Config target | Notes |
|---------|---------|---------------|-------|
| Icon type | `select` | `display_options.icon_source` | Options `none` / `image` / `font`; `#required`. |
| Show label | `checkbox` | `display_options.show_label` | |
| Open link in new tab | `checkbox` | `display_options.target_blank` | Adds `target="_blank"` in the template. |

### Platforms table

A `#type => 'table'` with tabledrag weight ordering. Rows are built by reading the existing
`platforms` config, sorting by `weight`, and emitting one row per platform. Columns:

| Column | `#type` | Notes |
|--------|---------|-------|
| Label (required) | `textfield` | `#required`. |
| URL | `url` | Empty allowed; on submit an empty string is stored as `NULL`. |
| Font classes | `textfield` | Only meaningful when icon source is `font`. |
| Weight | `weight` | Drag-sort. |

The platforms table is **not** bound with `#config_target`; `submitForm()` reads
`$form_state->getValue('table')` and writes each row back into the `platforms` map by key
(`label`, `url`, `font_classes`, `weight` as int), then `$config->save()`. **The form only edits
the platform keys already present in config — there is no UI to add or remove a network.**

### Validation (`validateForm()`)

- Must show something: if `show_label` is empty **and** `icon_source == 'none'`, an error is set
  ("You must display at least an icon or a label…").
- Font classes are checked against `preg_match('/[^a-zA-Z0-9\-\_ ]/', …)` — only alphanumerics,
  spaces, hyphens and underscores are allowed (same rule enforced by the config schema `Regex`
  constraint).
- If `icon_source == 'font'`, a warning (not an error) is shown for any platform that has a URL
  but no font classes ("…it will probably not be displayed").
- URL fields inherit core `#type => 'url'` validation → `UrlHelper::isValid($value, TRUE)`, which
  accepts only absolute `http/https/ftp/feed` URLs. `javascript:` and `data:` URLs are rejected.

## Config object

`social_media_platforms.settings` (default in `config/install`, schema in `config/schema`):

```yaml
display_options:
  icon_source: image        # string, AllowedValues: none | image | font
  show_label: true          # boolean
  target_blank: true        # boolean
platforms:                  # sequence, keyed by machine name, orderby key
  facebook:  { label: 'Facebook',  url: null, font_classes: '', weight: 0 }
  youtube:   { label: 'Youtube',   url: null, font_classes: '', weight: 1 }
  linkedin:  { label: 'Linkedin',  url: null, font_classes: '', weight: 2 }
  x:         { label: 'X',         url: null, font_classes: '', weight: 3 }
  instagram: { label: 'Instagram', url: null, font_classes: '', weight: 4 }
  pinterest: { label: 'Pinterest', url: null, font_classes: '', weight: 5 }
  tiktok:    { label: 'TikTok',    url: null, font_classes: '', weight: 6 }
```

Per-platform schema types: `label` → `label`, `url` → `uri`, `font_classes` → `string` (with the
alphanumeric `Regex` constraint), `weight` → `weight`.

All URLs default to `null`, so out of the box the block renders an empty container — you set the
profile URLs to make links appear.

## Install/update hooks (`.install`)

- `social_media_platforms_update_10101()` — adds the `tiktok` platform (label "TikTok",
  weight 6) if missing.
- `social_media_platforms_update_10201()` — migrates the pre-1.1 `display_options.show_icon`
  boolean to `display_options.icon_source` (`true → 'image'`, `false → 'none'`) and adds an empty
  `font_classes` key to every existing platform.

## Setting it programmatically

```php
$config = \Drupal::configFactory()->getEditable('social_media_platforms.settings');
$platforms = $config->get('platforms');
$platforms['facebook']['url'] = 'https://facebook.com/acme';
$platforms['linkedin']['url'] = 'https://linkedin.com/company/acme';
$config->set('platforms', $platforms);
$config->set('display_options.icon_source', 'image');
$config->save();
```

Or export/import the whole object with `drush cex` / `drush cim`. With Domain's `domain_config`,
override this object per domain/language and keep a single placed block.
