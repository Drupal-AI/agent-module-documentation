<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AWS Bedrock Provider registers Amazon Bedrock as a provider for Drupal's AI module, so any AI feature can run its chat, embeddings and text-to-image work against Bedrock foundation models — Anthropic Claude, Amazon Titan, Meta Llama, Mistral, Cohere, AI21 and Stable Diffusion — without a feature caring which model backs it.

---

The AI module abstracts providers so a feature written against it works with whichever model a site configures; this module supplies the Bedrock one via `aws/aws-sdk-php ^3.316`. It authenticates by reusing an AWS "profile" from the Amazon Web Services (`aws`) module rather than asking for keys itself: the settings form at `/admin/config/ai/providers/aws_bedrock` (permission `administer ai providers`) only selects an existing `aws_profile` entity, and the module stores just that profile's id. Because Bedrock runs inside the site's own AWS account, model usage falls under the account's existing IAM policies, billing and region choices, which is often what makes an AI feature approvable for organisations already standardised on AWS. Model discovery queries `listFoundationModels` and can be narrowed to on-demand models or widened with manually listed model ids (useful when IAM grants run-but-not-list access); the discovered list is cached and refreshed on save. The plugin supports chat (Converse API, streaming, tool calling, image input), text and image embeddings, and text-to-image. The documented release is 1.1.0-beta4; requirements are core `^10.3 || ^11` with `ai`, `key` and `aws`.

---

- Back Drupal AI features with AWS Bedrock foundation models.
- Use Anthropic Claude models through Bedrock.
- Use Amazon Titan text, embedding and image models.
- Use Meta Llama, Mistral, Cohere or AI21 chat models.
- Generate images with Stable Diffusion XL or Titan Image Generator.
- Produce text embeddings for a vector search index.
- Produce image embeddings with Titan multimodal embeddings.
- Keep AI traffic inside an existing AWS account and region.
- Reuse an AWS module profile (access keys or assumed IAM role) for auth.
- Apply AWS IAM policies and billing to model usage.
- Switch the backing model without changing the AI feature.
- Run streaming chat responses from Bedrock.
- Call Bedrock tools / function calling from an agent.
- Send images into a Claude 3 vision chat.
- Restrict the model picker to on-demand models only.
- Add a provisioned or otherwise unlisted model by id manually.
- Combine Bedrock with other AI providers on the same site.
- Meet a data-residency requirement for AI processing.
- Run an optional moderation pass before each request.
- Hot-swap the AWS profile per call for multi-account setups.
- Reach the raw BedrockRuntime SDK client from custom code.
- Use Bedrock for summarisation, translation or classification.
