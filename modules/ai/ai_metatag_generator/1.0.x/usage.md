<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Metatag Generator adds a one-click button to generate a node's meta description, abstract and keywords with AI.

---

AI Metatag Generator helps editors fill a node's Metatag field without writing metadata by hand. On the edit form of an enabled content type, it adds a "Generate Metatags with AI" button to the Metatag field widget. Clicking it renders the node in a configured view mode, optionally strips HTML and removes blacklisted words, and sends the content to a chat model through the Drupal AI module using a per-language prompt. The model returns JSON with `description`, `abstract` and `keywords`, and those values are placed into the Metatag form fields via AJAX (with a success/error dialog) for the editor to review and save. It requires the AI module and the Metatag module, ships `administer ai metatag generator` and `use ai metatag generator` permissions, and supports Drupal 8 through 11.

---

- Generate a meta description for a node with one click.
- Suggest SEO keywords based on the node's content.
- Produce a short abstract summarizing the page.
- Fill Metatag fields without writing metadata by hand.
- Restrict AI metatag generation to selected content types.
- Point generation at a specific Metatag field machine name.
- Choose the AI provider/model, or use the site default chat model.
- Render the node in a chosen view mode before sending to the AI.
- Strip HTML from content before generation for cleaner input.
- Remove blacklisted words/phrases from the content sent to the AI.
- Write per-language prompts so metadata matches the content language.
- Show editors a success or error dialog after generation.
- Let editors review AI suggestions before saving the node.
- Gate configuration behind `administer ai metatag generator`.
- Gate generation behind `use ai metatag generator`.
- Speed up SEO metadata work across a content team.
- Keep a consistent metadata style via a shared prompt.
- Improve search snippets with AI-drafted descriptions.
- Reduce empty or missing meta descriptions on a site.
- Call the generator service programmatically for custom workflows.
- Localize success/error messages per language.
