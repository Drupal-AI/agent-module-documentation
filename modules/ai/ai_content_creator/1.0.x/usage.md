<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Content Creator adds a prompt-driven "Generate content" panel to node forms that drafts text with the OpenAI API and returns it in a copy-to-clipboard modal.

---

AI Content Creator integrates OpenAI content generation directly into the Drupal node add/edit form. On the
content types you enable, a collapsible "AI Content Generator" panel appears with a prompt textarea and a
"Generate content" button. Clicking it fires an AJAX callback that sends the prompt to the OpenAI Chat (or legacy
Completions) API through a Guzzle HTTP service and shows the returned text in a modal dialog, with a button to copy
it to the clipboard. The author pastes the text into whatever fields they want — nothing is written to the entity
automatically. A single administration form at `/admin/config/ai_content_creator` holds the OpenAI endpoint, access
token, model (GPT-3.5 Turbo / GPT-4 / GPT-4 Turbo / legacy davinci), maximum tokens, temperature, and the list of
content types that display the panel. The module calls OpenAI directly rather than through the drupal/ai provider
layer, and defines no permissions or config schema of its own.

---

- Draft a blog post or article body from a natural-language prompt while editing a node.
- Generate marketing copy, product descriptions, or summaries inside the node form.
- Give editors an on-page AI assistant without leaving the content-creation workflow.
- Restrict the AI panel to specific content types (e.g. only Article and Basic page).
- Choose the OpenAI model per site (GPT-3.5 Turbo, GPT-4, GPT-4 Turbo, or a legacy completion model).
- Tune creativity with the temperature setting (0 = deterministic, 1 = more varied).
- Cap output length with the maximum-tokens setting (1–4000).
- Point the module at a custom OpenAI-compatible endpoint URL.
- Copy generated text to the clipboard in one click via the modal's "Copy to clipboard" button.
- Review and edit AI output before pasting it into fields (accuracy, licensing, hallucination).
- Keep the OpenAI access token in site configuration on the settings form.
- Provide a throwaway generation flow that never overwrites existing field values.
- Speed up first-draft creation for content teams.
- Prototype content ideas quickly during authoring.
- Produce alternative phrasings by re-running the same prompt.
- Add an AI drafting step to an existing editorial process.
- Use OpenAI content generation on Drupal 10.3+ or 11.
