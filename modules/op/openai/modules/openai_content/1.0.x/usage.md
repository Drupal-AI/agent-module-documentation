OpenAI Content Editing Tools adds an AI assistant panel to the node edit form (in the "advanced"/sidebar area) with actions to analyze/moderate content, adjust its tone, summarize a field, suggest a title, and suggest taxonomy terms — all powered by the core `openai.api` service.

---

This submodule implements `hook_form_node_form_alter()` to add several `details` groups with
AJAX buttons to the node form, gated by its own permission `access openai content tools`. Each
button triggers an AJAX callback that reads a chosen field's text, cleans it with
`StringHelper::prepareText()`, and calls the relevant `openai.api` method: **Analyze text**
(`moderation()` — reports possible content-policy violations), **Adjust content tone**
(`chat()`/`completions()` to reword for a target audience), **Summarize** a field, **Suggest
title**, and **Suggest taxonomy** terms for the content. Results render inline in the form
(e.g. into a response `<div>`), letting the editor accept/copy them. It stores no config of its
own (tones are currently hardcoded) and defines no plugins. Requires the OpenAI API key on the
parent module.

---

- Add AI content-assist actions directly to the node edit form.
- Moderate/analyze a field for potential content-policy violations before publishing.
- Reword body content to a different tone for a target audience.
- Generate a concise summary of a long field.
- Suggest an SEO/engaging title from the content.
- Suggest relevant taxonomy terms for the entity.
- Speed up editorial review with inline AI suggestions.
- Help editors self-check sensitive content against moderation categories.
- Draft meta/summary text from the article body.
- Give writers tone options (e.g. formal, friendly) at a click.
- Reduce manual tagging effort with AI taxonomy suggestions.
- Provide a first-pass title for untitled drafts.
- Keep AI tools behind the `access openai content tools` permission.
- Analyze only a selected field rather than the whole node.
- Iterate on tone adjustments without leaving the edit form.
- Surface AI assistance in the node form's advanced sidebar.
- Prototype editorial AI workflows on real content.
- Reuse the shared `openai.api` service so all tools use one API key.
