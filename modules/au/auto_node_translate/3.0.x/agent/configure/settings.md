<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Auto Node Translate

Two admin forms (both require permission `configure auto node translate`, both `_admin_route`):

| Route | Path | Form | Config object |
|---|---|---|---|
| `auto_node_translate.settings` | `/admin/config/regional/auto-node-translate-settings` | `SettingsForm` | `auto_node_translate.settings` |
| `auto_node_translate.my_memory_settings` | `/admin/config/regional/my-memory` | `MyMemorySettingsForm` | `auto_node_translate.my_memory_settings` |

Sources: `src/Form/SettingsForm.php`, `src/Form/MyMemorySettingsForm.php`,
`auto_node_translate.routing.yml`. The module ships **no** `config/install` defaults or schema.

## `auto_node_translate.settings`

| Key | Widget | Meaning |
|---|---|---|
| `default_api` | select | Machine id of the provider plugin to use (options are all `@AutoNodeTranslateProvider` definitions; default bundled option `auto_node_translate_mymemory`). |
| `moderation_state` | radios | Only shown if `content_moderation` is installed. One of `AutoNodeTranslateInterface` constants: use the source node's state, `draft`, or `published`. |

## `auto_node_translate.my_memory_settings`

| Key | Widget | Meaning |
|---|---|---|
| `mm_email` | email | Optional. Sent as `&de=<email>` to MyMemory to raise the free quota (docs say ~1000 → ~10000 words). Purely additive; the API host is fixed in code and not configurable here. |

## Set via Drush

```bash
ddev drush cset auto_node_translate.settings default_api auto_node_translate_mymemory -y
ddev drush cset auto_node_translate.settings moderation_state draft -y
ddev drush cset auto_node_translate.my_memory_settings mm_email you@example.com -y
```

## Using it

1. Enable languages + `content_translation`, and make the content type translatable.
2. Grant the per-bundle `auto translate <bundle> node` permission (see
   [../permissions/permissions.md](../permissions/permissions.md)).
3. On the node's **Translate** tab (or the content list operations) use **Auto Translate** →
   the `TranslationForm` lists target languages; submit to generate translations via the
   configured provider (`Translator::translateNode`, see [../api/translator.md](../api/translator.md)).
