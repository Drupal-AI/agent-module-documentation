<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Password Reset Code — agent index

Password reset via an **emailed 6-digit code** (vs a link). Provides permissions. Version **1.0.3**. Core
`^10||^11||^12`.

**Correctly implemented** (reviewed) — the right way to do OTP reset: **CSPRNG** code (`random_int`),
**`hash_equals()`** compare, enforced **`max_tries`** attempt limit (default 5 → not brute-forceable),
**expiry** (default 24h), and **single-use** (deleted after a successful reset + on expiry). Keep `max_tries`
low / timeout modest; keep the reset mail path trustworthy.
