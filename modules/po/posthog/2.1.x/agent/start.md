<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Posthog Analytics Integration — agent index

Integrates **PostHog** product analytics + feature flags (JS client + PHP server APIs). Many submodules
(commerce/cookies/dashboards/eca/feature_flags/js/klaro/php/php_error_tracking/php_events/webform). Config at
`posthog.settings`; provides permissions. Version **2.1.3**. Core `^10.3||^11`.

**Privacy/security:** store the PostHog API key as a **secret**; it's tracking — disclose in the privacy
policy, gate client tracking behind **consent** (use the `cookies`/`klaro` submodules), avoid unneeded PII.
No access role.
