<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig functions, blocks and templates

## Twig functions (`site_settings.twig_extension`)

All six come from `Drupal\site_settings\Twig\TwigExtension` and are available in every template.

| Function | Signature | Returns |
|---|---|---|
| `site_setting` | `(string $selector, string $view_mode = 'full', ?string $langcode = NULL, bool $check_access = TRUE)` | Render array for one setting, loaded by **entity id or UUID**. |
| `site_settings_by_name` | `(string $type, string $view_mode = 'full', ?string $langcode = NULL, bool $check_access = TRUE)` | Render array for **all** settings of a settings type. |
| `site_settings_by_group` | `(string $group, string $view_mode = 'full', ?string $langcode = NULL, bool $check_access = TRUE)` | Render array for every setting in a group (via the active loader's `loadByGroup()`). |
| `all_site_settings` | `(string $view_mode = 'full', ?string $langcode = NULL, bool $check_access = TRUE)` | Render array for every setting (active loader's `loadAll()`). |
| `site_setting_field` | `(string $name, string $field_name, string $view_mode = 'full', ?string $langcode = NULL, bool $check_access = TRUE)` | Render array for **one field** of the first setting of that type. |
| `site_setting_entity_by_name` | `(string $type, ?string $langcode = NULL, bool $check_access = TRUE)` | The `SiteSettingEntityInterface` **object** (first match), or NULL. |

```twig
{{ site_setting(6) }}
{{ site_setting('8f3c…-uuid', 'teaser') }}
{{ site_settings_by_name('phone_number') }}
{{ site_setting_field('phone_number', 'field_number') }}

{% set footer = site_settings_by_group('Footer settings') %}
{{ footer }}

{% set entity = site_setting_entity_by_name('phone_number') %}
{{ entity.field_number.value }}
```

Translation handling is built in: each function resolves `$langcode` (defaulting to the current
content language) and uses `getTranslation()` when the entity has it. `check_access` defaults to
TRUE and runs `$entity->access('view')`; pass `false` to bypass. Cacheable metadata for every
rendered setting is merged into the returned build.

## The legacy flattened variable

When the active loader is `flattened` **and** `site_settings.config:disable_auto_loading` is
FALSE, `hook_preprocess()` puts the flattened array into the variable named by
`template_key` (default `site_settings`) in **every** template:

```twig
{{ dump(site_settings) }}
{{ site_settings.your_group.your_setting }}
{{ site_settings.your_group.your_setting.field_title }}
{% for s in site_settings.your_group.repeating_setting %}{{ s }}{% endfor %}
```

Note `site_settings_install()` sets `disable_auto_loading: TRUE` and `loader_plugin: full`, so on
a fresh install this variable is **not** present — switch the loader to `flattened` and clear
`disable_auto_loading` if you need it.

## Blocks

| Block plugin id | Admin label | Settings |
|---|---|---|
| `simple_site_settings_block` | Simple site settings block | `setting` (a settings type id) |
| `single_rendered_site_settings_block` | Rendered site settings block | `setting` (type id) + `view_mode` |

Their config schemas are `block.settings.simple_site_settings_block` and
`block.settings.single_rendered_site_settings_block`.

```php
$block = \Drupal\block\Entity\Block::create([
  'id' => 'phone_block', 'plugin' => 'single_rendered_site_settings_block',
  'theme' => \Drupal::theme()->getActiveTheme()->getName(), 'region' => 'footer',
  'settings' => ['id' => 'single_rendered_site_settings_block', 'label' => 'Phone',
                 'setting' => 'phone_number', 'view_mode' => 'default'],
]);
$block->save();
```

## Templates and theme hooks

`site_settings_theme()` registers:

- `site_setting_entity` — template `templates/site_setting_entity.html.twig`, preprocess in
  `site_setting_entity.page.inc`.
- `site_setting_entity_content_add_list` — template
  `templates/site-setting-entity-content-add-list.html.twig`.

`site_settings_theme_suggestions_site_setting_entity()` adds, in order:

```
site_setting_entity__<view_mode>
site_setting_entity__<bundle>
site_setting_entity__<bundle>__<view_mode>
site_setting_entity__<id>
site_setting_entity__<id>__<view_mode>
```

so `site-setting-entity--phone-number--teaser.html.twig` works as expected.

## The teaser override

`site_settings_site_setting_entity_view_alter()` replaces the whole `teaser` build with
`site_settings.simple_teaser`'s `generateTeaser($build)` when
`site_settings.config:simple_summary` is TRUE — that is why the admin listing shows a compact
summary instead of the configured teaser display. Set `simple_summary: false` to get your own
teaser view mode back.

## CSS

`site_settings.libraries.yml` provides `site_settings/navigation_icon`
(`css/navigation_icon.css`), attached by `hook_page_attachments()` only when the core
**navigation** module is enabled and the user has `access navigation`.
