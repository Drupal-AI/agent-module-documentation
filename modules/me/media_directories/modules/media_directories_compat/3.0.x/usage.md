<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Directories Compatibility is a single render-time text filter that rewrites legacy `entity_embed`-style `<drupal-entity>` media embeds into core's `<drupal-media>` markup, so content written before a migration keeps rendering without touching the stored text.

---

The module is one class: `Drupal\media_directories_compat\Plugin\Filter\LegacyEntityEmbed` (filter id `media_directories_legacy_embed`, title "Legacy entity embed compatibility", `TYPE_TRANSFORM_REVERSIBLE`, weight 80). `process()` early-returns unless the text contains `<drupal-entity`, then XPath-selects `//drupal-entity[@data-entity-type="media" and normalize-space(@data-entity-uuid)!=""]`. For each node it reads the JSON in `data-entity-embed-display-settings`, derives a view mode from `data-entity-embed-display` when it has the form `view_mode:media.<mode>`, and then branches. If that view mode is listed in the filter's `inline_display_modes` setting, the node is replaced by an `<a href="<file url>" data-entity-type="media" data-entity-uuid="…">Media label</a>` built from the media's source-field file — and the tag is simply removed when the media or its file no longer exists, so document embeds degrade into plain download links. Otherwise it creates a `<drupal-media>` element carrying `data-entity-type`, `data-entity-uuid`, the derived `data-view-mode`, and — when the legacy settings had `image_width` and `image_height` but no `image_style` — `data-width`/`data-height` for `media_directories_image_resize` to act on. Every other attribute (`data-align`, `data-caption`, `class`, …) is copied across except the three consumed ones listed in `LegacyEntityEmbed::CONSUMED_ATTRIBUTES` (`data-entity-embed-display`, `data-entity-embed-display-settings`, `data-embed-button`). Because it produces `<drupal-media>` tags it **must run before** core's "Embed media" filter, and its only setting (`inline_display_modes`, schema `filter_settings.media_directories_legacy_embed`) is edited on the text-format form. There is no settings page, no permission, no service and no config object.

---

- Keep pre-migration `entity_embed` content rendering after moving to core media embeds.
- Migrate away from `entity_embed`/`embed` without a content rewrite or database migration.
- Preserve the view mode of a legacy embed by mapping `view_mode:media.full` to `data-view-mode="full"`.
- Preserve `data-align` and `data-caption` on converted embeds.
- Carry legacy pixel dimensions across as `data-width`/`data-height` for the resize filter.
- Turn old inline document embeds into plain download links instead of media renders.
- Choose which display modes count as "inline" per text format (`inline_display_modes`).
- Let embeds of deleted media disappear cleanly instead of throwing errors.
- Run the conversion at render time so the stored body text is never modified.
- Roll the conversion out format by format rather than site-wide.
- Test a conversion by processing a sample body through the filter before enabling it broadly.
- Combine with `media_directories_image_resize` so legacy width/height become real derivatives.
- Keep an `entity_embed`-era site on Drupal 11 while planning a proper content migration.
- Avoid maintaining two embed pipelines in your theme templates.
- Drop the `data-embed-button` attribute that core's media embed filter would not understand.
- Diagnose a broken legacy embed by checking whether its `data-entity-uuid` still resolves.
- Support mixed content where some paragraphs use the old tag and some the new one.
- Provide a safety net during a phased CKEditor 4 → 5 upgrade.
- Give document media a text link presentation while images stay as media renders.
- Order it before "Embed media" so the generated tags are actually rendered.
- Leave `<drupal-entity>` tags for non-media entity types untouched.
- Keep the legacy markup valid in the editor by allowing the tag in `filter_html`.
- Verify a migration by comparing rendered output with and without the filter enabled.
- Retire the module once the stored content has been rewritten to `<drupal-media>`.
