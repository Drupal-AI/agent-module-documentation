<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mother May I — agent index

Requires a **secret word/phrase to initiate account creation** (block bots/strangers who don't know it).
Config at `mothermayi.settings`. Version **2.0.x** (dev). Core `^9||^10||^11`.

Anti-spam gate. **Model:** the word is a **shared, low-entropy** gate (not per-user auth) — anyone who learns
it can register, no built-in guess rate-limit. Lightweight deterrent — pair with Honeypot/CAPTCHA/flood
control; rotate if leaked. No other access role.
