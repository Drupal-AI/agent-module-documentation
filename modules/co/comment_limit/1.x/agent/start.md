<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Comment Limit (comment_limit) — agent index

Caps the **number of comments a user may post per comment field**. Version **dev**.
Core `^9 || ^10 || ^11`.

Anti-flood/anti-abuse guardrail enforced at submission. Blunt (counts comments, not quality) — set
high enough for genuine discussion, and pair with moderation/CAPTCHA; it reduces volume-based abuse
but doesn't replace them.