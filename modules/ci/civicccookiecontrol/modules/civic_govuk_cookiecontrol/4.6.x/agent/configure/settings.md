# Configure GOV.UK Cookie Control text

Form **`\Drupal\civic_govuk_cookiecontrol\Form\CivicGovUkCookieControlSettings`** (form id
`civic_govuk_cookiecontrol_admin_settings`) at `/admin/config/system/cookiecontrol/govuk`
(route `civic_govuk_cookiecontrol.admin_overview`, permission `administer civiccookiecontrol`).

It edits config object **`civic_govuk_cookiecontrol.settings`** — only the fixed GOV.UK-pattern
button/message strings. The category names, descriptions, privacy statement and banner title/intro come
from the **parent** Civic Cookie Control config, not here; on load the form warns (via messenger) if the
parent's privacy node / statement name / statement description are missing.

Config keys (defaults in `config/install/civic_govuk_cookiecontrol.settings.yml`):

| Key | Default |
|---|---|
| `govuk_cookiecontrol_accepted_cookies_text` | "You have accepted cookies" |
| `govuk_cookiecontrol_rejected_cookies_text` | "You have rejected cookies" |
| `govuk_cookiecontrol_change_cookie_settings_prefix` | "You can" |
| `govuk_cookiecontrol_change_cookie_settings_link_text` | "change your cookie settings" |
| `govuk_cookiecontrol_change_cookie_settings_suffix` | "at any time" |
| `govuk_cookiecontrol_hide_button_text` | "Hide" |
| `govuk_cookiecontrol_optional_cookie_text` | "Optional cookie settings" |
| `govuk_cookiecontrol_saved_settings_text` | "Your settings have been saved." |
| `govuk_cookiecontrol_save_and_continue` | "Save and continue" |
| `govuk_cookiecontrol_allow_cookies_question_prefix` | "Can we use" |
| `govuk_cookiecontrol_allow_cookies_question_suffix` | "cookies to help us improve the service?" |

## Translation

Because the pattern targets multilingual DWP services, the module depends on `language` +
`config_translation`. `civic_govuk_cookiecontrol_preload_source_strings()` copies each
`govuk_cookiecontrol_*` value into locale storage as a source string
(`\Drupal\locale\SourceString`) so the strings become translatable through the interface-translation
UI; the blocks then look up the translation for the current language at render time
(`getStringTranslation()->translate(...)` / `localeStorage->getTranslations(...)`).

## Set with PHP

```php
\Drupal::configFactory()->getEditable('civic_govuk_cookiecontrol.settings')
  ->set('govuk_cookiecontrol_hide_button_text', 'Hide')
  ->set('govuk_cookiecontrol_save_and_continue', 'Save and continue')
  ->save();
```
