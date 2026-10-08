<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confetti Falling — agent index

**Falling-confetti front-end effect** shown on pages matching a configured CSS class. Version **1.0.x**.
Core `^9.3 || ^10`. No dependencies.

Single admin settings form at `/admin/config/confetti_falling_settings` (`administer site configuration`) to set
the trigger class; attaches a JS library. Purely decorative/client-side — no data handling, no callbacks, no
untrusted input. Negligible security surface.
