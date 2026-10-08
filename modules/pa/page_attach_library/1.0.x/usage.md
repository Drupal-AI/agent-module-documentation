<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Attach Library lets an administrator attach any registered Drupal asset library (CSS/JS) to pages whose path matches a configured pattern, without writing a custom module.

---

Administration lives at `/admin/config/page-attach-library/page-attach-library-settings` behind the core `administer site configuration` permission. The settings form (`PageAttachLibrarySettingsForm`) presents a draggable table of rules; each row has an Enabled checkbox, a Pages textarea (one path per line, `*` wildcard, `<front>` token), and a library textarea listing one or more `module_name/library_name` identifiers (separated by newlines or commas). Rules are stored in the `page_attach_library.settings` config object. At render time `hook_page_attachments` walks the enabled rules, matches the current path (and its alias) with the `path.matcher` service, and appends each listed library to `#attached['library']`. Because library identifiers are attached verbatim, only libraries actually declared by an installed module/theme take effect; the feature is limited to trusted administrators via the site-configuration permission and has no anonymous or mutating endpoints, no outbound HTTP and no credential handling.

Typical setup: define a rule pointing at a path pattern (e.g. `/node/*`), list the libraries to load there, enable the rule, and save.
---
- Attach a CSS/JS library to a specific page path.
- Load a library across a whole section using a `/section/*` wildcard.
- Target the front page with the `<front>` token.
- Attach multiple libraries to the same path set.
- Add several rules with different path/library combinations.
- Enable or disable a rule without deleting it.
- Reorder rules with drag-and-drop weighting.
- Match against URL aliases as well as system paths.
- Load a theme's optional library only where it is needed.
- Add a third-party module's library to selected pages.
- Avoid a custom `hook_page_attachments` module for simple cases.
- List libraries separated by newlines or commas.
- Remove a rule row via the Remove button.
- Restrict library loading to reduce page weight elsewhere.
- Scope a slider/lightbox library to just the pages that use it.
- Apply print or campaign styles to specific landing pages.
