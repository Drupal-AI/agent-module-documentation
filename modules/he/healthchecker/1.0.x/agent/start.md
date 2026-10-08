<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Health Checker — agent index

Provides a **lightweight health-check endpoint** returning a minimal `{"status":"OK"}` (uptime/load-balancer
liveness probe). Provides permissions. Version **1.0.0-beta4**. Core `^8||^9||^10||^11`.

Operations — returns **only a minimal status** (no version/sensor disclosure), so public exposure reveals only
that the site is up; gate via permission/non-guessable path if preferred. No access role beyond permission.
