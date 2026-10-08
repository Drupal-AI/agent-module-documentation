<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Orejime

Two layers: **global banner settings** (`orejime.settings` config, form `OrejimeSettingsForm`,
route `orejime_service.settings`) and **consent services** (`orejime_service` entities at
`/admin/content/orejime_service`).

## Global settings (`orejime.settings`)

Defaults from `config/install/orejime.settings.yml`; schema `orejime.schema.yml`.

| Key | Default | Meaning |
|---|---|---|
| `cookie_name` | `orejime` | Name of the consent cookie. |
| `expires_after_days` | `365` | Consent cookie lifetime (days). |
| `cookie_domain` | `''` | Optional cookie domain (e.g. share across subdomains). |
| `privacy_policy` | `''` (required in form) | Link to the privacy-policy page. |
| `must_consent` | `0` | Open the modal and block closing until the user consents/declines. |
| `must_notice` | `0` | Keep the notice until acknowledged (ignored if `must_consent`). |
| `analytics` | `''` | Comma-separated Google UA codes to manage/opt-in. |
| `orejime_css` | `https://unpkg.com/orejime@2.3.2/dist/orejime.css` | Library CSS URL (external by default; set a local path to self-host). |
| `orejime_js` | `https://unpkg.com/orejime@2.3.2/dist/orejime.js` | Library JS URL (external by default). |
| `texts` | `''` | Orejime translations YAML (validated with `Yaml::parse`; overrides library strings). |
| `iframe_consent` | (unset) | Enable the `<iframe-consent>` tag flow (loads `orejime_iframe_consent.js`; drives `OrejimeResourceFetcher`). |
| `logo` | (unset) | Optional image URL shown in the notice. |
| `debug` | `0` | Log missing-translation warnings to the browser console. |
| `color.*` | palette | When `color.enable`, colours are compiled into a generated CSS file at `public://orejime/…` (`color.url_css`). |
| `request_path` | `{pages: '/admin/*', negate: 0}` | RequestPath ignore condition — banner is suppressed on matched pages (`OrejimeManager::ignoreCurrentPage()`). |
| `categories` | `{}` | Visual groupings (name/title/description/apps/weight) added on the settings form. |

## Consent service entity (`orejime_service`)

Content entity (bundle `orejime_system`), revisionable + translatable. Fields (per README):

- `name` — system name (links config to scripts via `data-name`).
- `label`, `description`, `purposes` (comma-separated).
- `cookies` — cookies this service sets; deleted automatically on consent withdrawal
  (token `{ga}` available for the GA UA code).
- `scripts` — filenames of already-registered JS to gate (see below); one per line.
- `required` — strictly-necessary (cannot be declined); `default` — pre-enabled in the modal.
- published status — unpublished services do not appear in the banner.

Only **published** services are pushed to `drupalSettings.orejime.manage`
(`OrejimeManager::getServicesManage()`) for the library to render.

## How scripts get gated (opt-in)

1. **Automatic (GA/GTM):** `hook_page_attachments_alter` sets `type="opt-in"`, `data-name="tracking"`,
   `data-src` on Google Analytics / `google_tag_script_tag__*` head scripts.
2. **Automatic (matching assets):** `hook_js_alter` → `OrejimeManager::setOptIn()` finds registered JS
   whose path matches a service's `scripts` entry and rewrites it to opt-in (`preprocess=FALSE`,
   `data-src`, `data-name=<service>`). `JsCollectionRendererOrejime` emits the `data-src` attribute.
3. **Manual:** author marks inline/external `<script type="opt-in" data-type="application/javascript"
   data-name="<service>" [data-src="…"]>` in templates, or use `<iframe-consent src=… poster=…>`.

Note: the `scripts` field references **existing** site JS by filename to gate it — it does not inject
new arbitrary script URLs into the page.
