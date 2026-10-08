<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Klaviyo CRM — agent index

**Integrates Drupal with the Klaviyo marketing/CRM platform** (syncs contacts/events, Klaviyo form blocks). Depends
on core `block`, `webform`. Provides permissions. Version **1.0.6**. Core `^10||^11`.

Integration/marketing — sends **contact PII + events to the Klaviyo API** (egress — disclose); **API key** as a
secret (env/Key, HTTPS). No access role beyond permission.
