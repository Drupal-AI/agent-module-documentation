<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Auto-reference uses an LLM to suggest or automatically fill entity-reference fields on node forms, linking content to related nodes or taxonomy terms already on the site.

---

AI Auto-reference lets a site builder map an entity-reference field on a node bundle to a view mode and a prompt, then have an AI model propose which existing nodes or taxonomy terms that content should reference. Editors receive suggestions in one of two ways: a "Generate references with AI" button beside Save that runs a batch and shows a review/apply form, or an inline "AI Suggested References" button on the field widget itself (via the optional Field Widget Actions module) that opens a modal of checkboxes/radios. Candidate targets are limited to the values the current user may reference, and content is oversized-aware — it summarises or crops the rendered node before sending it when it would exceed the configured token limit. The AI provider and model come from AI core, so any supported chat model works, and suggestions can either be reviewed or auto-applied by relevance level. It ships single- and multiple-suggestion default prompts that site builders can edit or extend.

---

- Auto-suggest taxonomy tags for an article from the site's existing vocabulary rather than free-tagging.
- Fill a "Related articles" node-reference field with AI-picked related content.
- Categorise new content into a curated set of category terms maintained by an editorial team.
- Give editors an inline "AI Suggested References" button directly on a reference field widget.
- Add a "Generate references with AI" button next to Save that presents a review screen before applying.
- Auto-apply high-relevance suggestions while leaving medium-relevance ones for manual review.
- Fully auto-apply both high and medium relevance suggestions for a hands-off tagging workflow.
- Let editors review and deselect individual AI suggestions before saving them to the node.
- Suggest a single best-match reference for a cardinality-1 reference field (radios + "None").
- Suggest several references for a multi-value reference field (checkboxes grouped by relevance).
- Drive suggestions from a specific view mode so only teaser-level content is sent to the model.
- Use different prompts per field (e.g. a topic prompt for one field, a region prompt for another).
- Edit the default prompts or create new auto_reference-type prompts in the AI prompt library.
- Keep long content within model token limits automatically via summarise-then-suggest.
- Choose any AI Core chat provider/model (OpenAI, Anthropic, etc.) for reference generation.
- Configure references per node bundle from the content type's "AI auto-reference" operation/tab.
- Restrict who can generate suggestions with a dedicated permission, separate from administering config.
- Suggest tags on the node create form using the entity's typed text fields when nothing is saved yet.
- Support common reference widgets including autocomplete, tags, select, buttons, and Tagify variants.
- Hide the generate button per bundle when references are produced by another automated workflow.
- Suggest references to other nodes for building topic hubs or content clusters.
- Suggest term references to power faceted search and related-content blocks.
- Avoid suggesting a node as a reference to itself or duplicating already-selected values.
