<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# auto_node_translate_amazon — agent index

Amazon Translate backend for **Auto Node Translate**. Ships one provider plugin
(`AmazonTranslator`, id `auto_node_translate_amazon`) implementing the parent module's
`AutoNodeTranslateProvider` plugin type, plus a settings form holding the AWS access key, secret
and region. It does not decide which fields or nodes to translate — that is the parent module's
job; this module only performs the AWS Translate API call for a single given string.

- Dependencies: `auto_node_translate:auto_node_translate` (module, `^3.0`); `aws/aws-sdk-php ^3.222`
  (Composer, pulls the official AWS SDK for PHP).
- Configure: route `auto_node_translate_amazon.settings` → `/admin/config/regional/amazon`
  (permission `administer site configuration`).
- No permissions of its own, no Drush commands, no config schema shipped, defines no plugin types.

Do:
- **Set the AWS key / secret / region** → [configure/settings.md](configure/settings.md)
- **Understand the AmazonTranslator plugin and how it calls AWS** → [plugins/provider.md](plugins/provider.md)

Key facts:
- Config object `auto_node_translate_amazon.settings` — keys `amazon_translate_key`,
  `amazon_translate_secret`, `amazon_translate_region`.
- Plugin class `Drupal\auto_node_translate_amazon\Plugin\AutoNodeTranslateProvider\AmazonTranslator`;
  annotation id `auto_node_translate_amazon`, label "Amazon".
- Settings form `Drupal\auto_node_translate_amazon\Form\SettingsForm` (form id
  `auto_node_translate_amazon_settings`).
- Route `auto_node_translate_amazon.settings` at `/admin/config/regional/amazon`; menu link parents
  `auto_node_translate.translators`.
- Calls `Aws\Translate\TranslateClient::translateText()` from `aws/aws-sdk-php`.
- Select this backend in the parent at `/admin/config/regional/auto-node-translate-settings`
  (`auto_node_translate.settings:default_api` = `auto_node_translate_amazon`). Parent docs:
  [../../../auto_node_translate/3.0.x/agent/start.md](../../../auto_node_translate/3.0.x/agent/start.md).
