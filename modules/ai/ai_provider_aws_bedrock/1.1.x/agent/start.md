<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS Bedrock Provider (ai_provider_aws_bedrock) — agent index

Registers **AWS Bedrock** as a provider for the Drupal **AI** module, so any AI feature can route
`chat`, `embeddings` and `text_to_image` requests to Bedrock foundation models (Anthropic Claude,
Amazon Titan, Meta Llama, Mistral, Cohere, AI21, Stable Diffusion). Calls go through the
`aws/aws-sdk-php` BedrockRuntime/Bedrock clients.

- Requires modules `ai:ai`, `key:key`, `aws:aws`; library `aws/aws-sdk-php ^3.316`.
- Core `^10.3 || ^11`. Release documented: **1.1.0-beta4** (branch has no stable; all `1.1.x` are beta).
- Configure route: `ai_provider_aws_bedrock.settings_form` → `/admin/config/ai/providers/aws_bedrock`
  (permission `administer ai providers`, defined by the `ai` module).
- No own permissions, no drush commands, no hooks. Provides the `bedrock` AI-provider plugin.

Authentication is **not** stored here: the settings form only selects an `aws_profile` config
entity (owned by the `aws` module); that profile holds the AWS credentials. This module keeps a
single string, the chosen profile id.

Solutions:
- **Select the AWS profile / choose models / toggles** → [configure/settings.md](configure/settings.md)
- **Use / extend the `bedrock` provider plugin (operations, model families, raw SDK clients)** → [api/provider.md](api/provider.md)

Key facts:
- Config object: `ai_provider_aws_bedrock.settings` — keys `profile`, `moderation`, `on_demand`,
  `chat_manual_models`, `embeddings_manual_models`, `text_to_image_manual_models`.
- Plugin: `\Drupal\ai_provider_aws_bedrock\Plugin\AiProvider\BedrockProvider`, id `bedrock`,
  attribute `#[AiProvider]`, base `AiProviderClientBase`.
- Supported operation types: `chat`, `embeddings`, `text_to_image` (`getSupportedOperationTypes()`).
- Uses `aws.client_factory` (service `\Drupal\aws\AwsClientFactoryInterface`) to build the
  `bedrock` and `bedrockruntime` SDK clients; model list cached under tag `aws_bedrock_models`.
- Model definitions live in `definitions/api_defaults.yml`; per-family handlers in
  `src/Models/{Chat,Embeddings,TextToImage}/*`.
