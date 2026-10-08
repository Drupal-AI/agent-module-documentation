<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# No Bots (nobots) — agent index

**Adds an `X-Robots-Tag: noindex,nofollow,noarchive` response header when enabled via settings.php or state.**

- **Version:** 1.0.x (release 1.0.1)
- **Core:** ^10.1 || ^11
- **Service:** `nobots.finish_response_subscriber` (`FinishResponseSubscriber`, `KernelEvents::RESPONSE`)
- **Switches:** `Settings::get('nobots')` (settings.php) OR `\Drupal::state()->get('nobots')` — either truthy value activates it
- **Enable at runtime:** `drush state:set nobots 1`; **per environment:** `$settings['nobots'] = TRUE;`
- No routes, permissions, or forms.

**Security:** Response-header only; no routes, no user input, no mutating or anonymous endpoints. It merely advises compliant crawlers (does not hard-block access). Operational care needed so production is not accidentally de-indexed. No security findings.
