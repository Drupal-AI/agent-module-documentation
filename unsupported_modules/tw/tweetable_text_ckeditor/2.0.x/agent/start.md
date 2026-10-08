<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tweetable text CKEditor (tweetable_text_ckeditor) — agent index

**Adds a CKEditor 5/4 button that wraps selected text so readers can share it as a one-click tweet.**

- **Version:** 2.0.x (2.0.0) · project `tweetable_text_for_ckeditor`
- **Core:** ^10 || ^11
- **Configure:** `tweetable_text_ckeditor.admin_settings` — `/admin/config/content/tweetable_text_ckeditor` (perm `administer site configuration`)
- **CKEditor 5 plugin:** `TweetableText` (dynamic config: color, template)
- **Config:** `tweetable_text_ckeditor.settings` (`_color`, `_icon`, `_template`)
- **Template vars:** `${tweet_text}`, `${page_url}`, `${hash_tags}`, `${display_text}`, `${tweetable_logo}`

**Security:** Single admin config route gated by `administer site configuration`; no permissions of its own and no mutating/anonymous endpoints. The tweet template is `Xss::filter()`-sanitized on save before storage and output to `drupalSettings`. No security findings.
