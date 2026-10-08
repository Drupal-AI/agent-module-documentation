AI CKEditor integration (the `ai_ckeditor` submodule of AI Core) adds AI assistance to CKEditor 5, letting content editors summarize, translate, retone, spell-fix, reformat, complete or freely prompt text without leaving the WYSIWYG editor.

---

The module ships a CKEditor 5 toolbar button ("AI CKEditor") and an optional contextual balloon menu that appears when text is selected. Both open a modal dialog that presents a list of enabled AI actions; each action is an `AiCKEditor` plugin (a plugin type this module defines under `Plugin/AiCKEditor`, attribute `#[AiCKEditor]`, managed by `plugin.manager.ai_ckeditor`). Nine actions ship in the box: Generate with AI (completion), Modify with a prompt, Summarize, Translate, Tone, Fix spelling, Reformat HTML, and Help. When an editor triggers an action, JavaScript POSTs to the `ai_ckeditor.do_request` route; the `AiRequest` controller builds a `ChatInput`/`ChatMessage`, resolves the provider (either the per-plugin provider chosen in the text-format config or the site default `chat` provider from AI Core), injects the text format's allowed HTML tags into the prompt, and streams the response back into the dialog. Prompt templates for each action live in the `ai_ckeditor.settings` config object and are editable. Which actions are available is configured per text format on the CKEditor 5 toolbar settings form — you drag the AI button into the active toolbar, then enable individual action plugins and optionally pick a provider-model for each. Everything is gated by the single `use ai ckeditor` permission. Because it depends on `ai:ai`, at least one AI provider module must be installed and a default `chat` provider (or per-plugin provider) configured for the actions to actually return text. Tone and Translate additionally depend on the `taxonomy` module (they can source tone/language vocabularies).

---

- Let editors summarize a long selection into a shorter blurb without leaving CKEditor.
- Translate selected text into another language inline (Translate action).
- Rewrite selected text in a different tone (formal, friendly, etc.) with the Tone action.
- Fix spelling and punctuation of a selection without style changes (Fix spelling).
- Reformat pasted markup into clean semantic HTML (Reformat HTML action).
- Generate fresh text or ideas from a free-form prompt (Generate with AI / completion).
- Apply arbitrary custom instructions to a selection (Modify with a prompt action).
- Give editors a contextual balloon menu of AI actions that pops up on text selection.
- Add AI writing help to only specific text formats (e.g. Full HTML) by configuring per-format toolbars.
- Choose a different AI provider/model per action (cheap model for spell-fix, strong model for completion).
- Fall back to the site's default AI Core `chat` provider when no per-action provider is set.
- Restrict AI output to the HTML tags a text format actually allows (automatic tag injection).
- Stream AI responses token-by-token into the dialog for a live "typing" feel.
- Edit the response in a mini rich-text field before saving it back into the main editor.
- Customize the pre-prompt/prompt template for each action via `ai_ckeditor.settings`.
- Gate all AI editor features behind a single `use ai ckeditor` permission for trusted roles.
- Add your own AI editor action by writing an `AiCKEditor` plugin (e.g. "expand", "SEO title").
- Require a contrib/custom module for a custom action via the plugin's `module_dependencies`.
- Provide editors a Help action linking to AI support resources.
- Tune the AI modal dialog size and CSS class per text format (height, width, dialog class).
- Source tone options or translation languages from a taxonomy vocabulary (Tone/Translate).
- Offer a low-friction "ask AI" box for editors unfamiliar with prompt engineering.
- Keep AI text generation inside the editorial workflow instead of a separate tool.
- Reuse AI Core's provider abstraction so switching LLM vendors needs no editor reconfiguration.
- Enforce content-format HTML restrictions on AI-generated markup automatically.
- Let editors regenerate/tweak a response repeatedly before committing it to the body field.
