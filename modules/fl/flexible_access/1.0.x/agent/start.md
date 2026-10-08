<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flexible Access — agent index

**Grants access to entities based on configurable access rules**. Provides permissions. Version **1.0.0-beta2**.
Core `^9||^10||^11`.

**Access-control** framework — it **grants** access (can allow what core leaves denied), so an overly-broad/
misconfigured rule can **expose content**; a `forbidden` from any handler still wins. Configure rules narrowly,
test per role, verify no over-grant (esp. unpublished/private). Composes with core entity access.
