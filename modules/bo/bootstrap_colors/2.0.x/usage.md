Bootstrap Colors provides an admin color-scheme generator that writes a Material-Design-based palette into a Bootstrap Barrio (sub)theme's settings.

---

Bootstrap Colors adds a single admin page at `/bootstrap/colors` (permission `administer bootstrap colors`) that renders an interactive, jQuery-driven palette builder. You choose a primary base color and an accent base color — typing a hex value, using the bundled Bootstrap color picker, clicking a Material Design swatch, or importing a palette from the Colour Lovers gallery — and the page computes tint/shade variations client-side with TinyColor. When you save, the module's `ColorForm::submitForm()` writes the chosen shades (primary, accent, body background, body text, and H1–H3 heading colors) into the *active theme's* settings object using the Bootstrap Barrio `bootstrap_barrio_*` keys and turns on `bootstrap_barrio_enable_color`. The module itself ships no config schema and stores nothing of its own; it is a front-end helper for theming a Bootstrap Barrio-based subtheme and is meant to be paired with the Bootstrap Barrio theme and the Bootstrap Library module (set to serve SASS-compiled files) so Bootstrap is recompiled with the selected variables. It only affects appearance and has no runtime effect on the front end beyond the theme settings it writes.

---

- Recolor a Bootstrap Barrio-based subtheme without hand-editing SCSS.
- Give theme developers a visual palette builder at `/bootstrap/colors`.
- Pick a primary base color and an accent base color for a Barrio theme.
- Enter colors as hex values in the form fields.
- Choose colors from a bundled Bootstrap color picker widget.
- Select from 24 Google Material Design color swatches.
- Import color palettes from the Colour Lovers online gallery (top, new, random).
- Preview computed Material-Design tint/shade steps (50–900, A100–A700) live.
- Set the body background color for the theme.
- Set the body text color for the theme.
- Set individual H1, H2, and H3 heading colors.
- Save the palette into the active theme's `bootstrap_barrio_*` settings in one submit.
- Automatically enable `bootstrap_barrio_enable_color` when saving.
- Prototype a brand palette quickly before committing SCSS variables.
- Standardize a Material Design look across a Bootstrap Barrio site.
- Restrict palette editing to trusted admins via the `administer bootstrap colors` permission.
- Reach the generator from Configuration » User interface (admin menu link).
- Pair with the Bootstrap Library module configured to use SASS so Bootstrap recompiles with the chosen colors.
- Experiment with light/dark variations of a base color using TinyColor-computed shades.
- Use the built-in Bootstrap 5 style guide preview on the page to sanity-check contrast.
