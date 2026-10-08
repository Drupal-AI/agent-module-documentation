<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Posthog Analytics Integration integrates PostHog Analytics with Drupal through the PostHog PHP and JS APIs.

---

Posthog Analytics Integration integrates PostHog — product-analytics and feature-flag platform — with
Drupal via both PostHog's JavaScript (client-side events) and PHP (server-side events) APIs. It ships an
extensive set of submodules (commerce, cookies, dashboards, ECA, feature_flags, js, js_conditional_profiles,
klaro, php, php_error_tracking, php_events, webform), is configured at `posthog.settings` and provides its
own permissions, in the Analytics package.

Use it to capture analytics/feature-flags via PostHog. Security/privacy notes: it authenticates to PostHog
with an API/project key — **store it as a secret**; it is analytics/tracking, so it captures user behaviour —
disclose it in your privacy policy and gate the client-side tracking behind cookie/consent (it provides
`cookies`/`klaro` consent-integration submodules — use them); be mindful the server-side (php_events) and
JS captures may include user/behaviour data (avoid capturing PII you don't need). It has no access-control
role. Configure the PostHog project and consent integration.

---

- Integrate PostHog analytics.
- Capture client (JS) and server (PHP) events.
- Use PostHog feature flags.
- Ship many submodules (commerce/cookies/klaro/php/…).
- Configure at posthog.settings.
- Provide its own permissions.
- Store the PostHog API key as a secret.
- Disclose tracking in the privacy policy.
- Gate client tracking behind consent (cookies/klaro submodules).
- Avoid capturing unneeded PII.
- Have no access-control role.
- Configure consent integration.
- Capture product analytics.
- Handle feature flags.
- Configure the PostHog project.
- Track behaviour responsibly.
- Handle analytics privacy.
- Capture events.
- Configure PostHog.
- Integrate product analytics.
