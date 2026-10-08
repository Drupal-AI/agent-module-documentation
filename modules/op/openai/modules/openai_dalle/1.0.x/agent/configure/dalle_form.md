# DALL·E image form

Route `openai_dalle.dalle_form` → `/admin/config/openai/dalle` → `\Drupal\openai_dalle\Form\DalleForm`
(form id `openai_dalle_form`), gated by `_permission: 'access openai dalle'`. There is no config
object — the form takes input, calls OpenAI, and renders/saves the result each submit (AJAX).

## Form fields

| Field | Key | Options / default | Notes |
|-------|-----|-------------------|-------|
| Prompt | `prompt` | required | ≤ 1000 chars for `dall-e-2`, ≤ 4000 for `dall-e-3` (validated). |
| Model | `model` | `filterModels(['dall'])`, default `dall-e-3` | Which DALL·E model. |
| Quality | `quality` | `hd` (default) / `standard` | dall-e-3 only (`#states`). |
| Size | `size` | `256x256`,`512x512`,`1024x1024`,`1792x1024`,`1024x1792` | Validated per model: dall-e-2 ⊂ {256,512,1024 squares}, dall-e-3 ⊂ {1024x1024,1792x1024,1024x1792}. |
| Style | `style` | `vivid` (default) / `natural` | dall-e-3 only. |
| Response Format | `response_format` | `url` (default) / `b64_json` | See below. |
| Filename | `filename` | default `dalle_image` | Required, shown only when format is `b64_json`. |

## Runtime

`submitForm()` calls
`$this->api->images($model, $prompt, $size, $format, $quality, $style)` (the parent
`OpenAIApi::images()`; for non-`dall-e-3` models `quality`/`style` are ignored by the service).

- `response_format = url` → the returned OpenAI image URL is stored and rendered as a "DALL·E result"
  link (`getResponse()` AJAX callback, wrapper `#openai-dalle-response`).
- `response_format = b64_json` → the base64 payload is `base64_decode()`d and written with
  `file_system->saveData($data, 'public://<filename>.png', EXISTS_REPLACE)`; a permanent `File`
  entity is created, owned by the current user, and rendered as a download link.

Errors from the API are swallowed (empty `catch`) and the form simply rebuilds with no result.

## Setting it via code

No stored settings. To generate an image programmatically, call the parent service directly:

    $url = \Drupal::service('openai.api')
      ->images('dall-e-3', 'a red bicycle', '1024x1024', 'url', 'hd', 'vivid');

See the parent service docs: [../../../../../1.0.x/agent/api/service.md](../../../../../1.0.x/agent/api/service.md).
