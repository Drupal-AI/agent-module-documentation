AI Content Suggestions adds LLM-powered editorial helpers (summary, title, tone, readability, moderation, taxonomy tagging, per-field prompts) to content entity edit forms, driven entirely through the AI module's provider abstraction.

---

The module alters every content entity edit form (node, taxonomy term, block content, or any bundle you enable) to add a set of AI-assist tools for editors who hold the "Access AI Content Suggestions tools" permission. Each tool is a plugin of the module's own `AiContentSuggestions` plugin type: the editor picks which text/string fields to send, clicks a button, and the module runs an AJAX chat (or moderation) call against the model chosen for that plugin and renders the answer back inline on the form — without ever saving anything. Separately, it registers a Field Widget Actions plugin (`prompt_content_suggestion`) so a per-field "AI suggestions" button can be attached to any string/text widget on a form display, using a token-aware prompt and returning selectable suggestions in a modal. All model selection, keys and HTTP go through `drupal/ai` (`ai.provider`), so the module holds no credentials and makes no direct external calls. A settings form under Configuration → AI → AI Content Suggestions enables plugins, sets per-plugin prompts/models, defines which entity types and bundles are eligible, and sets the shared system prompt for field-widget suggestions.

---

- Give reviewers/editors a "Summarize" button on the node form that generates a ~130-word summary of selected body fields.
- Generate an SEO-friendly title suggestion (10 words or less) from the body content.
- Rewrite selected content into a chosen tone: Friendly, Professional, Helpful, high-school level, college level, or "explain like I'm 5".
- Drive tone options from a custom taxonomy vocabulary instead of the built-in list (Tone plugin, "Choose own vocabulary" option).
- Score readability with a Flesch score plus one-sentence interpretation and a bullet list of improvement suggestions.
- Moderate draft content against the AI provider's content-policy categories before publishing, surfacing which policies it may violate.
- Suggest up to five taxonomy tags from free-form generation, or constrain suggestions to terms of an existing vocabulary.
- Respect a source vocabulary's full hierarchy when suggesting tags, returning a nested multilevel list of leaf-node terms.
- Add a per-field "AI suggestions" button to any string/text widget via Field Widget Actions and a custom prompt.
- Use entity tokens (e.g. `[node:field_name]`) inside a per-field prompt so the model sees specific field values; otherwise the full entity is rendered to markdown and appended.
- Enable AI suggestions for only specific content types (mode "Only those selected") or for all bundles except a chosen few (mode "All except those selected").
- Enable the tools on non-node entities such as taxonomy terms and custom blocks.
- Pin a specific model per suggestion plugin, or fall back to the site's default provider/model for the chat/moderation operation.
- Customize each plugin's prompt text from the settings form to match your editorial voice.
- Customize the shared field-widget system prompt that instructs the LLM to return RFC8259 JSON suggestions.
- Restrict who sees any AI tool by granting the "Access AI Content Suggestions tools" permission to specific roles only.
- Expose content-suggestion tooling to AI agents through the `content_suggestions` AI function group.
- Send several fields at once (including paragraph subfields via entity-reference-revisions) as a single combined prompt input.
- Offer suggestion buttons that appear only when a field is focused (display-on-focus option) to reduce form clutter.
- Let editors pick which of the available fields feed the LLM per request using the multi-select "target fields" control.
- Keep confidential-content governance in your hands by choosing per entity type/bundle where AI tools are exposed.
