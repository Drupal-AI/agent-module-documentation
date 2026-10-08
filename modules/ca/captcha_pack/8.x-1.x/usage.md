<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CAPTCHA Pack provides several lightweight, non-image CAPTCHA challenge types (math, text-manipulation, CSS-obfuscated, ASCII-art, and a random meta-type) for the CAPTCHA module.
---
Each type is a submodule that implements `hook_captcha()` and returns a challenge plus its `solution`. The CAPTCHA module stores the solution server-side (in its captcha_sessions store) and validates the submitted response against it during form validation — so enforcement is server-side and does not rely on client JavaScript. Submodules include `math_captcha` (arithmetic questions), `text_captcha` with its own submodules `lost_character_captcha`, `phrase_captcha` and `word_list_captcha`, `css_captcha` (CSS-obfuscated text), `ascii_art_captcha` (figlet-style rendered text), `foo_captcha` (type the word "foo"), and `random_captcha_type` (randomly delegates to another configured type).

These are meant as low-bandwidth, low-CPU, accessibility-friendlier alternatives to image CAPTCHAs, not as strong anti-bot protection — several (e.g. foo/math) are trivially solvable and are intended for basic spam deterrence. Each submodule has an admin settings form under `/admin/config/people/captcha` (part of the CAPTCHA module's admin area) and pages are marked uncacheable while a challenge is active (`page_cache_kill_switch`). Setup is: install the CAPTCHA module, enable the desired pack submodules, then assign a challenge type to the target forms in CAPTCHA's admin UI.
---
- Add a math (arithmetic) CAPTCHA to a form.
- Require users to enter a manipulated text phrase.
- Use CSS-obfuscated text as a CAPTCHA.
- Render an ASCII-art (figlet-style) challenge.
- Randomly pick a CAPTCHA type per submission.
- Protect the user registration form from bots.
- Add spam deterrence to a webform/contact form.
- Choose lightweight CAPTCHAs where images are undesirable.
- Configure math challenge operations (add/subtract/multiply).
- Enable phrase or word-list text challenges.
- Use the "lost character" text challenge variant.
- Assign a CAPTCHA type per form in CAPTCHA admin.
- Improve accessibility vs. image CAPTCHAs.
- Reduce bandwidth/CPU vs. image generation.
- Rely on server-side solution validation via CAPTCHA.
- Combine multiple pack types across different forms.
- Deter comment spam on anonymous forms.
- Keep challenge pages uncacheable while active.
- Enable only the challenge submodules you need.
- Delegate to random_captcha_type for variety.
