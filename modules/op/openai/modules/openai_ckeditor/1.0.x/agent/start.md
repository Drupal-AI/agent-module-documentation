# OpenAI CKEditor integration (openai_ckeditor) — agent index

CKEditor 5 plugin + streaming completion endpoint that generates/rewrites text in the editor,
over the parent `openai.api` service. Requires `ckeditor5`. Parent:
[../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

- **Enable the plugin per format, its settings, the endpoint & controller** → [configure/editor.md](configure/editor.md)

Key facts:
- CKEditor plugin `\Drupal\openai_ckeditor\Plugin\CKEditor5Plugin\OpenAI` (config
  `openai_ckeditor.ckeditor5.yml`, schema `openai_ckeditor.schema.yml`); default completion
  model `gpt-3.5-turbo`.
- Endpoint route `openai_ckeditor.generate_completion` (**POST**)
  `/api/openai-ckeditor/completion` (the `configure` route), controller
  `\Drupal\openai_ckeditor\Controller\Completion::generate`, permission
  **`use openai ckeditor`** (grantable to editor roles; NOT admin-only).
- Controller reads `{prompt, options:{model, temperature, max_tokens}}` from the request body;
  `chat()` if model contains `gpt` (adds a system "content editor" message), else
  `completions()`; response is **streamed**.
- Generation is server-side, so the API key stays on the server. Requires the parent's API key.
