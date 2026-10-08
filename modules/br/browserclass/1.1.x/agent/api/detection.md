<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Detection: body classes, tokens, and the API

## Body classes (client side)
`browserclass_page_attachments_alter()` attaches `browserclass/global-browserclass` on every page.
The JS (`js/browserclass.js` → minified) parses `navigator.userAgent.toLowerCase()` and pushes
classes onto `<body>`:
- **Browser:** `ie` (+ `ie<major>`), `chrome` (+ `chrome<major>`), `safari` (+ version), `ff`
  (+ `ff<major>`), `opera`/`operamini` (+ version), `netscape`, `konqueror`, `dillo`, `chimera`,
  `beonex`, `aweb`, `amaya`, `icab`, `lynx`, `galeon`.
- **Platform:** `win`, `mac`, `linux`, `android`, `iphone`, `ipad`, `ipod`, `nokia`, `blackberry`,
  `freebsd`, `openbsd`, `netbsd`.
- **Device:** always exactly one of `mobile` / `desktop` (mobile if the UA matches a known mobile
  device or the wap/smartphone/kindle/… regex).

Version numbers are trimmed to the major digits before the first `.` (`_browserclass_clear_version`).

## Server-side tokens (`browserclass.tokens.inc`)
`hook_token_info()` + `hook_tokens()` compute the same class lists from `$_SERVER['HTTP_USER_AGENT']`
via `browserclass_get_classes()` and return them **`Html::escape()`-sanitized**:

| Token | Returns |
|---|---|
| `[browserclass:browser-classes]` | full space-separated class list |
| `[browserclass:browser]` | browser class(es) only |
| `[browserclass:platform]` | platform class(es) only |
| `[browserclass:device]` | `mobile`/`desktop` |
| `[browserclass:hook-classes]` | extra classes from the `browserclass_classes` hook |
| `[user:browserclass]`, `[site:browserclass]` | full class list (also chainable to `browserclass:*`) |

## API — `browserclass_get_classes($types = BROWSERCLASS_ALL): array`
Returns the class array server-side. `$types` is a bitmask of `BROWSERCLASS_BROWSER` (1),
`BROWSERCLASS_PLATFORM` (2), `BROWSERCLASS_MOBILE` (4), `BROWSERCLASS_OTHER_CLASSES` (8), or
`BROWSERCLASS_ALL`. Returns `[]` when no `HTTP_USER_AGENT` is present (e.g. RSS readers).
Helpers: `browserclass_check_browser($agent)`, `browserclass_check_platform($agent)`,
`browserclass_is_mobile_device($agent, $classes)`.

## Extension hook — `hook_browserclass_classes($agent)`
Invoked (single `moduleHandler()->invoke('browserclass_classes', $agent)`) when
`BROWSERCLASS_OTHER_CLASSES` is requested. Return an array of extra classes to merge in; they surface
in `[browserclass:hook-classes]`.

## Notes
- This is user-agent sniffing aimed at legacy/edge browsers — use for styling hooks, not feature
  detection. Token output is server-side (`HTTP_USER_AGENT`); the `<body>` classes are client-side
  (`navigator.userAgent`), so cached pages still get correct body classes.
