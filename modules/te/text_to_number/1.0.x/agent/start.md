<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text To Number (text_to_number) — agent index

**Adds a textfield widget for integer fields that maps "Missing" to NULL instead of 0.**

- **Version:** 1.0.x (info.yml: 1.0.0)
- **Core:** `^8 || ^9 || ^10 || ^11`
- **Provides:** field widget `text_to_number_text` (`FieldWidget` for field type `integer`), class `TextNumberWidget`.
- **Behaviour:** renders a textfield; static `validate()` maps empty→'', `Missing`/`missing`→NULL, otherwise `preg_replace('/[^0-9]/','',$value)` (digits only). One widget setting: textfield `size`.
- **Config:** none — "The module has no menu or modifiable settings" (README).
- **Security:** No routes, permissions, services, or external I/O. Server-side element validation sanitizes input to digits/NULL. No security-relevant surface. (Note: digit-strip removes a leading minus, so negatives aren't preserved.)
