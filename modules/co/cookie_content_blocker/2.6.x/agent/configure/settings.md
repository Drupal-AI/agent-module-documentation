<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Cookie Content Blocker

Admin UI lives under **Configuration → User interface → Cookie Content Blocker**
(`/admin/config/user-interface/cookie-content-blocker`). The `configure` route is
`cookie_content_blocker.settings` (settings form), plus a Cookie categories list.

## Global settings — `cookie_content_blocker.settings`

Form: `BlockerSettingsForm` (perm `administer cookie content blocker`). Config keys (defaults from
`config/install/cookie_content_blocker.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `blocked_message` | text | "You have not yet given permission…" | Default message shown on a blocked placeholder. |
| `show_button` | bool | `true` | Show a consent-change button under the message. |
| `button_text` | string | `Show content` | Button label. |
| `enable_click_consent_change` | bool | `true` | Clicking the blocked content itself counts as consent (when no button). |
| `consent_awareness` | map | empty | How to detect consent from the external manager — see below. |

### `consent_awareness` — mapping the external consent manager

The module has **no consent logic**; you tell it how your consent manager signals state. Three
groups — `accepted`, `declined`, `change` — each holding an `event` (`name`, `selector`) and/or a
`cookie` (`operator`, `name`, `value`). Emitted to the browser via
`drupalSettings.cookieContentBlocker.consentAwareness` (see `cookie_content_blocker_page_attachments`).
Set at least one accepted signal, or nothing ever un-blocks.

## Cookie categories — `cookie_content_blocker_category` config entity

List/add/edit/delete at `…/cookie-content-blocker/categories` (perm
`administer cookie content blocker categories`; entity `admin_permission` is the same). Each category
(`CookieContentBlockerCategory`) exports: `id`, `label`, `description`, `blocked_message`,
`button_text`, `enable_click_consent_change`, `show_button`, `consent_awareness`. Assign a category to
blocked content (filter `data-settings` `category`, or the render property `category`) so it reveals
only when that category's signal fires. Per-category consent awareness is passed as
`drupalSettings.cookieContentBlocker.categories[<id>].consentAwareness`.

## Text filter — `cookie_content_blocker_filter`

Enable on a text format (**Configuration → Content authoring → Text formats and editors**). It
converts `<cookiecontentblocker data-settings="…">…</cookiecontentblocker>` tags into blocked
placeholders. It is `TYPE_TRANSFORM_IRREVERSIBLE`; **run it last**. The wrapped HTML is emitted as-is
(`Markup::create`) — the filter depends on the format's OTHER filters (e.g. Limit allowed HTML) to
sanitize the content, so do not grant this filter on a format that permits untrusted raw HTML/JS to
low-trust authors. `data-settings` may be raw JSON or base64-encoded JSON; it is run through
`Xss::filter($settings, [])` then `json_decode` before use.

## CKEditor 5 button

`cookie_content_blocker.ckeditor5.yml` adds a **CookieContentBlocker** toolbar item that wraps the
selection in the custom tag with a settings dialog. A CKEditor 4→5 upgrade plugin is included. Add the
button to a text format's CKEditor 5 toolbar and enable the filter on the same format.

## Front-end library

`cookie_content_blocker_page_attachments` unconditionally attaches
`cookie_content_blocker/cookie-content-blocker` (depends on `js_cookie`) plus the consent-awareness
settings on every page.
