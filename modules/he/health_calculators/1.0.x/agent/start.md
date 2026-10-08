<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Body Health Calculators (health_calculators) — agent index

**Empty umbrella/package module; the functionality lives in its submodules (this release: `caffeine_calculator`).**

- **Version:** 1.0.x
- **Core:** `^9 || ^10`
- **Package:** BodyHealthCalculators
- **Submodule:** `caffeine_calculator` (see `modules/caffeine_calculator/`).
- No routes, permissions, services or config of its own; `.module` is empty.

**Security:** no routes or endpoints of its own — nothing to enforce. Access posture is defined by whichever calculator submodule you enable.
