Calculator provides a placeable block that renders a small interactive, client-side arithmetic calculator with a choice of ten predefined CSS layouts.

---

The Calculator module ships one thing: a Block plugin (`calculator_block`, "Calculator Block") that outputs a fixed calculator keypad from a Twig template and attaches a JavaScript behavior which performs the arithmetic entirely in the visitor's browser. There is no server-side computation, no form submission, no route, and no stored calculation history. The only configuration is a per-block "Calculator Layout" select (Layout 1–10) that sets a `calculator-theme-N` wrapper class so a theme can style each layout differently. Operators supported are `+`, `-`, `x` (multiply), `/`, `%` (modulo), plus `=`, `AC` (all clear) and `CE` (clear last entry); numbers and operators can be driven by clicking buttons or by the physical keyboard. The block's markup and CSS can be fully overridden by copying `templates/calculator-block.html.twig` and `css/style.css` into a custom theme.

---

- Add a working calculator to any theme region using Drupal's Block layout UI (no custom code).
- Give editors/visitors a quick on-page arithmetic tool without linking out to an external calculator.
- Place a calculator in a sidebar on a math, finance, or education section of a site.
- Offer a calculator on a product or pricing page for quick manual estimates.
- Expose a calculator only on specific pages using core block visibility conditions (path, content type, role).
- Show the calculator to authenticated users only by combining the block with a role visibility condition.
- Pick one of ten built-in visual layouts per block placement via the "Calculator Layout" setting.
- Place several calculator blocks in different regions, each with a different layout number.
- Restyle the calculator to match a brand by overriding `css/style.css` in a custom theme.
- Target a single layout's styles via its `.calculator-theme-N` wrapper class without affecting the others.
- Replace the keypad markup entirely by overriding the `calculator-block.html.twig` template in a theme.
- Add or relabel buttons by editing an overridden template (the JS binds by CSS class, e.g. `.number`, `.operation`, `.equal`).
- Support keyboard-driven input (digits, `. + - * / % Enter =`) out of the box for accessibility and speed.
- Embed the calculator in a landing page built with Layout Builder by adding the block as a component.
- Use it as a lightweight demo/reference of a Drupal block that attaches an asset library and a Twig template.
- Provide a per-block instance with the block title hidden (label display defaults to off) for a clean widget look.
- Drop a calculator into an intranet or admin dashboard region for staff quick-math.
- Combine multiple placements (e.g. one per content type) so each section shows a themed calculator.
- Keep the block always-fresh: it sets cache max-age 0, so it renders on every request without stale caching concerns.
