<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Insert Blocks adds a toolbar dropdown that drops any Drupal block (custom module block, views block, or content block) into body content and keeps it as a reference re-rendered at display time.

---

The requirement recurs on any site where reusable components live in the block system: an editor writing an article wants a call-to-action, a related-content listing, a newsletter signup or a promotional panel partway down the body, and those things already exist as blocks. The structured answers — a paragraph type or Layout Builder — are better designed but a larger change to how the site is built; inserting a block from the editor is the pragmatic middle. The plugin is a CKEditor 5 dropdown, configured per text format: its settings form (a checkboxes list on the format's CKEditor toolbar configuration) picks which block plugins the button offers, and an empty selection means **every** block on the site. When the editor picks one, the plugin fetches the block's rendered HTML from the `/get-block-content/{block_id}` route over AJAX and inserts a `<div class="insert-block" data-block-id="…">…rendered HTML…</div>` wrapper into the body (a balloon form can add an HTML class and a comma-separated list of asset libraries via `data-library`). That div — the rendered snapshot plus the `data-block-id` marker — is what gets **stored** in the field. At display time, the module's `insert_block` text-format filter (which you must enable on the format, and which needs `symfony/dom-crawler` on Drupal 10/11/12) walks the stored HTML with an XPath crawler, and for each marked div re-renders the referenced block **server-side against the viewing user** (calling the block's own `access()`), replacing the div body and attaching any `data-library` assets. So the stored text never changes when the block changes — the filter reconstructs the current block on each render (the module notes you clear cache to see edits). The gate deserves more weight than a WYSIWYG button usually gets: a block renders arbitrary markup and can attach JavaScript libraries, so placing any block into body text is closer to a site-building capability than an editing one, and a views block runs a view inline with its own access and filters. Version 1.0.3, core `^10 || ^11 || ^12`. Compare `ck5_block_embed`, which does the same job behind an explicit permission.

---

- Insert a call-to-action block into an article from the editor toolbar.
- Embed a related-content listing block mid-page.
- Add a newsletter signup block to body text.
- Place a promotional panel partway down a page.
- Reference a block rather than pasting a copy of its markup.
- Embed a views block (filtered listing) inside an article body.
- Keep an embedded block current — the filter re-renders it on display.
- Add a contact/form block to a content page.
- Insert a downloads block into a documentation guide.
- Add a testimonial block inline in a story.
- Embed a map block in page content.
- Reuse a single block across many articles as a reference.
- Restrict the button to a curated set of blocks per text format.
- Attach a custom CSS class to an inserted block via the balloon form.
- Attach an extra asset library to an inserted block via `data-library`.
- Show a live preview of a block before committing it into the body.
- Place a banner block mid-article without touching block layout.
- Insert a video block into rich-text content.
- Give editors block placement without granting block-layout admin.
- Re-render inserted blocks client-side via the optional insert-block-ajax library in a theme.
