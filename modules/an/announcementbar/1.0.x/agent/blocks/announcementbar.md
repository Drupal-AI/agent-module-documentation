<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `announcementbar` block

Source: `src/Plugin/Block/AnnouncementbarBlock.php`, `announcementbar.module`,
`announcementbar.install`, `templates/announcementbar-template.html.twig`,
`js/announcementbar.js`, `css/announcementbar.css`, `announcementbar.libraries.yml`.

## Install / enable

```
drush en announcementbar -y
```

Requires core **Block** (declared `dependencies: [drupal:block]`). No composer requirements beyond
core. Then place the block: **Structure → Block layout → Place block → "Announcementbar"** (permission
`administer blocks`). There is no admin config route — despite the README's mention of a
"Configuration → Announcementbar" page, the module ships no such route; all settings are on the block.

## Block plugin

`AnnouncementbarBlock extends BlockBase`, annotated:

```php
@Block(
  id = "announcementbar",
  admin_label = @Translation("Announcementbar"),
)
```

No `blockAccess()` override, so it uses core's default block access (visibility conditions +
`administer blocks` to configure). No `defaultConfiguration()` — all values default to `''` via
`isset()` checks.

### `blockForm()` fields

| Form key | `#type` | Notes |
|---|---|---|
| `announcementbar[message]` | textarea | required |
| `announcementbar[button]` | textfield | required; CTA button label |
| `announcementbar[position]` | select | options `top`, `bottom`; `#empty_option` "-None-" |
| `announcementbar[background]` | color | hex background color |
| `announcementbar[color]` | color | hex message/text color |
| `announcementbar[fieldset][interval]` | number | required; cookie duration amount |
| `announcementbar[fieldset][period]` | select | options `Minutes`, `Hours`, `Days` |

`blockSubmit()` writes these to block config via `setConfigurationValue()` under the flat keys
`message`, `button`, `position`, `background`, `color`, `interval`, `period`.

### `build()`

Returns a render array `#theme => 'announcementbar_template'` passing each config value as
`#message`, `#button`, `#position`, `#background`, `#color`, `#interval`, `#period` (each defaulting
to `''`).

## Theme + hooks (`announcementbar.module`)

- `announcementbar_theme()` — registers `announcementbar_template` with variables `message`, `button`,
  `position`, `background`, `color`.
- `announcementbar_page_attachments()` — attaches library `announcementbar/announcementbar` and sets
  `drupalSettings.announcementbar.interval` / `.period` from config **`block.block.announcementbar`**.
- `announcementbar_preprocess_block()` — for `plugin_id == 'announcementbar'`, reads
  `block.block.announcementbar` and sets `attributes.class[] = 'announcement-bar-wrapper'` plus an
  inline `style` of `background-color:<bg>; position:fixed; <position>:0px;`.
- `announcementbar_help()` — help page text at `help.page.announcementbar`.

## Template (`announcementbar-template.html.twig`)

Renders a `div.announcement-bar-wrapper-content` containing `div#announcement-bar-content` with
`{{ message }}` (Twig **autoescapes** it) and a `<button id="announcement-bar-btn">{{ button|t }}</button>`.
Inline styles apply `background`/`color`; when `position` is set it adds `position:fixed; <position>:0px;`.

## Dismiss behavior (`js/announcementbar.js`)

`Drupal.behaviors.announcementbar` reads `drupalSettings.announcementbar.interval`/`.period`, then:

- On attach: if cookie `announcement-bar` is **not** present, `$('.announcement-bar-wrapper').show()`;
  otherwise `.hide()`.
- On `#announcement-bar-btn` click: `setCookie()` writes `announcement-bar=1` with an expiry computed
  from `interval` × the period unit (Minutes/Hours/Days), then slide-toggles the bar closed.

So the bar reappears once the cookie expires after the configured interval/period.

## Config export example (block instance)

```yaml
# block.block.announcementbar.yml (settings excerpt)
settings:
  id: announcementbar
  label: 'Announcement Bar'
  provider: announcementbar
  message: 'We use cookies to improve your experience.'
  button: 'Got it'
  position: top
  background: '#222222'
  color: '#ffffff'
  interval: 2
  period: Days
```

## Operating notes

- **Match the block id to `announcementbar`.** `page_attachments`/`preprocess_block`/`uninstall`
  hardcode `block.block.announcementbar`. If the placed block's machine id differs (Drupal usually
  auto-generates `<theme>_announcementbar`), the banner still renders but its cookie interval/period
  come through as `undefined` (bar reappears every page load) and the fixed-position preprocess style
  is not applied. Place/rename the block so its id is exactly `announcementbar` to get full behavior.
- **Uninstall** deletes `block.block.announcementbar` only; a differently-named block instance must be
  removed manually.
- CSS lives in `css/announcementbar.css`; override in your theme for spacing/typography.
