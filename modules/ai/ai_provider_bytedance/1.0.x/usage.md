Adds ByteDance ModelArk (Volcengine/BytePlus) as a selectable AI provider for the Drupal AI module, exposing its chat and image models to Field UI, Actions, Views and custom code.

---

AI Provider ByteDance implements a single `bytedance` provider plugin on top of the AI module's OpenAI-compatible base client, so ByteDance ModelArk models become available wherever the AI framework offers a provider/model dropdown. It supports three operation types — chat (Skylark Pro, DeepSeek V3, Kimi K2, GPT-OSS, Skylark Vision), text-to-image and image-to-image (Seedream 4.0 / 4.5) — and translates ByteDance-specific request options such as thinking mode, reasoning effort, image size, seed, watermark, sequential image generation and prompt optimization. Chat handles plain-text and multimodal (image) messages plus function/tool calls and streaming. The API key is held in a Key entity, the ModelArk endpoint defaults to the BytePlus Southeast Asia host but can be overridden, and ModelArk error responses are mapped onto the AI module's rate-limit, quota and unsafe-prompt exceptions. Configuration lives in the `ai_provider_bytedance.settings` config object and is edited from an admin form gated by the `administer ai providers` permission.

---

- Use ByteDance Skylark Pro or DeepSeek V3 as the default chat model for AI-assisted content authoring.
- Generate images from a text prompt with Seedream 4.0 / 4.5 through the AI module's text-to-image operation.
- Transform an existing image into a new one (image-to-image) with a Seedream model.
- Provide multimodal chat: send an image alongside a text prompt to Skylark Vision.
- Enable ByteDance "thinking" / deep-reasoning mode for supported chat models.
- Tune reasoning effort (minimal/low/medium/high) for reasoning-capable models.
- Store the ByteDance API key securely in a Key entity rather than plaintext config.
- Point the provider at a regional or self-managed ModelArk-compatible endpoint by overriding the base URL.
- Seed default models for chat and image operations automatically on save.
- Control image output size with presets (1K/2K/4K) or a custom resolution.
- Add or suppress the ByteDance watermark on generated images.
- Set a fixed seed for reproducible image generation.
- Use sequential image generation for Seedream 4 multi-image output.
- Apply ByteDance prompt-optimization modes (standard/fast) to image prompts.
- Drive function calling / tools from chat requests routed through ByteDance.
- Stream chat responses token-by-token for responsive UIs.
- Let AI Automators or Actions call ByteDance models without writing an API client.
- Export the provider configuration through Drupal configuration management.
- Cap chat output with a max-tokens limit and adjust temperature / top-p sampling.
- Surface ModelArk rate-limit and quota conditions as standard AI exceptions for graceful handling.
- Validate the API key and endpoint reachability at save time via a live model listing.
- Offer ByteDance models as a lower-cost or region-specific alternative to other AI providers on the same site.
