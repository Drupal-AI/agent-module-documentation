IB: CKEditor WYSIWYG integration (`ib_dam_wysiwyg`) is the legacy way to embed IntelligenceBank assets directly in CKEditor for sites not using the Media suite. It is DEPRECATED in 4.x/5.x and removed in 6.0.0, and its text filter is now a no-op.

---

The submodule provides a single text-format filter, id `ib_dam_wysiwyg` ("IntelligenceBank DAM WYSIWYG", type `TYPE_MARKUP_LANGUAGE`). In the current 5.x release `FilterProcessResult::process()` returns the text unchanged and triggers a deprecation notice — there is no replacement. `hook_requirements()` also surfaces a runtime warning that the module is deprecated. Its only substantive code is the update hook `ib_dam_wysiwyg_update_9000()`, which is the one-time migration path: it disables the `ib_dam_wysiwyg` filter on every text format and converts old inline custom-JSON media markup (`{"source_type":…}`) stored in text/text_long/text_with_summary fields into standard `<drupal-media>` tags by creating real media entities (via `ib_dam_media`'s MediaStorage and MediaTypeMatcher). New sites should use `ib_dam_media` (Media Library) instead. Depends on `field`, `filter`, and the base `ib_dam`.

---

- (Legacy) embed IntelligenceBank assets inline in CKEditor without the Media suite.
- Run the `ib_dam_wysiwyg_update_9000` migration to convert old IB JSON markup into `<drupal-media>` tags.
- Identify and remove a deprecated IB WYSIWYG filter from existing text formats.
- Recognise the runtime "deprecated" requirement warning this module raises.
- Understand why an old `ib_dam_wysiwyg`-filtered field now renders its content unchanged.
- Plan a migration off this module to `ib_dam_media` before upgrading to 6.0.0.
- Audit which text formats still have the deprecated `ib_dam_wysiwyg` filter enabled.
- Keep legacy content readable during a transition to Media-based IB embedding.
