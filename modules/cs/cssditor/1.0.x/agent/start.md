<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cssditor / custom_css_adder — agent orientation

Adds a per-theme CSS editor to Appearance settings. **Machine name is `custom_css_adder`**; project is `cssditor`.

- Editing gated by theme settings form (`administer themes`) — trusted admins only.
- CSS saved to `public://custom_css_adder/<theme>.css` + config `custom_css_adder.theme.<theme>`; attached at weight 9999.
- CAVEAT: `src/Theme/ThemeCssEditor.php` uses an undefined `$stack` var → would fatal if the negotiator runs (broken preview path).
- No custom routes/permissions; stored-CSS is admin-only so low XSS risk.
- Read: `custom_css_adder.module`.
