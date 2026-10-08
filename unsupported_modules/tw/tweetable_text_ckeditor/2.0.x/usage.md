<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tweetable text CKEditor adds a "Tweetable text" toolbar button to CKEditor (5 and 4) that wraps the selected text in a shareable Twitter/X link, so site visitors can tweet a specific quote from an article with one click.

---

The problem it solves is turning editorial pull-quotes into click-to-share tweets without hand-coding markup. Editors highlight text and press the button; the plugin marks it up (e.g. `<span class="tweetabletext" data-tweet data-hash>`), and a front-end library builds the tweet intent URL from a configurable template using variables `${tweet_text}`, `${page_url}`, `${hash_tags}`, `${display_text}`, and `${tweetable_logo}`. The CKEditor 5 plugin (`TweetableText`) injects its dynamic config (color, template) via `getDynamicPluginConfig`, and `hook_page_attachments` pushes the template/color/icon path into `drupalSettings` plus the styling library on every page.

Operational/security notes: the admin settings form (`/admin/config/content/tweetable_text_ckeditor`) is gated by the core `administer site configuration` permission, and the tweet template is sanitized with `Xss::filter()` on save (`TweetabletextSettingsForm::submitForm`) before being stored in config and emitted to `drupalSettings`. There are no other routes, no permissions of its own, and no server-side mutation endpoints — it is a presentation/editor enhancement. Typical setup: enable the module, add the Tweetable text button to a text format's CKEditor toolbar, ensure the output tags are allowed in "Allowed HTML tags", then adjust the global template/color/icon on the settings page.
---
- Add a "Tweetable text" button to a text format's CKEditor 5 toolbar.
- Let readers tweet a highlighted quote from an article in one click.
- Configure the tweet template with the supported variables.
- Include the page URL automatically in each generated tweet.
- Append configurable hashtags to shared tweets.
- Set a background color to visually mark tweetable spans.
- Set a custom icon path for the tweetable indicator.
- Allow the `tweetabletext` span/attributes in Allowed HTML tags.
- Restrict who can configure the plugin via site-configuration access.
- Use `${display_text}` to show different text than what is tweeted.
- Embed a logo image next to tweetable text via `${tweetable_logo}`.
- Support both CKEditor 5 and legacy CKEditor 4 toolbars.
- Sanitize the tweet template automatically on save.
- Apply the tweetable styling library across the whole site.
- Push template/color/icon settings to the front end via drupalSettings.
- Encourage social sharing of specific in-article passages.
- Keep sharing markup consistent across all content.
