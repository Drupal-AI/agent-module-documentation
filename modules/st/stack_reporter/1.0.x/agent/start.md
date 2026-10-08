<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stack Reporter — agent index

Provides an **API-key-gated `/api/v1/stack-reporter` endpoint reporting Drupal/PHP/Node versions** to the
StackReporter service. Provides permissions. Version **1.0.2**. Core `^9||^10||^11`.

Monitoring/integration — endpoint gated by API key (`$externalKey && $internalKey === $externalKey` — **no
empty-key bypass**). Discloses a **version fingerprint** to key holders (keep the key secret); key compare is
`===` (minor: not constant-time). No other access role.
