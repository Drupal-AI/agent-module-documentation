<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Password Reveal — agent index

Adds a **show/hide toggle** to password fields — **passwords are SHOWN (plaintext) by default**.
Version **2.0.3**. Core `^9||^10||^11`.

**Caveat:** default-plaintext increases shoulder-surfing exposure (offices, kiosks, screen-shares).
Front-end UX only (no server-side access behaviour). Consider whether masked-by-default is safer for
your forms.
