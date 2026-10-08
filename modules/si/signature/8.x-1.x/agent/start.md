<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Signature — agent index

Enables a **user signature** field (users store a signature, commonly appended to posts). Version **8.x-1.1**.
Core `^9||^10||^11`.

Content-editing/fields — the signature is **user-entered content** shown to others; filter it through a
**restricted text format** (prevent stored XSS via signature HTML); may contain PII. No access role.
