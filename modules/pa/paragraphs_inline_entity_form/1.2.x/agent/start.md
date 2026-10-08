# Paragraphs Inline Entity Form — agent index

Embeds native Paragraphs entities inside CKEditor 5 body text by gluing Entity Embed +
Entity Browser + Inline Entity Form. Mostly **configuration**, plus one Entity Browser widget
plugin and thin hook implementations. No settings page (`configure` null), no permissions, no
routes of its own. Depends on `ckeditor5`, `paragraphs`, `entity_embed`, `entity_browser`,
`entity_browser_entity_form`, `inline_entity_form`.

- **Shipped config (embed button + entity browser), and how to enable it on a text format** →
  [configure/setup.md](configure/setup.md)
- **The `paragraph_entity_form` Entity Browser widget (the only PHP plugin) and its two-step flow** →
  [plugins/entity_browser_widget.md](plugins/entity_browser_widget.md)

Key facts:
- Ships `embed.button.paragraphs_inline_entity_form` and `entity_browser.browser.paragraph_items`
  (iframe, auto-open) in `config/install/`.
- Hook implementations live in `src/Hook/ParagraphsInlineEntityFormHooks.php` (OOP `#[Hook]`
  attributes, registered via `paragraphs_inline_entity_form.services.yml` with `autowire: true`);
  `.module` keeps thin `#[LegacyHook]` shims plus the `paragraphs_inline_entity_form_entity_browser_is_paragraph_item()`
  helper.
- Hooks only alter forms: `hook_form_alter` attaches `paragraphs_inline_entity_form/dialog` JS/CSS
  to entity forms, and in the Entity Embed dialog's `embed` step turns "Back" into "Edit paragraph"
  (an AJAX link to the existing `entity_browser.edit_form` route); `hook_entity_embed_values_alter`
  copies the UUID into `alt` to force a preview refresh. `hook_help` renders `README.md`
  (`Html::escape()` + `nl2br()`).
- Submodule `paragraphs_inline_entity_form_example` → demo content/paragraph types
  ([../../modules/paragraphs_inline_entity_form_example/1.1.x/agent/start.md](../../modules/paragraphs_inline_entity_form_example/1.1.x/agent/start.md)).
- No security-relevant surface of its own: config-only glue, no routes/permissions; entity
  creation is delegated to Inline Entity Form + `entity_browser_entity_form`, and reaching the
  widget requires the Entity Browser's `access paragraph_items entity browser pages` permission.

See [Diff 1.1.x → 1.2.x](#diff-11x--12x) below for what changed.

## Diff 1.1.x → 1.2.x

Real, source-confirmed changes (`version: '8.x-1.2'`, packaged 2026-08-26):

- **Hooks moved to an OOP hook class.** `src/Hook/ParagraphsInlineEntityFormHooks.php` now holds
  `hook_help`, `hook_form_alter` and `hook_entity_embed_values_alter` as `#[Hook(...)]` methods,
  registered by the new `paragraphs_inline_entity_form.services.yml` (`autowire: true`). The `.module`
  file is reduced to `#[LegacyHook]` wrapper functions that call the service, plus the
  `paragraphs_inline_entity_form_entity_browser_is_paragraph_item()` helper.
- **Core requirement raised:** `^9.5 || ^10 || ^11` → `^10.3 || ^11 || ^12`.
- **`drupal/entity` dependency dropped.** `.info.yml` and `composer.json` no longer require the
  Entity API module; `drupal:ckeditor5` is now listed explicitly in `.info.yml` dependencies.
- **`entitySelectorForm()` hardened its embed-button lookup.** It now finds the button from the
  request path *or* falls back to the entity-browser widget context (`embed_button_id`), instead of
  silently offering every paragraph type when the button cannot be found from the path alone.
- **README rewritten and expanded** (step-by-step setup, permissions table, troubleshooting, a
  Drupal 12 status note, CKEditor 5 v47 "pencil" note). `hook_help` surfaces it on the module help
  page.
- No new routes, permissions, config schema keys, or services beyond the hook service. The
  `paragraph_entity_form` widget's behaviour and shipped config entities are unchanged.
