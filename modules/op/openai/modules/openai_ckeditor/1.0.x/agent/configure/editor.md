# Configure the OpenAI CKEditor plugin

## Enable per text format
1. Go to *Configuration → Content authoring → Text formats and editors*
   (`admin/config/content/formats`) and edit a CKEditor 5 format.
2. Drag the **OpenAI** button into the active toolbar.
3. In the plugin's settings (`buildConfigurationForm`), enable **Text completion** and set the
   model. The `completion` group controls the completion, translate, tone, and summary actions.

Default configuration (`defaultConfiguration()`):
```
completion:
  enabled: FALSE
  model: gpt-3.5-turbo
```
Stored in the editor's settings; schema `config/schema/openai_ckeditor.schema.yml`.

## The completion endpoint
- Route `openai_ckeditor.generate_completion`, **POST** `/api/openai-ckeditor/completion`
  (this is the module's `configure` route value).
- Permission **`use openai ckeditor`** — grant to editor roles. This is a non-admin permission;
  holders can send arbitrary prompts (and the model name) to OpenAI at the site's API cost, so
  grant it deliberately.
- Controller `Completion::generate(Request $request)`:
  - Body: `{"prompt": "...", "options": {"model": "...", "temperature": n, "max_tokens": n}}`.
  - If `options.model` contains `gpt` → `openai.api->chat($model, $messages, …, stream=TRUE)`
    with a system message: *"You are an expert in content editing… return all answers without
    using first, second, or third person voice."* Else → `openai.api->completions(…, stream=TRUE)`.
  - Response is streamed back into the editor.

## Requirements
- `ckeditor5`, and the parent `openai` API key configured.
- The plugin JS lives in `openai_ckeditor.libraries.yml`; the CKEditor 5 definition in
  `openai_ckeditor.ckeditor5.yml`.
