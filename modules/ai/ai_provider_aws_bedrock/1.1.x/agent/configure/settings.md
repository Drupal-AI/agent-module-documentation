<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — AWS Bedrock provider settings

Form `\Drupal\ai_provider_aws_bedrock\Form\BedrockConfigForm` (`ConfigFormBase`), form id
`bedrock_settings`, route `ai_provider_aws_bedrock.settings_form` at
`/admin/config/ai/providers/aws_bedrock`. Access: permission `administer ai providers` (defined by
the `ai` module). Menu link `ai_provider_aws_bedrock.settings_menu` lives under `ai.admin_providers`.

## Credentials are NOT entered here

The form does not accept an AWS access key or secret. It renders a **select** listing every
`aws_profile` entity (via `entity_type.manager` → storage `aws_profile`, from the `drupal/aws`
module). If none exist it shows a link to `aws.overview` and stops. You create/hold the actual AWS
credentials in the AWS module's profile (the AWS module can source them from the Key module and the
project recommends encrypting the profile with the Encrypt module). This module persists only the
selected profile **id** string.

## Config object `ai_provider_aws_bedrock.settings`

| Key | Type | Form widget | Default | Meaning |
|-----|------|-------------|---------|---------|
| `profile` | string | select (required) | `''` | Machine id of the `aws_profile` entity used to authenticate. |
| `on_demand` | boolean | checkbox | `true` | When true, only models supporting `ON_DEMAND` inference are listed. Uncheck to include provisioned models. |
| `moderation` | boolean | (not on form; config/schema only) | `false` | Run a moderation call before each request. Toggled at runtime via `enableModeration()` / `disableModeration()`; read from config when unset. |
| `chat_manual_models` | string | textarea (Advanced) | `''` | Newline-separated model ids appended to the discovered chat model list. |
| `embeddings_manual_models` | string | textarea (Advanced) | `''` | Newline-separated model ids appended to the embeddings list. |
| `text_to_image_manual_models` | string | textarea (Advanced) | `''` | Newline-separated model ids appended to the text-to-image list. |

Manual-model fields exist because AWS IAM can grant run access without list access; ids added here
bypass the `listFoundationModels` discovery. Schema: `config/schema/ai_provider_aws_bedrock.schema.yml`;
install defaults: `config/install/ai_provider_aws_bedrock.settings.yml`.

## On submit

`submitForm()` saves all six values, then invalidates cache: if the backend implements
`CacheTagsInvalidatorInterface` it invalidates tag `aws_bedrock_models`, else it calls
`deleteAll()`. This is what refreshes the cached model list after a settings change.

## Set without the UI

Drush:

```
drush config:set ai_provider_aws_bedrock.settings profile my_profile_id
drush config:set ai_provider_aws_bedrock.settings on_demand 1
```

PHP:

```php
\Drupal::configFactory()->getEditable('ai_provider_aws_bedrock.settings')
  ->set('profile', 'my_profile_id')
  ->set('on_demand', TRUE)
  ->set('chat_manual_models', "anthropic.claude-3-5-sonnet-20240620-v1:0")
  ->save();
\Drupal::service('cache.default')->invalidateTags(['aws_bedrock_models']);
```

`profile` must match an existing `aws_profile` entity id; the provider reports itself unusable
(`isUsable()` returns FALSE) while `profile` is empty.
