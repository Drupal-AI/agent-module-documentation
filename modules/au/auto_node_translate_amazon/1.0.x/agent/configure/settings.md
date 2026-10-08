<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Amazon Translate credentials

Route `auto_node_translate_amazon.settings` → `/admin/config/regional/amazon`, permission
`administer site configuration`. Form `Drupal\auto_node_translate_amazon\Form\SettingsForm`
(form id `auto_node_translate_amazon_settings`). The menu link parents
`auto_node_translate.translators`, so the page sits under Auto Node Translate's translators group.
All three fields are `#required`.

## Config object `auto_node_translate_amazon.settings`

| Key | Form field | Element type | Passed to AWS as | Purpose |
| --- | --- | --- | --- | --- |
| `amazon_translate_key` | Api Key | `textfield` | `credentials.key` | AWS access key ID |
| `amazon_translate_secret` | Secret | `password` | `credentials.secret` | AWS secret access key |
| `amazon_translate_region` | Region | `textfield` | `region` | AWS region, e.g. `eu-west-1` |

No `config/install` default and no `config/schema` ship with the module, so the object exists only
after the form is first saved, and its keys are untyped for config export / translation tooling.
Because `Secret` is a `password` element, re-saving the form re-submits the value each time.

## Set without the UI

drush:

```bash
drush config:set auto_node_translate_amazon.settings amazon_translate_key    AKIAEXAMPLE -y
drush config:set auto_node_translate_amazon.settings amazon_translate_secret 'your-secret' -y
drush config:set auto_node_translate_amazon.settings amazon_translate_region eu-west-1 -y
```

PHP (e.g. sourcing values from the environment):

```php
\Drupal::configFactory()->getEditable('auto_node_translate_amazon.settings')
  ->set('amazon_translate_key', getenv('AWS_ACCESS_KEY_ID'))
  ->set('amazon_translate_secret', getenv('AWS_SECRET_ACCESS_KEY'))
  ->set('amazon_translate_region', 'eu-west-1')
  ->save();
```

These three keys are the only values the plugin reads. The AWS SDK client is built from them in
`AmazonTranslator::__construct()` with `version => 'latest'`; see
[../plugins/provider.md](../plugins/provider.md).

## Make Amazon the active translation backend

This module only registers the backend; it does not enable itself. Select it in the parent module
at `/admin/config/regional/auto-node-translate-settings` (config
`auto_node_translate.settings:default_api` = `auto_node_translate_amazon`). Parent settings docs:
[../../../../auto_node_translate/3.0.x/agent/configure/settings.md](../../../../auto_node_translate/3.0.x/agent/configure/settings.md).
