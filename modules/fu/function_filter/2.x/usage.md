<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A text filter replacing [function:*] tokens with the result of registered functions.

---

Function Filter adds a text filter to replace tokens `[function:*]` with the result of a function — so content can embed dynamic values computed by a function (e.g. `[function:site_name]`).

Security: it is NOT arbitrary code execution — only functions that modules explicitly register via `hook_filter_functions` are callable, and the token's function name is sanitised (`[^a-z0-9_]` stripped) and looked up in that registry; unknown names do nothing. Enable the filter only on trusted text formats. Supports Drupal 8 through 11.

---

- Replace [function:*] tokens.
- Compute values via functions.
- Embed dynamic values in content.
- Call only registered functions.
- Use `hook_filter_functions` (allowlist).
- Sanitise the function name.
- Do NOT allow arbitrary code exec.
- Enable on trusted formats.
- Depend on Drupal core only.
- Support Drupal 8 through 11.
- Aid content authors.
- Handle the filter
- Support Drupal.
- Support Drupal.
- Support Drupal.
