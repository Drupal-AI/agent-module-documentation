Block Content Type Visibility adds friendly Show/Hide radio buttons to Drupal core's node content-type block-visibility condition.

---

Block Content Type Visibility is a small UX module for the block layout UI. It does **not** provide its own condition plugin — it reuses Drupal core Node's built-in "Content types" (`entity_bundle:node`) block-visibility condition and only alters the block configuration form. It replaces core's technical "Negate the condition" checkbox with a clear "Visibility mode" radio set — "Show for the selected content types" vs "Hide for the selected content types" — and a custom submit handler translates that choice back into the condition's `negate` boolean (show = 0, hide = 1). All behavior lives in the OOP Hook class `src/Hook/BlockContentTypeVisibilityHooks.php` implementing `hook_form_block_form_alter`; on Drupal < 11.1 the procedural `.module` hook delegates to the same class. It affects only which blocks are rendered on a page — it is presentation, not access control, and hiding a block does not protect the underlying content. It depends on core Block and Node and targets Drupal core ^11.

---

- Show a promotional block only on Article pages.
- Hide a sidebar navigation block on Landing Page nodes.
- Restrict a "related content" block to specific content types.
- Replace core's confusing "Negate the condition" checkbox with plain Show/Hide radios.
- Let non-technical site builders scope blocks by node type without editing code.
- Choose "Show for the selected content types" so a block appears only on those types.
- Choose "Hide for the selected content types" so a block appears everywhere except those types.
- Configure the mode inside a block's Visibility → "Content types" section at `/admin/structure/block`.
- Scope a call-to-action block to just the Page content type.
- Keep an author-bio block off non-Article content.
- Combine content-type scoping with core's other visibility conditions (path, role, language).
- Toggle the same block between show and hide semantics without deleting and re-adding the condition.
- Rely on core Node's condition for the actual bundle matching and cacheability.
- Understand the stored config: only the core condition's `bundles` and `negate` are saved (no extra config object).
- Migrate cleanly — no configuration changes are required when upgrading the module.
- Use on Drupal 11.1+ where the module registers via PHP `#[Hook]` attributes.
- Use on Drupal < 11.1 where the legacy procedural hook delegates to the same OOP class.
- Treat the feature as block visibility only, never as a way to secure content.
- Avoid custom code for simple "show this block only on X content type" requirements.
- Configure per-block, so different blocks can target different content types independently.
