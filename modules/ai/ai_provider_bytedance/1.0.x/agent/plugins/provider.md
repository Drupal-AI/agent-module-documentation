<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ByteDance provider plugin

`src/Plugin/AiProvider/ByteDanceProvider.php` — `#[AiProvider(id: 'bytedance', label: 'ByteDance ModelArk')]`,
extends `Drupal\ai\Base\OpenAiBasedProviderClientBase`, implements `ImageToImageInterface`,
uses `ChatTrait` + `ImageToImageTrait`. HTTP transport, auth headers and TLS come from the AI
module base client (the module adds no HTTP client of its own).

## Operations & models

`getSupportedOperationTypes()` → `chat`, `text_to_image`, `image_to_image`.

`getModels($operation_type, $capabilities)` returns a hard-coded catalogue:
- chat: `skylark-pro-250415` (Skylark Pro), `deepseek-v3`, `kimi-k2-250711`,
  `gpt-oss-120b-250805`, `skylark-vision-250515`.
- text_to_image / image_to_image: `seedream-4-0-250828`, `seedream-4-5-251128`.

`getConfiguredModels()` calls `loadClient()` then `getModels()`. `getSetupData()` declares
`key_config_name => 'api_key'` and default models (chat `skylark-pro-250415`, both image ops
`seedream-4-5-251128`).

## Per-model settings

`getModelSettings($model_id, $generalConfig)` augments the AI framework's generic config:
- chat models: defaults `max_tokens=4096`, `temperature=1`, `top_p=0.7`, plus select widgets for
  `thinking` (enabled/disabled, default disabled) and `reasoning_effort`
  (minimal/low/medium/high, default medium).
- Seedream image models: default `size=2048x2048`, removes the `size` options constraint (allows
  custom resolutions), and enables `seed`, `watermark`, `sequential_image_generation`,
  `optimize_prompt_options`.

Baseline request parameters for each operation are declared in `definitions/api_defaults.yml`
(max_tokens, temperature, top_p, thinking, reasoning_effort; image n/size/seed/watermark/
sequential_image_generation/optimize_prompt_options).

## Endpoint

`loadClient()`: if `ai_provider_bytedance.settings:host` is empty it calls
`setEndpoint('https://ark.ap-southeast.bytepluses.com/api/v3')`, otherwise it uses the configured
host, then calls `parent::loadClient()` (wrapping any `AiSetupFailureException` with a ByteDance
message). The endpoint is admin-set config, not request-supplied.

## chat()

Normalizes a `ChatInput` into OpenAI-style `messages`: optional system role from
`$this->chatSystemRole`, each message as `{role, content:[{type:text,text}]}`, appending
`{type:image_url, image_url:{url:<data URL>, detail:auto}}` for `ImageFile` files/images.
Tool responses set `tool_call_id`; prior tool calls set `tool_calls`. Payload =
`{model, messages} + $this->configuration`; adds `tools` (with `function.strict=FALSE`),
`response_format`, and a `thinking:{type:…}` object when configured. Streaming uses
`client->chat()->createStreamed()` with `OpenAiTypeStreamedChatMessageIterator`; a Fiber path
streams and suspends; the non-streamed path builds a `ChatMessage` and `ToolsFunctionOutput[]`.
Errors containing "Request too large"/"Too Many Requests" → `AiRateLimitException`,
"exceeded your current quota" → `AiQuotaException`, "Sensitive Information" →
`AiUnsafePromptException`, else `AiRequestErrorException`. Token usage set via
`setChatTokenUsage()` for non-streamed, non-Fiber responses.

## textToImage() / imageToImage()

Build a payload `{model, prompt, size, n, response_format:'url'}` plus optional
`seed`/`watermark` (cast to bool), `sequential_image_generation`, and
`optimize_prompt_options` wrapped as `{mode:<value>}`. imageToImage additionally passes the
input image as a base64 string and defaults the prompt to "Generate an image based on the input."
Call `client->images()->create($payload)->toArray()`; results are read from `b64_json`
(base64-decoded) or `url` (fetched) into `ImageFile('image/png','seedream.png')`. Missing data
throws `AiResponseErrorException`; imageToImage maps "Sensitive Information" →
`AiUnsafePromptException` and "RPM/TPM Limit Exceeded" → `AiRateLimitException`.
