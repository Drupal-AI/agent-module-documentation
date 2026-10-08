Adds a "Bootstrap Button" paragraph type that renders a link as a styled Bootstrap 5 button with configurable type, size, outline, alignment and state.

---

Extra Paragraph Types (EPT): Bootstrap Button is a tiny add-on to the EPT family. It ships a single Paragraphs bundle, `ept_bootstrap_button`, whose main field is a core Link field (`field_ept_bootstrap_button_link`) plus an `ept_settings` field from `ept_core` that carries button-specific display options. Editors pick a Bootstrap button type (primary, secondary, success, danger, warning, info, light, dark, link), an optional outline variant, a size (default/small/large), alignment (left/center/right), and toggles for open-in-new-tab, nofollow, active, disabled and stretched, plus a free-form custom CSS class. At render time the module's Twig template composes Bootstrap `btn`/`btn-*` classes and prints the link, while `ept_core`'s shared design options (CSS box, background, container width) still apply. The module has no routes, no permissions, no config form and no Drush commands of its own — it is pure content-building furniture. It assumes a Bootstrap-based theme; on a theme without Bootstrap the emitted classes are inert and the button renders unstyled.

---

- Add a call-to-action button to a landing-page node built with Paragraphs.
- Drop a "Buy now" / "Sign up" button into a marketing page without writing HTML.
- Give editors a consistent, theme-approved button style instead of ad-hoc inline markup.
- Render a primary Bootstrap button linking to a contact or lead form.
- Create an outline (ghost) button using the `.btn-outline-*` variants.
- Offer small (`btn-sm`) or large (`btn-lg`) button sizes per placement.
- Left-, center- or right-align a button within its paragraph region.
- Open an external link in a new tab (`target="_blank"`) from a button.
- Add `rel="nofollow"` to a sponsored or untrusted outbound button link.
- Visually mark a button as active (pressed) with the Bootstrap `active` class.
- Show a disabled-looking button (adds `.disabled`) for not-yet-available actions.
- Stretch a button to full width for mobile-friendly CTAs.
- Attach a custom utility class to a button for one-off styling.
- Combine the button with a heading (paragraph title field) above it.
- Build a hero section's primary/secondary action pair using two button paragraphs.
- Add download links styled as buttons on a resource or docs page.
- Place a "Read more" button at the end of a teaser-style paragraph stack.
- Standardize CTA buttons across many pages via the shared paragraph type.
- Use `ept_core` design options to add margins/padding/background around a button block.
- Mix the button paragraph with other EPT paragraph types (accordion, tabs, text) on one page.
- Provide translators a per-language link title and URL (link field is translatable).
- Give content teams a Bootstrap-documentation-linked UI so they pick semantic button colors.
- Replace bespoke button components in a Bootstrap 5 theme with a reusable paragraph.
