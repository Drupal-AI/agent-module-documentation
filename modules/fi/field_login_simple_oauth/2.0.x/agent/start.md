<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Login & Simple OAuth Password Grant — agent index

**OAuth password grant authenticating by a login field**. Version **2.0.0**. Core `^10.3||^11`.

Positive: still verifies the password via `userAuth->authenticateAccount()` (no bypass). Depends on `simple_oauth`, `field_login`.