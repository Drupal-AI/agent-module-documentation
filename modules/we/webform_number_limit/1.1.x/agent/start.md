<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Number Limit — agent index

Limits webform submissions based on the **running sum of a number element's values** (stop accepting when the
cumulative total hits a threshold — limited-quantity/capped-total signups). Depends on `webform`. Version
**1.1.0**. Core `^9||^10||^11`.

Forms/validation — enforces a sum-based cap on submissions; no access role.
