<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CAPTCHA Pack — challenge types

Every type is a submodule implementing `hook_captcha($op, $captcha_type)`:
- `$op == 'list'` returns the type label(s).
- `$op == 'generate'` returns `['solution' => ..., 'form' => [...]]`.

The **CAPTCHA module** stores the returned `solution` server-side and validates the user's
`captcha_response` against it during form validation. These modules only produce the challenge —
validation/enforcement is not client-side.

Types:
- **math_captcha** — arithmetic questions (`math_captcha.challenge.inc`), enabled challenges are
  configurable.
- **text_captcha** — shared text-processing base; submodules `lost_character_captcha`,
  `phrase_captcha`, `word_list_captcha`.
- **css_captcha** — text obfuscated with CSS.
- **ascii_art_captcha** — figlet-style rendered text (many bundled fonts).
- **foo_captcha** — user must type "foo" (demo/very weak).
- **random_captcha_type** — meta type that randomly delegates to another configured type.

Each active challenge triggers `page_cache_kill_switch` so the form page is not cached. Assign a type
to a form under `/admin/config/people/captcha` (provided by the CAPTCHA module).
