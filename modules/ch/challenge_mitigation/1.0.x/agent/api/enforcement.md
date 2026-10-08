<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Request enforcement flow

Enforcer: `ChallengeMitigationSubscriber` (service
`challenge_mitigation.challenge_subscriber`), subscribed to
`KernelEvents::REQUEST => ['onKernelRequest', 100]`. Config
`challenge_mitigation.settings` is loaded once in the constructor.

## `onKernelRequest()` decision order
Serves the challenge only if ALL guards below pass; any guard returning early lets the request
proceed normally (no challenge):

1. `shouldProcess()` — must be the main request and NOT an AJAX/XHR request
   (`$request->isXmlHttpRequest()`).
2. `shouldChallengeUri($uri)` — `enabled` must be TRUE; then `challenge_everywhere` TRUE, or
   the request URI matches a `challenge_urls` pattern (`matchUriAgainstPatterns()`, `*`→`.*`).
3. `shouldSkipAuthenticatedUsers()` — if `skip_authenticated_users` and the user is
   authenticated, skip.
4. `isCookieBypassValid()` — valid signed bypass cookie skips (see below).
5. `isWhitelistedIp($ip)` — `getClientIp()` is in `manual_ip_whitelist` (`IpUtils::checkIp`)
   OR a `cm_whitelist_ip` row with that IP exists.
6. `isWhitelistedUserAgent($ua)` — UA matches any `manual_user_agent_whitelist` regex.

If none short-circuit: the current URI is stored in session key `cm_return_url`, the
`ChallengeMitigationAccessForm` is built and rendered as a bare page (title "Challenge Access
Verification", theme `challenge_mitigation_page`), the page-cache kill switch is triggered, and
the response replaces the normal page.

## Passing the challenge — `ChallengeMitigationAccessForm`
- Form id `challenge_mitigation_access_form`; theme `challenge_mitigation_form`. If there is no
  `cm_return_url` in session it renders "Invalid challenge mitigation code."
- Mode resolved by `determineChallengeMode()`: `automatic_js` attaches
  `challenge_mitigation/challenge_js` and hides the submit button (JS auto-submits);
  `hard` shows the button and, when `use_captcha_module` + `captcha` module, adds a
  `#type => captcha`; `adaptive_hard` picks hard vs js by UA regex.
- `submitForm()` creates a `cm_whitelist_ip` entity `['ip' => getClientIp(), 'origin' =>
  'Default challenge mitigation', 'created' => now]`, optionally sets the bypass cookie, clears
  `cm_return_url`, and redirects to it via `Url::fromUserInput()`.

## Cookie bypass (HMAC)
- `setBypassCookie()` (access form): value = `time().'.'.hash_hmac('sha256', time,
  private_key)`; cookie `ChallengeMitigationBypass`, HttpOnly + Secure, SameSite=Lax, expiry
  `cookie_bypass_lifetime`.
- `isCookieBypassValid()` (subscriber): splits `timestamp.hmac`, recomputes the HMAC with the
  site `private_key`, compares with `hash_equals()`, and checks the age against
  `cookie_bypass_lifetime`.

## Cron cleanup — `challenge_mitigation_cron()`
Deletes `cm_whitelist_ip` rows whose `created` is older than
`now - whitelist_duration*60` seconds and logs `Deleted @count expired whitelist IP(s).` to
the `challenge_mitigation` logger. Trigger with `drush cron`.
