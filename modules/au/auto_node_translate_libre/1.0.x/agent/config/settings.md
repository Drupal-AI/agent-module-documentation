<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — LibreTranslate endpoint & API key

## Install / enable

1. Requires the parent module: `composer require drupal/auto_node_translate:^3.0`
   (this module's `composer.json`). Enable both:
   `drush en auto_node_translate auto_node_translate_libre`.
2. In Auto Node Translate's own settings, select **Libre** as the active translation provider
   (the parent module chooses which `@AutoNodeTranslateProvider` plugin to use).

## The settings form

- Route: **`auto_node_translate_libre.settings`** → **`/admin/config/regional/libre`**
  (`auto_node_translate_libre.routing.yml`).
- Permission: **`administer site configuration`**.
- Menu: link `auto_node_translate_libre.settings` (title *"Libre translator settings"*) under
  parent menu `auto_node_translate.translators`, weight 10
  (`auto_node_translate_libre.links.menu.yml`).
- Form class: `Drupal\auto_node_translate_libre\Form\SettingsForm` (a `ConfigFormBase`,
  form id `auto_node_translate_libre_settings`). Standard config-form CSRF/token handling
  applies.

## Config object `auto_node_translate_libre.settings`

Editable config name from `getEditableConfigNames()`. Two keys, both plain `textfield`,
`#maxlength 256`, `#required TRUE`:

| Key | Form title | Meaning |
| --- | --- | --- |
| `libretranslate_url` | *Url* | LibreTranslate base URL, e.g. `https://libretranslate.com/`. A trailing `/` is stripped at runtime (`rtrim(...,'/')`); `/languages` and `/translate` are appended. |
| `libretranslate_apikey` | *Api Key* | LibreTranslate API key, sent as the `api_key` POST param on every `/translate` call. |

There is **no `config/install` default and no `config/schema`** in the module, so the object
is created empty by the form on first save and is untyped configuration.

### Drush / config-set example

```
drush config-set auto_node_translate_libre.settings libretranslate_url https://libretranslate.example.org/
drush config-set auto_node_translate_libre.settings libretranslate_apikey YOUR_KEY
```

## Operating notes

- Both keys are `#required`, so translation will not work until the URL (and a key, if your
  server enforces one) are saved.
- Language codes are reduced to the primary subtag before use (`en-US` → `en`), matching how
  LibreTranslate identifies languages.
- If the configured server rejects the language pair, or is unreachable, the provider messages
  the editor and returns the source text unchanged (see
  [../plugins/libretranslator.md](../plugins/libretranslator.md)).
