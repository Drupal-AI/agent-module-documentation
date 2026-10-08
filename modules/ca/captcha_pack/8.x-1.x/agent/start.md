<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAPTCHA Pack (captcha_pack) — agent index
**Bundle of lightweight non-image CAPTCHA challenge types (math, text, CSS, ASCII-art, random) for the CAPTCHA module.**

- **Version:** 8.x-1.x
- **Core:** ^9.5 || ^10
- **Depends on:** `captcha:captcha`
- **Submodules:** math_captcha, text_captcha (+ lost_character_captcha, phrase_captcha, word_list_captcha), css_captcha, ascii_art_captcha, foo_captcha, random_captcha_type.
- **Mechanism:** each implements `hook_captcha()` returning a `solution`; the CAPTCHA module validates responses **server-side**. Challenge pages use `page_cache_kill_switch`.
- **Admin:** challenge assignment/settings under `/admin/config/people/captcha` (CAPTCHA module).
- **Security:** Enforcement is server-side (solution stored/validated by CAPTCHA core), not client-side. These are lightweight deterrents (foo/math are trivially solvable), not strong bot protection. No custom mutating/anonymous endpoints of concern.

See [plugins/captcha-types.md](plugins/captcha-types.md)
