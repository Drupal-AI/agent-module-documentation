OpenAI CKEditor integration adds a CKEditor 5 plugin that lets editors highlight text and prompt OpenAI to generate, translate, adjust tone of, or summarize content directly in the editor, streamed back from a controller endpoint over the core `openai.api` service.

---

The submodule provides a CKEditor 5 plugin (`Plugin/CKEditor5Plugin/OpenAI`) configured per
text format's toolbar, and a POST endpoint `openai_ckeditor.generate_completion` at
`/api/openai-ckeditor/completion` (the module's `configure` route) handled by the `Completion`
controller, guarded by the module's own permission `use openai ckeditor`. The plugin's
configuration form exposes a **completion** action (enable flag, model default `gpt-3.5-turbo`,
etc.) stored in the editor settings (schema `openai_ckeditor.schema.yml`). At runtime the
plugin POSTs `{prompt, options:{model, temperature, max_tokens}}`; the controller picks
`chat()` when the model id contains `gpt` (wrapping the prompt with an "expert content editor"
system message) or `completions()` otherwise, and **streams** the result back into the editor.
Requires ckeditor5, the OpenAI API key on the parent, and the permission granted to editor
roles.

---

- Generate text from a prompt without leaving CKEditor.
- Rewrite selected text to adjust its tone.
- Translate selected content inline.
- Summarize a passage inside the editor.
- Continue/expand a draft with AI suggestions.
- Stream long completions progressively into the editor.
- Configure the default model per text format.
- Enable the completion action only on chosen formats/toolbars.
- Give editor roles AI assistance via the `use openai ckeditor` permission.
- Speed up drafting of body content.
- Fix or rephrase awkward sentences with AI.
- Produce alternate phrasings for marketing copy.
- Draft intros/conclusions from a short prompt.
- Keep AI generation server-side (API key never exposed to the browser).
- Tune temperature/max-tokens via the plugin settings.
- Integrate AI writing help into existing WYSIWYG workflows.
- Prototype editorial AI prompts in a real editor.
- Provide consistent AI tooling across content types using CKEditor 5.
