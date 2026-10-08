<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Challenge Mitigation serves a one-time challenge to anonymous visitors on selected paths and, once passed, whitelists their IP for a configurable duration.

---

Challenge Mitigation is an application-layer anti-abuse module for Drupal 10 and 11. A KernelEvents::REQUEST subscriber (`ChallengeMitigationSubscriber`) inspects incoming main requests; when the module is enabled and the request URI matches a configured pattern (or "challenge everywhere" is on), the visitor is served a challenge page instead of the requested content. Passing the challenge creates a `cm_whitelist_ip` entity for the client IP, so subsequent requests from that IP skip the challenge until the entry expires (default 1440 minutes / 24 hours), after which `hook_cron()` deletes it. It supports three challenge modes — transparent Automatic JS (a hidden form auto-submitted by JavaScript), Hard (a manual submit button, optionally backed by the contrib CAPTCHA module), and Adaptive Hard (forces Hard for User-Agents matching admin regexes, otherwise Automatic JS). Administrators can pre-allow traffic with a manual IP list (IPv4/IPv6/CIDR, matched via Symfony `IpUtils`) and a manual User-Agent regex list, optionally skip authenticated users, and optionally issue an HMAC-signed bypass cookie so a passing browser is remembered. All admin screens live under Configuration > Security > Challenge Mitigation and are gated by the single "administer challenge mitigation whitelist" permission. The maintainers explicitly note the module is a pragmatic lightweight layer, not a substitute for a dedicated WAF.

---

- Require and enable the module: `composer require drupal/challenge_mitigation` then `drush en challenge_mitigation`.
- Protect a specific exposed path such as `/user`, `/search` or `/contact` from anonymous automated traffic.
- Protect several paths at once by listing one pattern per line in the Challenge URLs textarea.
- Use `*` wildcards in path patterns (e.g. `/search?*`, `/node/*?preview=*`) matched against the full request URI including query string.
- Turn on "challenge everywhere" to gate the entire site rather than named paths.
- Choose Automatic JS mode for a transparent challenge that requires no visitor interaction.
- Choose Hard mode to require an explicit form submission.
- Enable the contrib CAPTCHA module and "Use CAPTCHA module integration" to require a real CAPTCHA in Hard mode.
- Choose Adaptive Hard mode to force the hard challenge only for suspicious User-Agents (e.g. `/curl/`, `/bot/`, `/python-requests/`).
- Tune how long a passing IP stays whitelisted via "Whitelist duration (in minutes)".
- Let expired whitelist entries be cleaned automatically on cron, or run `drush cron` to purge them now.
- Pre-allow trusted office or monitoring IPs with the manual IP whitelist (supports single IPv4/IPv6 addresses and CIDR ranges).
- Pre-allow trusted crawlers, uptime checks or CDN health probes with User-Agent regex patterns in the manual User-Agent whitelist.
- Skip the challenge entirely for logged-in users by enabling "Skip authenticated users".
- Issue a signed bypass cookie after a pass so returning browsers from the same device are not re-challenged.
- Control how long the bypass cookie stays valid via "Cookie bypass lifetime (in seconds)".
- Review and search currently whitelisted IPs, their origin, creation and expiration times, at the Whitelist IPs admin list.
- Filter the whitelist admin list by IP substring, and delete individual entries manually.
- Grant a security/operations role the "administer challenge mitigation whitelist" permission to manage the feature.
- Soft-gate traffic to reduce spam and scraping without forcing login or hard rate limits.
- Export the `challenge_mitigation.settings` config with your site's configuration for reproducible deployments.
- Adapt the challenge page and message by overriding the `challenge-mitigation-page.html.twig` / `challenge-mitigation-form.html.twig` templates in your theme.
