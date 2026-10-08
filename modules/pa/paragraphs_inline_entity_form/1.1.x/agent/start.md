# Paragraphs Inline Entity Form — agent index

Embeds native Paragraphs entities inside CKEditor 5 body text by gluing Entity Embed +
Entity Browser + Inline Entity Form. Mostly **configuration**, plus one Entity Browser widget
plugin and a thin `hook_form_alter`. No settings page (`configure` null), no permissions.
Depends on `ckeditor5`, `paragraphs`, `entity`, `entity_embed`, `entity_browser`,
`entity_browser_entity_form`, `inline_entity_form`.

- **Shipped config (embed button + entity browser), and how to enable it on a text format** →
  [configure/setup.md](configure/setup.md)
- **The `paragraph_entity_form` Entity Browser widget (the only PHP plugin) and its two-step flow** →
  [plugins/entity_browser_widget.md](plugins/entity_browser_widget.md)

Key facts:
- Ships `embed.button.paragraphs_inline_entity_form` and `entity_browser.browser.paragraph_items`
  (iframe, auto-open) in `config/install/`.
- `.module` only alters forms: attaches `paragraphs_inline_entity_form/dialog` JS/CSS, and in the
  Entity Embed dialog turns "Back" into "Edit paragraph"; `hook_entity_embed_values_alter` forces a
  preview refresh.
- Submodule `paragraphs_inline_entity_form_example` → demo content/paragraph types
  ([../../modules/paragraphs_inline_entity_form_example/1.1.x/agent/start.md](../../modules/paragraphs_inline_entity_form_example/1.1.x/agent/start.md)).
- No security-relevant surface found (config-only glue; no routes/permissions of its own).
