<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

Config object: **`challenge_mitigation.settings`** (schema `challenge_mitigation.cm_settings`,
type mapping). Defaults ship in `config/install/challenge_mitigation.settings.yml`. Edited via
`ChallengeMitigationSettingsForm` (route `challenge_mitigation.settings`,
`/admin/config/challenge-mitigation/settings`, permission
`administer challenge mitigation whitelist`). Form id `cm_settings_form`.

## Install / enable
`composer require drupal/challenge_mitigation && drush en challenge_mitigation`. No required
module deps. Optional: enable contrib `captcha` to use CAPTCHA in hard mode.

## Keys (config → schema type → default → meaning)
- `enabled` (boolean, `false`) — master switch. If off, the subscriber never challenges
  (`shouldChallengeUri()` returns FALSE).
- `challenge_everywhere` (boolean, `false`) — if on, every matched main request is challenged,
  ignoring `challenge_urls`.
- `challenge_urls` (text, `""`) — one path pattern per line, matched against the full request
  URI incl. query string. `*` is a wildcard (implemented in `matchUriAgainstPatterns()`:
  `preg_quote` then `\*`→`.*`, anchored `#^…$#u`). E.g. `/user`, `/search?*`,
  `/node/*?preview=*`.
- `use_captcha_module` (boolean, `false`) — only effective in `hard` mode AND when the
  `captcha` module is enabled; adds a `#type => captcha` element to the challenge form.
- `challenge_mode` (string, `automatic_js`) — one of:
  - `automatic_js` — attaches `challenge_mitigation/challenge_js`; the submit button is hidden
    and JS auto-clicks it (transparent).
  - `hard` — visible "Validate access" submit button; CAPTCHA added if enabled.
  - `adaptive_hard` — `determineChallengeMode()` forces `hard` when the request User-Agent
    matches any regex in `adaptive_suspect_user_agents`, else `automatic_js`.
- `adaptive_suspect_user_agents` (text, `''`; form default suggests `/curl/`, `/wget/`,
  `/bot/`, `/crawler/`, `/python-requests/`) — one PHP regex per line, tested against the UA
  in adaptive mode.
- `whitelist_duration` (integer minutes, `1440`) — how long a passed IP stays whitelisted;
  drives both cron expiry (`challenge_mitigation_cron`) and the "Expiration" column.
- `skip_authenticated_users` (boolean, `0`) — if on, authenticated users are never challenged
  (`shouldSkipAuthenticatedUsers()`).
- `use_cookie_bypass` (boolean, `0`) — if on, a signed `ChallengeMitigationBypass` cookie is
  issued on pass and honored on later requests.
- `cookie_bypass_lifetime` (integer seconds, `2592000` = 30d) — validity window of the bypass
  cookie.
- `manual_ip_whitelist` (text, `''`) — one IP/CIDR per line (IPv4/IPv6/CIDR), matched with
  Symfony `IpUtils::checkIp`.
- `manual_user_agent_whitelist` (text, `''`) — one PHP regex per line; a matching UA skips the
  challenge (invalid regexes are silently skipped).

Note: two schema labels are copy-paste duplicates ("Skip authenticated users" is reused for
`use_cookie_bypass`) — cosmetic only; keys/types are correct.

## Operate
- Enable, pick paths (or `challenge_everywhere`), pick a mode, save.
- Whitelist trusted office/monitoring IPs and trusted crawler UAs to avoid friction.
- Expired entries are purged on cron; `drush cron` runs it immediately.
- Export `challenge_mitigation.settings` with site config for reproducible deploys.
