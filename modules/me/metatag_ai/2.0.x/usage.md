<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Metatag AI Generator adds a **"Generate Metatag"** button to node edit forms that calls a configured AI provider (via the [AI](https://www.drupal.org/project/ai) module) to produce a meta title, description, abstract and keywords from the node's title and body, then writes them into the node's Metatag field.

---

Metatag AI 2.x (a full rewrite of 1.x) bridges the **AI** module's chat providers and the **Metatag** module. On the settings form (`/admin/config/content/metatag-ai`, route `metatag_ai.content_settings`, permission `administer metatag content`) you select which content types get the button, the machine name of the Metatag field (default `field_metatag`), and optionally a specific AI provider/model (otherwise the AI module's default chat provider is used). Per interface language you configure a **system prompt** assembled from component instructions (title/description/abstract limits, keyword count, extra instructions); the module always appends "Suggest content for SEO ranking" and a "reply in JSON" instruction. When an editor with the `administer metatag content` permission clicks the button on a selected content type, `hook_form_alter` triggers an AJAX callback that concatenates the title and body, calls `GenerateMetatag::generate()`, which sends a `ChatInput` (system prompt + text) to the provider, parses the JSON reply (handling markdown code fences), and uses AJAX `InvokeCommand`s to populate the Metatag basic fields (`#edit-<field>-0-basic-title|description|abstract|keywords`) in the open form — the editor still saves the node manually. A `bulkGenerate(EntityInterface)` service method exists to generate and save tags for a node programmatically. All prompts, provider selection and content-type selection are stored in `metatag_ai.content_settings`; there is no config schema shipped and no Drush command. Requires a working AI provider configured at `/admin/config/ai`.

---

- Add an AI "Generate Metatag" button to the node edit form for chosen content types.
- Auto-draft an SEO meta description from a node's title and body via an LLM.
- Generate a meta title within a character limit (e.g. 60 chars) from content.
- Generate an abstract/summary meta tag from the body text.
- Generate a list of SEO keywords (configurable maximum count) for a node.
- Pick a specific AI provider/model for metatag generation instead of the site default.
- Fall back to the AI module's default chat provider when none is selected.
- Configure the system prompt per interface language for multilingual sites.
- Tune the prompt: title/description/abstract instructions, keyword count, extra instructions.
- Restrict which content types expose the generation button.
- Point the module at a custom Metatag field machine name (not `field_metatag`).
- Populate the open node form's Metatag fields via AJAX without a full save.
- Programmatically generate and persist metatags for a node with `bulkGenerate()`.
- Call `generate($text, $langcode)` from custom code to get title/description/abstract/keywords.
- Combine with the Metatag module's existing token/default system for hybrid workflows.
- Speed up SEO metadata authoring across a large content team.
- Provide language-specific SEO metadata generation for translated content.
- Enforce a consistent meta-tag structure via a shared, admin-controlled prompt.
- Preview the assembled system prompt on the settings form before saving.
- Surface AI/provider errors inline on the form (missing provider, empty response, bad JSON).
- Generate metadata that respects a "reply in JSON" contract for reliable field mapping.
