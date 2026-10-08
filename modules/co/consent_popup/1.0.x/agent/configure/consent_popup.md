<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Consent Popup

There is **no admin settings page**. All configuration is the block's own configuration, edited
when you place or edit the **Consent Popup** block (`admin_label` "Consent Popup", category
"Custom") at `/admin/structure/block`. Editing requires core's **`administer blocks`** permission.
Settings persist in the block config entity and export with your configuration; the module ships
**no `config/install` defaults and no config schema** (harmless schema-validation notices may
appear). Defaults below are the code fallbacks used until you save the form.

## Placement

Add the block to any region (a `page_bottom`/footer region is typical — the popup is a
`position: fixed` full-screen overlay, so the region only affects DOM order). Standard block
**visibility conditions** (pages, roles, content types) apply, so you can limit the popup to
specific pages or audiences. The overlay only appears while the cookie is not yet `true`.

## Per-language text (repeated once per site language)

Under a collapsible `details` group named for each language, keyed by the langcode; `build()`
renders the current language's set:

| Key | Field | Default | Notes |
|---|---|---|---|
| `text` | Popup Text (textarea, required) | "Are you an adult?" | The message. Passed through `Xss::filterAdmin()` then rendered in `<h2>`. |
| `text_decline` | Declined Text (textarea, required) | "You can't access this page" | Shown after Decline (non-redirect). Passed through `Xss::filterAdmin()`, delivered via `drupalSettings`, injected by JS. |
| `accept` | Accept button text (required) | "Yes" | Auto-escaped. |
| `decline` | Decline button text (required) | "No" | Auto-escaped. |
| `decline_link.decline_url` | Link url if declined (required) | site front page | Internal path or external `http(s)://` URL; the hidden "keep browsing" link and the redirect target. |
| `decline_link.decline_url_text` | Text for url if declined (required) | "Keep browsing our site" | Auto-escaped link label. |

## Behaviour options (site-wide)

| Key | Field | Default | Effect |
|---|---|---|---|
| `non_blocking` | Non blocking (checkbox) | off | On Decline, set cookie to `true` and let the visitor stay on / use the page. When off, decline keeps the overlay up (page blocked). |
| `redirect` | Redirect on declined (checkbox) | off | On Decline, `window.location.replace()` to the decline URL (after a 500 ms delay so the cookie is written). |

## Cookie

| Key | Field | Default | Notes |
|---|---|---|---|
| `cookie.cookie_name` | Cookie Name (required) | `consent_popup` | The `document.cookie` name checked/set. Changing it re-shows the popup to everyone. |
| `cookie.cookie_life` | Cookie life time (number, days) | `7` | Expiry set to now + N days; a `true` value suppresses the popup for that window. |

## Design

| Key | Field | Default | Notes |
|---|---|---|---|
| `design.color` | Background Color (color picker) | `#000000` | Overlay tint. `build()` parses the hex with `sscanf(..., "#%02x%02x%02x")`. |
| `design.color_opacity` | Background Opacity (select 0–1 by 0.1) | `8` (→ 0.8) | Stored as the tenths value; `build()` divides by 10 and composes `rgb(r g b / opacity)` into the `--consent-popup-bg-color` CSS variable. |
| `design.blur` | Elements to blur (CSS selectors, comma-separated) | empty | Each selector matched by jQuery; matched elements get class `blurred-element` (7px blur) while the popup is open. |

## Runtime flow (what `build()` and the JS do)

1. `build()` picks the current language's text set, filters `text`/`text_decline` with
   `Xss::filterAdmin()`, resolves `decline_url` (external URL kept as-is; otherwise
   `Url::fromUserInput('/' . ltrim(path))` → absolute), composes the overlay colour, and attaches
   the `consent_popup/consent_popup` library plus a `drupalSettings.consent_popup` payload
   (`cookie_life`, `cookie_name`, `bg_color`, `text_decline`, `to_blur`, `non_blocking`,
   `redirect`, `redirect_url`).
2. `Drupal.behaviors.consent_popup` reads the cookie by name. If it is not `true`, it opens the
   overlay (`body.consent-popup-opened`), blurs the configured selectors, and wires the buttons.
3. **Accept** → `cookie=true` (expires in `cookie_life` days), remove `consent-popup-opened`
   (overlay closes). **Decline** → cookie `true` if `non_blocking` else `false`; then redirect
   (if `redirect`) or replace the message with `text_decline` + reveal the link, leaving the
   overlay up.

## Drush / programmatic

No Drush commands and no dedicated config object. Read or set values through the block config
entity, e.g. `drush config:get block.block.<block_id> settings`.
