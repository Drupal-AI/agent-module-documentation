<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# disable_language — API

## The manager service

`disable_language.disable_language_manager` — class
`Drupal\disable_language\DisableLanguageManager` (extends core `ConfigurableLanguageManager`).
It reads the third-party `disable` flag off every `configurable_language` entity. Key methods:

| Method | Returns | Notes |
|---|---|---|
| `getConfigurableLanguages()` | `configurable_language[]` keyed by langcode | all languages as config entities (the entity that owns the flag) |
| `getDisabledLanguages()` | `configurable_language[]` keyed by langcode | only those with `disable == 1` |
| `getEnabledLanguages()` | `configurable_language[]` keyed by langcode | those with the flag off/absent |
| `isCurrentLanguageDisabled()` | `bool` | is the request's current language disabled |
| `getFirstEnabledLanguage()` | `LanguageInterface` | first non-disabled language |
| `getFallbackLanguage()` | langcode `string`\|`FALSE` | the current language's `redirect_language`, if it is disabled |

```php
$mgr = \Drupal::service('disable_language.disable_language_manager');
$disabled = $mgr->getDisabledLanguages();        // ['de' => ConfigurableLanguage, ...]
$codes    = array_keys($disabled);               // ['de']
```

## Reading / writing the flag directly (no service)

The flag is a third-party setting on the `configurable_language` entity — read or write it with the
standard entity API:

```php
$lang = \Drupal::entityTypeManager()->getStorage('configurable_language')->load('de');
$isDisabled = (bool) $lang->getThirdPartySetting('disable_language', 'disable');
$redirect   = $lang->getThirdPartySetting('disable_language', 'redirect_language');

// Disable it:
$lang->setThirdPartySetting('disable_language', 'disable', TRUE);
$lang->setThirdPartySetting('disable_language', 'redirect_language', 'en');
$lang->save();

// Enable it (module convention: unset, don't set FALSE):
$lang->unsetThirdPartySetting('disable_language', 'disable');
$lang->unsetThirdPartySetting('disable_language', 'redirect_language');
$lang->save();
```

## Hooks the module implements (behaviour surface)

These are core hooks the module *responds to* — useful to know what it touches, not APIs you call:

- `hook_form_alter` — adds the **Disable language** checkbox + redirect select to
  `language_admin_edit_form`, and the **Disabled** column to `language_admin_overview_form`;
  an entity builder saves the flag.
- `hook_language_switch_links_alter` — removes disabled languages from the switcher for users
  lacking `view disabled languages`.
- `hook_simple_sitemap_links_alter` — strips disabled-language `loc` and `alternate_urls` from
  Simple XML Sitemap output.
- `hook_page_attachments_alter` — removes disabled-language `hreflang` head links.
- `hook_field_widget_single_element_language_select_form_alter` — removes disabled languages from
  content-form language selects for users lacking `create content in disabled language`.

Front-end redirection of disabled-language requests is handled by
`Drupal\disable_language\EventSubscriber\DisabledLanguagesEventSubscriber` (a kernel-request
subscriber), honouring `redirect_override_routes` and the `exclude_request_path` condition from
`disable_language.settings`.
