<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Secret Registration Code — agent index

**Provides a secret code field on the user registration form** (invite-code gating). Provides permissions. Version
**1.0.0**. Core `^9||^10||^11`.

Access/registration-hardening — the code is a **shared secret**: a weak/leaked code opens registration to anyone.
Use a strong, rotated, non-public code; pair with email verification/approval/flood control/CAPTCHA. Layers on core
registration.
