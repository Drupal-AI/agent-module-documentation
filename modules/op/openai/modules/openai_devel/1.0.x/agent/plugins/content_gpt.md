# DevelGenerate plugin: `content_gpt`

`\Drupal\openai_devel\Plugin\DevelGenerate\ContentGPTDevelGenerate` extends core Devel Generate's
`ContentDevelGenerate`. It replaces the sample-value logic so node titles and string/text fields
are written by an OpenAI chat model instead of random Latin. Not a new plugin *type* — it is one
plugin of `devel_generate`'s existing `DevelGenerate` type.

Annotation (relevant parts):

    id = "content_gpt"
    label = "content from ChatGPT"
    url = "content-gpt"              // UI: /admin/config/development/generate/content-gpt
    permission = "administer devel_generate"
    settings = { num = 15, kill = FALSE, max_comments = 0, add_type_label = FALSE }
    dependencies = { "node" }

## Extra settings-form fields (added to the standard Devel Generate form)

| Field | Key | Default | Notes |
|-------|-----|---------|-------|
| Model | `model` | `gpt-3.5-turbo` | Options from `openai.api` `filterModels(['gpt'])`. |
| Profile (system prompt) | `system` | "Your task is to generate content…" | Required. Sent as the `system` role message. |
| Temperature | `temperature` | `0.4` | 0–2. |
| Max tokens | `max_tokens` | `512` | Min 128. Validated per model (gpt-4 ≤ 8192, gpt-3.5-turbo ≤ 4096, gpt-3.5-turbo-16k ≤ 16384). |
| HTML formatted | `html` | `FALSE` | Ask GPT for basic HTML in long-text fields. |
| Base fields | `base_fields` | — | Required, comma-separated. Only these string/text fields are filled by GPT. |

`title_length` is removed; `base_fields` is forced required.

## How it generates (runtime)

Per node, in `develGenerateContentAddNode()`:
1. Builds a `messages` array: the `system` profile, then a `user` message asking for a title
   ("Give me an example title for a/an `<node_type>` page … less than 200 characters."). Subsequent
   nodes ask for a "completely different title" reusing the accumulating conversation.
2. `$this->api->chat($model, $messages, $temperature, $max_tokens)` → title (surrounding `"` stripped).
3. Creates the node, then `populateGptFields()` fills fields.

`ContentGPTDevelGenerate::populateGptFields()` (static; resolves `\Drupal::service('openai.api')`):
- Only these field types are GPT-populated **and only if the field name is in `base_fields`**:
  `string`, `string_long`, `text`, `text_long`, `text_with_summary`. Every other field (and base
  fields not requested) is filled with `generateSampleItems()` as usual.
- For each eligible field it appends a `user` message ("Provide content for a page … titled
  `<title>`…"; asks for "basic HTML markup" when `html` is set on a `text_long`/`text_with_summary`
  field), calls `chat()`, and stores the reply as the field value plus an `assistant` message so the
  running conversation stays coherent.

## Notes for integrators

- Each node consumes multiple chat calls (title + one per eligible field) against the parent's OpenAI
  API key; large `num` values run many requests.
- Drush entry point mirrors the UI — see [../drush/commands.md](../drush/commands.md); its
  `validateDrushParams()` enforces the same model/token/temperature limits.
