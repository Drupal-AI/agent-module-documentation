# OpenAI Content tools (node form)

Enabled by adding the `access openai content tools` permission. The tools appear as `details`
groups in the node form's advanced/sidebar (`hook_form_node_form_alter()` in
`openai_content.module`). Each has a `#type => button` with an `#ajax` callback that reads a
selected field, cleans it via `StringHelper::prepareText()`, and calls `openai.api`.

| Tool (form group) | AJAX callback | API call | Result |
|---|---|---|---|
| **Analyze text** | `openai_content_entity_analyze_content` | `openai.api->moderation()` | Lists possible content-policy violations for the chosen field. |
| **Adjust content tone** | `openai_content_entity_adjust_tone` | `chat()`/`completions()` | Rewrites the field text for a selected tone/audience (tone options are hardcoded). |
| **Summarize** | `openai_content_entity_field_summarize` | `chat()`/`completions()` | Returns a summary of the chosen field. |
| **Suggest title** | `openai_content_suggest_title` | `chat()`/`completions()` | Proposes a title from the content. |
| **Suggest taxonomy** | `openai_content_entity_suggest_taxonomy` | `chat()`/`completions()` | Suggests taxonomy terms for the content. |

Notes:
- The field to operate on is chosen from a `select` of the entity's text/summary fields
  (`openai_content_get_all_text_with_summary_fields()`).
- Output is injected into a response `<div>` in the form (e.g. `#openai-moderate-response`,
  `#openai-tone-edit-response`); the editor copies/accepts manually.
- There is **no settings form** — behavior (tones, models) is currently in code.
- All calls go through the parent `openai.api` service and require its configured API key.
