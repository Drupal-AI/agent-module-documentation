<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Allow disabling the itok token per image style.

---

Itok Config allows disabling the `itok` token per image style — the `itok` query token is a core anti-DoS signature on image-style derivative URLs; this module lets a site turn it off for chosen image styles (e.g. for predictable/CDN-friendly URLs), a deliberate trade-off. Disabling itok makes derivative URLs guessable, so only do it for styles where that's acceptable. Depends on core `image`; supports Drupal 9, 10, and 11.

---

- Disable the itok token per style.
- Give predictable derivative URLs.
- Suit CDN-friendly setups.
- Trade off the anti-DoS signature.
- Apply per image style.
- Note itok's DoS-protection role.
- Depend on core `image`.
- Support Drupal 9, 10, and 11.
- Configure per style.
- Aid CDN caching.
- Handle itok.
- Control tokens
- Support Drupal.
- Support Drupal.
- Support Drupal.
