A block that lets visitors switch a Bootstrap 5 theme between light, dark and auto color modes, persisting the choice in the browser.

---

Bootstrap Theme Toggler (project machine name `bootstrap_color_modes_toggler`) ships a single block plugin, "Bootstrap Theme Toggler". When placed, it renders a Bootstrap dropdown with three items — Light, Dark, Auto — using Bootstrap Icons glyphs. Client-side JavaScript (a `Drupal.behaviors` behavior) sets the `data-bs-theme` attribute on the `<html>` element and stores the selected mode in `localStorage` under the key `theme-mode`; on later page loads an inline script re-applies it before render to avoid a flash. "Auto" follows the OS `prefers-color-scheme` media query. The module has no settings form, no permissions, no routes and no server-side configuration — everything is theme-side and per-visitor. It only affects a Bootstrap 5 theme that reads `data-bs-theme` (e.g. Bootstrap Barrio or a custom Bootstrap 5 subtheme), and needs the Bootstrap Icons webfont installed under `/libraries/bootstrap-icons`.

---

- Add a light/dark/auto color-mode switcher to a Bootstrap 5 Drupal site without writing custom JavaScript.
- Place the "Bootstrap Theme Toggler" block in a header, navbar or utility region via Block Layout.
- Give visitors a persistent dark-mode preference that survives page navigation and browser restarts (localStorage).
- Default new visitors to their OS preference via the "Auto" mode (`prefers-color-scheme`).
- Offer an accessible dropdown toggle (`aria-label`, `aria-pressed`) instead of a bare on/off switch.
- Integrate a Bootstrap 5.3 color-mode toggle into a Bootstrap Barrio subtheme.
- Provide a dark mode toggle for a marketing or documentation site built on Bootstrap.
- Prevent a light-to-dark flash on load thanks to the inline pre-render script that applies the stored mode early.
- Reuse the toggle as a Single Directory Component (SDC) — `bootstrap_color_modes_toggler:bootstrap_color_modes_toggler` — inside a custom Twig template.
- Add a color-mode switcher to a Bootstrap-themed intranet or admin-facing portal.
- Ship a zero-configuration dark mode for a small brochure site where an editable settings form is unnecessary.
- Match a design system that already uses Bootstrap Icons (`bi-sun-fill`, `bi-moon-stars-fill`, `bi-circle-half`).
- Let each visitor pick their own theme independent of other users (no server state, no cache implications).
- Add the toggle to multiple regions or block instances on the same page (each block instance gets a unique DOM id).
- Prototype a dark-mode experience quickly before investing in a fuller theming solution.
- Support keyboard and screen-reader users toggling the theme through the labeled dropdown items.
- Provide an OS-aware default that still lets power users force Light or Dark.
- Complement a Bootstrap 5 navbar with a right-aligned theme dropdown (`dropdown-menu-end`).
- Serve as a reference implementation for wiring `data-bs-theme` + localStorage in a Drupal block.
