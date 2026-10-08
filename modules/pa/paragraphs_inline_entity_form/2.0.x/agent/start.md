# Paragraphs Inline Entity Form — agent index

Embeds native Paragraphs entities inside CKEditor 5 body text by gluing Entity Embed +
Entity Browser + Inline Entity Form. Mostly **configuration**, plus one Entity Browser widget
plugin and a thin, class-based hook layer. No settings page (`configure` null), no permissions
of its own. Depends on `ckeditor5`, `paragraphs`, `entity_embed`, `entity_browser`,
`entity_browser_entity_form`, `inline_entity_form`.

- **Shipped config (embed button + entity browser), how to enable it on a text format, and the
  permissions editors need** → [configure/setup.md](configure/setup.md)
- **The `paragraph_entity_form` Entity Browser widget (the only PHP plugin) and its two-step flow** →
  [plugins/entity_browser_widget.md](plugins/entity_browser_widget.md)

Key facts:
- Ships `embed.button.paragraphs_inline_entity_form` and `entity_browser.browser.paragraph_items`
  (iframe, `auto_open: true`, `display_review: false`) in `config/install/`.
- Hooks are **class-based** now: `src/Hook/ParagraphsInlineEntityFormHooks.php` implements
  `help`, `form_alter` and `entity_embed_values_alter` via `#[Hook(...)]` attributes; the thin
  `.module` file only wraps them with `#[LegacyHook]` and delegates to the autowired service
  registered in `paragraphs_inline_entity_form.services.yml`.
- `hook_help()` renders the module's `README.md` (escaped with `Html::escape()` then `nl2br()`)
  on `/admin/help/paragraphs_inline_entity_form`.
- `form_alter` attaches the `paragraphs_inline_entity_form/dialog` JS/CSS library to entity forms
  and, inside the Entity Embed dialog for paragraph items, rewrites "Back" into "Edit paragraph"
  (an AJAX link to `entity_browser.edit_form`); `entity_embed_values_alter` copies the UUID into
  `alt` to force a preview refresh.
- Submodule `paragraphs_inline_entity_form_example` → demo content/paragraph types
  ([../../modules/paragraphs_inline_entity_form_example/1.1.x/agent/start.md](../../modules/paragraphs_inline_entity_form_example/1.1.x/agent/start.md)).
- No security-relevant surface of its own: no routes, no permissions; nested paragraph create/edit
  is delegated to Inline Entity Form's standard `inline_entity_form` element, and reachability is
  gated by Entity Browser's `access paragraph_items entity browser pages` permission plus the text
  format's "use" permission.

## Diff 1.1.x → 2.0.x

Major bump. Behaviour for editors is unchanged; the breaking changes are in requirements and
internal structure.

- **Core requirement raised** to `^10.3 || ^11 || ^12` (was `^9.5 || ^10 || ^11`). Drupal 9 and
  10.0–10.2 are dropped. Note: README warns Drupal 12 is not usable in practice yet because
  Paragraphs / Embed / Entity Embed / Inline Entity Form have no D12 release, not because of this
  module.
- **`drupal/entity` dependency removed** — it is no longer listed in `.info.yml` or `composer.json`.
  Update any `data.json`/inventory that still lists `entity`.
- **Hooks refactored to the object-oriented hook system.** Implementations moved from procedural
  `.module` functions to `src/Hook/ParagraphsInlineEntityFormHooks.php` with `#[Hook]` attributes;
  `.module` now holds `#[LegacyHook]` shims that call the autowired service. New
  `paragraphs_inline_entity_form.services.yml`. This relies on the modern hook attributes, raising
  the effective Drupal-version floor.
- **New `hook_help()`** implementation that renders `README.md` on the module help page (did not
  exist in 1.1.x).
- **Widget bundle resolution hardened** — `entitySelectorForm()` now resolves the embed button from
  the request path *or* falls back to the Entity Browser `widget_context` (`embed_button_id`) when
  served from the iframe route, and renders each paragraph type's icon via the `thumbnail` image
  style (default `paragraph_thumb.png` otherwise).
- Config, JS/CSS library, and the `paragraph_entity_form` widget's public behaviour are otherwise
  the same.
