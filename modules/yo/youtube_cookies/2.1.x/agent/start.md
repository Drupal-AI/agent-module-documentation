# YouTube Cookies — agent index

Blocks embedded YouTube videos (oembed media fields, contrib Iframe field, CKEditor content) from
loading and setting cookies until the visitor consents, showing a thumbnail façade + consent pop-up
wired to OneTrust or EU Cookie Compliance. Admin settings form at `/admin/config/system/youtube-cookies`
(`administer site configuration`). Config schema + config translation. No permissions of its own, no
Drush, no submodules.

- **Settings form, config keys, providers/actions, the text-format filter, and the three embedding
  integrations** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object `youtube_cookies.settings`: `enabled`, `cookie_category`, `provider`
  (`onetrust`|`eu_cookie_compliance`), `action` (`popup`|`no_cookies_domain`), `popup_message`,
  `button_manage`, `button_accept`, `button_exit`.
- Blocking works by moving iframe `src` → `data-src` and blanking `src`, then a façade + JS pop-up;
  JS attached via `hook_page_attachments` only when `cookie_category` + `provider` are set.
- CKEditor path is the `youtube_cookies_wysiwyg_filter` text-format filter (enable per format; requires
  `<iframe class>` in allowed HTML — enforced on the format form).
- Libraries: `youtube_cookies/youtube-cookies` base + `youtube_cookies/<provider>` integration.
