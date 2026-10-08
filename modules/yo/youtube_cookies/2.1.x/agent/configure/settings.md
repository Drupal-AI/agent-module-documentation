# Configure YouTube Cookies

## Settings form

Route `youtube_cookies.settings` → `/admin/config/system/youtube-cookies` (menu under
*Configuration » System*), permission **`administer site configuration`**. Form
`Drupal\youtube_cookies\Form\SettingsForm` editing config `youtube_cookies.settings`.

| Field | Key | Default | Notes |
|---|---|---|---|
| Enable YouTube cookies | `enabled` | `true` | Master toggle; when off, no façade/filter processing runs. |
| Cookie category | `cookie_category` | `''` | **Required.** Machine name of the consent category that must be accepted to play videos. |
| Cookie compliance system | `provider` | `''` | **Required.** `onetrust` or `eu_cookie_compliance` — selects the matching JS integration library. |
| Action when the user has not consented | `action` | `popup` | `popup` = blocking, GDPR-compliant consent pop-up. `no_cookies_domain` = swap to youtube-nocookie.com (**deprecated, not fully GDPR compliant**, slated for removal). |
| Popup message | `popup_message` | (see below) | HTML message shown in the façade pop-up. |
| Manage / Accept / Exit button labels | `button_manage` / `button_accept` / `button_exit` | `Manage cookies` / `I am OK with it` / `Exit` | Button text. |

Default `popup_message` ships as: *"This video will be loaded by YouTube, which may use your data for
tracking purposes…"* with a link to Google's privacy policy. All message/label fields are
**config-translatable** (`youtube_cookies.config_translation.yml`).

Config is created by `config/install/youtube_cookies.settings.yml`; `hook_update_N` (10001/10002)
backfill `enabled` and the button labels on older sites.

## How blocking is wired

`hook_page_attachments()` attaches JS **only when both `cookie_category` and `provider` are set**. It
attaches `youtube_cookies/<provider>` (which depends on the base `youtube_cookies/youtube-cookies`
library) and passes to `drupalSettings.youtubeCookies`: `cookieCategory`, `action`, and pre-rendered
markup for the pop-up message, buttons, and thumbnail façade.

## The three embedding integrations

All run from `youtube_cookies.module` and only when `enabled`:

1. **Media oembed field** — `hook_preprocess_field` on formatter `oembed`: for YouTube iframes, moves
   `src` → `data-src`, blanks `src`, adds classes `youtube-cookies__iframe(--oembed)`.
2. **Iframe field type** (contrib `iframe`) — same treatment for `#field_type === 'iframe'`, wrapping
   the iframe in a `youtube-cookies__iframe-container` div.
3. **CKEditor / rich text** — text-format **filter** `youtube_cookies_wysiwyg_filter`
   ("Youtube cookies filter"). Enable it on a text format (*Configuration » Content authoring » Text
   formats*). It parses the HTML (`Html::load()` + DOMXPath), and for `<iframe>` whose `src` contains
   `youtube.com`/`youtu.be`, moves `src` → `data-src`, blanks `src`, adds the wysiwyg classes.

YouTube detection is a simple `preg_match('/youtube\.com|youtu\.be/')` on the src.

## Filter + Full HTML requirement (enforced)

When the filter is enabled on a format that also uses `filter_html`, a validate handler
(`youtube_cookies_form_filter_format_*_form_alter`) requires the allowed-HTML list to include
`<iframe>` **with a `class` attribute**, erroring on save otherwise (so the façade classes survive
filtering).

## Optional: oembed_lazyload

If `oembed_lazyload` is enabled, `hook_library_info_alter` adds `oembed_lazyload/onclick` as a
dependency of the base library to keep load order correct.
