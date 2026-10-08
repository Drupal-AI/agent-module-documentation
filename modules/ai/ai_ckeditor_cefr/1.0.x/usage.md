AI CKEditor CEFR lets editors rewrite selected CKEditor text to a chosen CEFR language level (A1-C2) with AI.

---

AI CKEditor CEFR adds one AI CKEditor action plugin, "CEFR level", that rewrites the text an editor has selected in CKEditor 5 to a target CEFR (Common European Framework of Reference for Languages) proficiency level. It integrates with the ai_ckeditor dialog: the editor selects text, opens the AI Assistant, chooses a level (A1 Beginner through C2 Proficient), and clicks Rewrite; the suggestion streams back into a response field for review before it is saved into the editor. The rewrite prompt is a configurable template with per-level style targets, and an optional taxonomy vocabulary can list protected words/phrases that must stay unchanged. Rewrites run through the drupal/ai chat provider configured for the plugin (or the AI module chat default) and incur provider cost. Requires the AI module's ai_ckeditor submodule and core taxonomy; supports Drupal 10.4+ and 11.

---

- Rewrite a selected passage down to A1 or A2 for beginner readers.
- Simplify dense body copy to B1 plain language for a general audience.
- Adjust marketing text to a consistent B2 reading level across a site.
- Raise or polish text toward C1/C2 for an advanced audience.
- Produce multiple language-level variants of the same source paragraph.
- Simplify public-sector or government content for accessibility.
- Prepare graded reading material for language-learning courses.
- Keep brand names and technical terms unchanged via a protected-words vocabulary.
- Enforce an editorial house reading level during content review.
- Rewrite instructions or help text to a clearer, lower CEFR level.
- Localize complexity when translating content into plainer wording.
- Set a default CEFR level so editors get a consistent starting point.
- Customize the rewrite prompt template for a specific tone or domain.
- Pick a specific AI provider/model per text format for CEFR rewrites.
- Give editors an in-editor readability tool without leaving CKEditor.
- Reduce jargon in knowledge-base articles to B1.
- Make product descriptions consistent in reading difficulty.
- Adapt survey or form intro text to a target audience level.
- Offer an accessibility-focused "simplify this" action to authors.
- Standardize reading level across contributors with different writing styles.
