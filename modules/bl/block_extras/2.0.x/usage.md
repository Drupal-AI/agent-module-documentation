<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Extras adds an "Edit this block content" link and a live content preview to the block placement configuration form for placed content blocks.

---

Block Extras is a small site-building convenience module. Its only feature in the 2.0.x release is a `hook_form_alter()` on the core block placement/configure form (`block_form`, at `/admin/structure/block/manage/{block}`). When the block being configured is a placed content block (a `block_content` entity referenced by UUID in the block plugin id), the module adds a "Block Extras" fieldset to the form containing two things: (1) an "Edit this block content" link that deep-links to that content block's edit page (`/admin/content/block/{id}`) with a `destination` back to the current path, and (2) a "Block preview" fieldset showing the block content rendered through its default view builder. It also implements `hook_help()` for a short about page. There is no settings form, no permission, no route, no service, and no config schema of its own. It has no declared module dependencies, though the preview/edit feature only applies to placed `block_content` blocks (provided by core's Block Content module).

---

- Jump straight from a placed block's configuration form to editing that block's content, without hunting through the content block library.
- See a rendered preview of a content block's body while configuring where it appears.
- Speed up the common "place a content block, then tweak its text" workflow for site builders.
- Keep the return path intact: the edit link carries a `destination` so saving the block returns you to the block layout page.
- Give editors a faster round-trip between block placement and block content editing.
- Confirm you placed the right content block by eyeballing the preview before saving placement.
- Reduce clicks when managing many similar content blocks in a theme region.
- Provide an at-a-glance content check on the block admin screen.
- Work on Drupal 10.1+ and Drupal 11 with no external libraries.
- Install with zero configuration — the feature appears automatically on the block form.
- Enhance the block administration UX for content-block-heavy sites.
- Help maintainers verify block content without opening a second tab manually.
- Complement layout/block-placement workflows in a standard Drupal site.
- Serve as a lightweight example of altering the block configuration form.
- Assist QA in checking that a placed block resolves to the expected content.
- Support editorial teams reviewing block content during placement.
- Avoid custom code for the common "edit the underlying block content from placement" need.
- Apply only to content blocks (blocks whose plugin id resolves to a `block_content` UUID); plugin-defined blocks are unaffected.
- Add no front-end output — the enhancement is admin-form-only.
