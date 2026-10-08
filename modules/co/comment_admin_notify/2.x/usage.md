Comment Admin Notify e-mails a configured administrator every time a new comment is posted on selected content types.

---

Comment Admin Notify hooks into comment insertion and, when enabled, sends a single plain-text notification e-mail to an administrator address. You configure the recipient address, the subject line, the body template, and which node content types trigger a notification from one settings form at `/admin/config/system/comment-admin-notify` (permission `administer site configuration`). Subject and body are run through the Token module, so templates such as `[node:title]`, `[comment:title]`, `[comment:body]` and `[comment:url]` are expanded per comment. Each sent notification is also written to the watchdog log. The module depends on core Comment and the contributed Token module and ships no permissions, services, plugins, or Drush commands of its own — it is a small `hook_comment_insert` + `hook_mail` implementation plus one `ConfigFormBase` form.

---

- Notify a site administrator by e-mail whenever any visitor or user posts a new comment.
- Route comment notifications to a shared moderation inbox by setting the "E-mail to address" field.
- Fall back to the site e-mail (`system.site` `mail`) automatically when no recipient address is configured.
- Restrict notifications to comments on specific node content types (e.g. only Article, not Page) via the content-types checkboxes.
- Enable or disable all comment notifications with a single "Enable" checkbox without uninstalling the module.
- Customise the notification subject line (default "Comment notification").
- Customise the notification body from a token-aware textarea template.
- Include the commented node's title in the e-mail with the `[node:title]` token.
- Include the comment's subject/title with `[comment:title]`.
- Include the comment body text with `[comment:body]`.
- Include a direct link back to the comment with `[comment:url]` so moderators can act quickly.
- Give moderators an early heads-up on new discussion so spam or abuse can be removed fast.
- Keep an audit trail of comment activity via the watchdog log entries the module writes (`Nid`, `cid`, `Subject`).
- Provide comment awareness on low-traffic sites where staff do not watch the admin comment queue continuously.
- Support multilingual sites by sending in the site's default language.
- Use the Token browser link on the settings form to discover valid node/comment tokens.
- Notify staff about comments on custom entity types too (any commented entity whose bundle is in the selected list; content-type options are drawn from node bundles).
- Serve as a lightweight alternative to Rules/ECA for the single job of "e-mail admin on new comment".
- Combine with core Comment moderation ("unapproved" comments) so moderators are pinged the moment a comment needs review.
- Configure once and export `comment_admin_notify.settings` config for deployment across environments.
- Change the recipient address per environment (e.g. dev vs. production inbox) through configuration overrides.
- Disable notifications for high-volume content types to avoid inbox flooding while keeping them for others.
