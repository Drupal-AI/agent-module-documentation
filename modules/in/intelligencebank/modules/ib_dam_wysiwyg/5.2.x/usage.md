<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ib_dam_wysiwyg is the legacy CKEditor/WYSIWYG submodule of intelligencebank, meant for sites not using the Media suite that still wanted to insert IntelligenceBank DAM assets in rich text. It is deprecated and slated for removal in 6.0.0.

---

In 5.2.x the module has been reduced to a single, now-inert text filter plugin (`ib_dam_wysiwyg`). Its `process()` method returns the text unchanged and only triggers a deprecation notice; there is no CKEditor button, service, route, or configuration of its own. A runtime requirements check flags the module as deprecated, and its install file provides an update hook that disables the filter and rewrites any legacy inline JSON asset markup into core `<drupal-media>` tags (creating the corresponding media entities through the parent module's asset pipeline). The parent module's own update hook removes this filter from every text format and uninstalls the submodule. For current sites, use `ib_dam_media` together with core Media Library and CKEditor 5 instead of this module.

---

- (Legacy) embed IntelligenceBank DAM assets inside CKEditor rich text.
- Support DAM embedding on sites that do not run the Media suite.
- Provide the `ib_dam_wysiwyg` text filter for older content.
- Keep old DAM-in-WYSIWYG content rendering during migration.
- Convert legacy inline JSON asset markup into `<drupal-media>` tags.
- Migrate WYSIWYG-embedded DAM assets into real media entities.
- Surface a deprecation warning so admins plan removal.
- Cleanly uninstall via the parent module's update hook.
- Identify text formats still using the deprecated filter.
- Transition rich-text DAM usage toward core media embedding.
- Understand what a legacy intelligencebank site enabled.
- Audit whether the deprecated filter is still active anywhere.
- Plan the move to ib_dam_media before upgrading to 6.0.0.
- Preserve backwards compatibility for existing field content.
- Avoid enabling it on new sites (no active functionality).
