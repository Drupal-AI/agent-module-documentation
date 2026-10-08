<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Editor Actions adds an "AI Actions" dropdown to CKEditor 5 that runs user-defined AI text transformations on the selected text or the whole document, inserting each result as a tracked, revertable change.

---

AI Editor Actions builds on the `drupal/ai` provider abstraction to bring AI-assisted editing into CKEditor 5 and, optionally, plain-text fields and any on-page text selection. The transformations are content: each is an `ai_editor_action` content entity (label + instruction + optional provider/model, category and shared roles) that a permitted user creates right from the editor and keeps private or shares with selected roles. Enabled actions appear grouped by category in the "AI Actions" toolbar dropdown alongside a free-form "Ask AI…" instruction and a read-only "Explain this" insight. Generation runs through the module's own JSON endpoints (`/ai-editor-actions/transform`, `/explain`, `/transcribe`, `/catalog`) which are permission-gated, CSRF-header-guarded and subject to a configurable per-user hourly flood limit; results are normalized to clean HTML for the editor (or plain text for plain fields) and rendered as a tracked change with a review toolbar (previous/next, show original, regenerate, tweak, discard, keep). Optional speech-to-text voice input transcribes a recorded clip when a `speech_to_text` provider is configured. Administrators set input caps, the rate limit, the system/explain prompts, the explain and voice models, and the beyond-the-editor toggles at `/admin/config/ai/editor-actions/settings`.

---

- Add an "AI Actions" button to a text format's CKEditor 5 toolbar so editors can transform selected text with AI.
- Let editors rephrase, fix grammar/spelling, or simplify a selection in place.
- Shorten or expand a passage to roughly half or double its length without inventing facts.
- Summarize a selection into a short paragraph or pull out key points as a bulleted list.
- Rewrite text in a professional or friendly tone.
- Translate selected text to Spanish, French, German or any language you write an action for.
- Run a free-form one-off instruction with "Ask AI…" without creating a saved action.
- Give editors an "Explain this" insight that describes a selection (or the whole document) in a read-only balloon without changing content.
- Let users build their own private library of AI actions from the editor ("Add Action…").
- Share selected actions with specific roles while keeping others private to their owner.
- Group actions into categories that become submenus in the dropdown.
- Run an action on the entire editor content when nothing is selected (whole-document mode).
- Review every AI result as a tracked change and step through its regeneration history before keeping it.
- Regenerate, tweak (add a follow-up instruction), discard or keep a pending AI change.
- Offer the same AI Actions experience on plain textfields and textareas outside CKEditor.
- Add an "Explain any selection" widget so highlighting any text on a page (help text, descriptions) offers an explanation.
- Dictate an "Ask AI" or "Tweak" prompt by voice when a speech-to-text model is configured.
- Cap the number of characters sent to the model and truncate longer selections automatically.
- Enforce a per-user hourly limit on AI requests to control provider spend.
- Choose a specific provider/model per action, or fall back to the site default chat model.
- Set separate models for the "Explain this" insight and for voice transcription.
- Customize the system prompt used for transformations and the prompt used for explanations.
- Toggle structured-output (well-formed HTML) generation with a plain-text fallback for models that lack it.
- Extend the "Explain this" output with custom block/span renderers and schema via the module's alter hooks.
