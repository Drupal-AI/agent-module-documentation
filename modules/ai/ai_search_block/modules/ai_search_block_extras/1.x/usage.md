AI Search Block Extras adds opt-in UX enhancements to the AI Search Block, starting with an auto-grow textarea, controlled from an admin settings screen.

---

This submodule of AI Search Block provides a small admin settings form with feature toggles. The shipped feature is an auto-grow textarea: when enabled, the AI Search form's textarea input expands one row at a time as the visitor types, so a scrollbar never appears. A `form_alter` attaches the auto-grow JavaScript library only to AI Search form blocks that actually use the textarea input type, so the enhancement is scoped and does not load elsewhere. The module is intentionally lightweight and additive — it changes presentation only. Depends on AI Search Block.

---

- Enable an auto-growing textarea for the AI Search input.
- Keep the textarea free of scrollbars as the visitor types longer questions.
- Toggle the feature from a dedicated admin settings screen.
- Scope the enhancement to blocks using the textarea input type only.
- Avoid loading the extra JavaScript where it is not needed.
- Improve the writing experience for multi-line questions.
- Keep the base AI Search Block lean by moving UX extras into an opt-in module.
- Gate configuration behind the "administer ai_search_block_extras" permission.
- Turn the feature off again with no residual effect.
- Combine with the textarea input option on the AI Search form block.
- Provide a home for future opt-in UX features.
- Apply consistently across all textarea AI Search blocks on the site.
