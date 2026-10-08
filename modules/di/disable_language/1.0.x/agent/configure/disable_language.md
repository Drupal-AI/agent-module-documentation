<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure disable_language

## Where "disabled" lives

There is **no dedicated config entity or settings key that lists disabled languages**. Each
language is a `configurable_language` config entity stored at config name
`language.entity.<langcode>` (e.g. `language.entity.de`). Disable Language marks a language by
writing a **third-party setting** onto that entity:

```yaml
# config: language.entity.de
third_party_settings:
  disable_language:
    disable: true            # the language is disabled for the front end
    redirect_language: en    # optional: langcode to redirect disabled-language requests to
```

When you un-disable a language the module *unsets* both keys (the `third_party_settings.disable_language`
block disappears), rather than setting `disable: false`.

## Disable a language from the UI

1. Go to `/admin/config/regional/language` (the language overview). With this module enabled the
   overview grows a **"Disabled"** column (Yes/No per language).
2. Edit a language (`/admin/config/regional/language/edit/<langcode>`). The edit form gains:
   - **Disable language** checkbox → writes `disable`.
   - **Select language to which we redirect** select → writes `redirect_language` (only visible
     when Disable is checked; options are every *other* language).
3. Save, then **clear caches** — the module cannot invalidate its own caches, so changes are not
   reflected until `drush cr`.

Do **not** disable every language (and never the only/ default language) or the redirect logic can
lock you out of the site.

## Disable a language from the command line / config

```bash
# Disable German, redirect its requests to English, then rebuild caches.
drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("configurable_language")->load("de");
  $l->setThirdPartySetting("disable_language", "disable", TRUE);
  $l->setThirdPartySetting("disable_language", "redirect_language", "en");
  $l->save();
'
drush cr

# Re-enable German (remove the flag entirely).
drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("configurable_language")->load("de");
  $l->unsetThirdPartySetting("disable_language", "disable");
  $l->unsetThirdPartySetting("disable_language", "redirect_language");
  $l->save();
'
drush cr

# Inspect current stored value.
drush config:get language.entity.de third_party_settings
```

## Module settings object — `disable_language.settings`

Config UI: **route** `disable_language.disable_language_settings` →
`/admin/config/regional/language/disable_language` (linked as a tab/menu item under the language
overview; requires `access administration pages`). It edits config object `disable_language.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `redirect_override_routes` | sequence of route-name strings | `[user.reset.login, entity.user.edit_form]` | Routes that, when hit in a disabled language, redirect **to themselves in an accessible language** instead of to the front page. Each name is validated against the router on save. |
| `exclude_request_path` | `condition.plugin.request_path` (has `pages`, `negate`) | `pages: ''` | A core request-path condition; matching paths are **excluded** from the disabled-language redirect entirely. |

```bash
drush config:get disable_language.settings
# Add a route to the override allow-list from code:
drush php:eval '
  \Drupal::configFactory()->getEditable("disable_language.settings")
    ->set("redirect_override_routes", ["user.reset.login","entity.user.edit_form","my.custom.route"])
    ->save();
'
drush cr
```

The two default override routes keep the password-reset flow working: without them a reset link
opened in a disabled language would just bounce to the front page.
