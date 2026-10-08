<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quote (quote) — agent index

**Adds quote links to nodes/comments that copy the source text into a new comment or reply form (with CKEditor 5 support).**

- **Version:** 4.1.x
- **Core:** ^10.1 || ^11
- **Depends on:** node, comment
- **Config route:** `quote.settings_form` (`/admin/config/content/quote`) — permission `administer quote`.
- **Permissions:** `administer quote`, `use quote` (links also require core `post comments`).
- **Hooks (`QuoteHooks`):** `node_links_alter` / `comment_links_alter` add quote link variants; `form_alter` pre-fills the reply body for the `comment-quote-all-reply` flow; `help`.
- **JS:** `quote/quote` library + `drupalSettings.quote.*` (selectors, limit, ckeditor/html-tag support) → `js/quote.js` copies body/author into the comment field.

**Access:** config route is permission-gated and quote links respect `use quote` + `post comments`. The reply-and-quote-all flow pre-fills the reply body from the comment named by the `comment-quote-all-reply` query param (`QuoteHooks.php:209`). Author name is `t()`-escaped; quoted body goes through the text-format widget.

See [configure/settings.md](configure/settings.md)
