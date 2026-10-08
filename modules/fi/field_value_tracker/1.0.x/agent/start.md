<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Value Tracker — agent index

**Tracks and changes field values between environments** — documented use: different **login URLs and email
addresses** per environment. Depends on core `field`, `options`, `system`. Provides permissions. Version
**1.0.0-beta1**. Core `^11`.

Administration/deployment — manages **sensitive per-env values** (login URLs/emails): restrict the permission,
avoid cross-pointing prod/non-prod, keep secret-adjacent values out of exported config. No access role beyond
permission.
