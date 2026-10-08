<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Automatic Alternative Text (auto_alter) — agent index

Fills an image field's **alt text** from an external vision service when an editor leaves it blank.
Two swappable engines ship as `AutoAlterDescribeImage` plugins: **Azure Cognitive Services**
(`azure_cognitive_services`, admin-supplied endpoint) and **Alttext.ai** (`alttext_ai`, fixed
endpoint `https://alttext.ai/api/v1/images`). Depends on core `image`; core `^9 || ^10 || ^11`.
Optional `key` module for API-key storage. Submodule `auto_alter_translate` translates Azure
output through the Azure Translator API.

Config object `auto_alter.settings`; settings form route `auto_alter.settings`
(`admin/config/media/auto_alter`). No drush commands. Defines the `AutoAlterDescribeImage` plugin type.

- **Configure the engine, API key and behaviour** → [configure/settings.md](configure/settings.md)
- **Configure translation of the generated text (submodule)** → [configure/translate.md](configure/translate.md)
- **Add a new image-description provider** → [plugins/describe_image.md](plugins/describe_image.md)
- **When/what gets described (presave, widgets, CKEditor button)** → [hooks/behavior.md](hooks/behavior.md)
- **Call the description helpers / services from code** → [api/services.md](api/services.md)

Key facts:
- `auto_alter.settings` keys: `engine`, `endpoint`, `credential_provider` (`config`|`key`),
  `credentials.config.api_key`, `credentials.key.api_key_key`, `status`, `suggestion`,
  `alttext_ai_translation_languages`, `alttext_ai_auto_populate_translations`. (`engine` is read
  everywhere but is absent from the config schema.)
- Route access requires the `administer Automatic Alternative Text` permission string. The module
  ships **no** `*.permissions.yml`, so that string is not registered on the Permissions page; in a
  default install only user 1 (or a role that bypasses access) can open the form.
- Plugin type: annotation `@AutoAlterDescribeImage`, manager service
  `plugin.manager.auto_alter_describe_image`, interface
  `Drupal\auto_alter\DescribeImageServiceInterface`, directory `src/Plugin/AutoAlterDescribeImage/`,
  alter hook `auto_alter_describe_image_info`.
- Generation runs only when `suggestion` (or, for new translations,
  `alttext_ai_auto_populate_translations`) is enabled, and only fills **empty** alt values. Images
  over 1 MB are downscaled through the auto-created `auto_alter_help` image style before upload.
- Submodule: config object `auto_alter_translate.settings`; route
  `auto_alter_translate.settings_form` (`admin/config/media/auto_alter/translate`); service
  `auto_alter_translate.get_translation` (`Drupal\auto_alter_translate\AzureTranslate`).
