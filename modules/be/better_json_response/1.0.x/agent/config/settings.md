<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — deactivate cache

One admin form, one boolean. Source: `src/Form/BetterJsonResponseConfigForm.php`
(`extends ConfigFormBase`).

- **Route** `better_json_response.form.config` → path `admin/config/development/better_json_response`
  (`better_json_response.routing.yml`), title *"Better Json Response configuration"*, requirement
  `_permission: 'administer site configuration'`. Menu link under *Configuration → Development*
  (`better_json_response.links.menu.yml`, parent `system.admin_config_development`).
- **Form id** `better_json_reponse_config_form` (`FORM_ID`). Editable config
  (`getEditableConfigNames()`) = `better_json_reponse.settings` (`CONFIG_NAME`). Note the
  misspelled machine name — `reponse`, no second "s" — in both the constant and the install file
  `config/install/better_json_reponse.settings.yml`.

## The setting

| Key | Type | Default | Effect |
| --- | --- | --- | --- |
| `deactivate_cache` | checkbox / int | `0` | When truthy, `SubResourceResponseSubscriber::onResponse()` emits a plain `JsonResponse` instead of `CacheableJsonResponse` for every `BetterJsonResponse` — i.e. turns off render caching of these responses site-wide. Meant for debugging headless endpoints. |

`buildForm()` renders the single checkbox (default from
`config('better_json_reponse.settings')->get('deactivate_cache')`); `submitForm()` writes the
value back and saves.

## Operate it

```bash
# Read / set via drush
drush config:get  better_json_reponse.settings
drush config:set  better_json_reponse.settings deactivate_cache 1   # disable cache (debug)
drush config:set  better_json_reponse.settings deactivate_cache 0   # re-enable cache
drush cr
```

Changing the value invalidates already-cached responses because the subscriber tags cacheable
responses with `config:better_json_reponse.settings`.

## Caveats

- There is **no `config/schema/`** for this config object — the module ships only the
  `config/install` default. Config export/import works, but there is no typed-data schema, so
  expect the usual "schema missing" notice in strict/test setups. Only `deactivate_cache` exists.
