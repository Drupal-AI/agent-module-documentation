<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Node Translate Amazon provider adds Amazon Translate (AWS) as a machine-translation backend for the Auto Node Translate module, so node field content is translated through the AWS Translate API instead of another engine.

---

Auto Node Translate handles the Drupal side of automatic node translation — which fields to translate, when to trigger it, and how to save the result — and delegates the actual translating to a provider plugin. This module supplies the AWS one: `AmazonTranslator`, an `AutoNodeTranslateProvider` plugin (id `auto_node_translate_amazon`, label "Amazon"), plus a settings form at `/admin/config/regional/amazon` for the AWS access key, secret and region. The plugin builds an `Aws\Translate\TranslateClient` from the official `aws/aws-sdk-php` library and calls `translateText()` once per string, passing the Drupal source and target langcodes straight through as the AWS `SourceLanguageCode`/`TargetLanguageCode`. On an AWS error it shows the error message and returns the original text so translation degrades gracefully. Once configured, choose "Amazon" as the default provider in Auto Node Translate's own settings (`auto_node_translate.settings:default_api`). The module is deliberately small — one plugin plus a three-field settings form — because everything else about the translation workflow belongs to the parent module.

---

- Machine-translate node content with Amazon Translate.
- Reuse an existing AWS account to power Drupal translations.
- Offer Amazon as an alternative to DeepL, Google, LibreTranslate or MyMemory backends.
- Translate node fields into multiple target languages automatically.
- Keep translation spend on an existing AWS bill.
- Pick an AWS region to meet data-residency requirements.
- Bulk-translate a backlog of existing content.
- Produce first-pass machine translations for editors to review.
- Translate on node save via Auto Node Translate's triggers.
- Use Amazon on one site while other sites use a different provider.
- Store the AWS key, secret and region in one settings form.
- Translate only the fields the parent module is configured to handle.
- Support the source/target language codes Amazon Translate accepts.
- Reduce manual translation effort for high-volume, multilingual sites.
- Provide translations for a multilingual intranet or portal.
- Switch translation engines without changing the content workflow.
- Compare translation quality across providers.
- Automate translation as part of an editorial publishing flow.
- Translate imported or migrated content automatically.
- Keep the AWS-specific integration isolated in a single plugin.
