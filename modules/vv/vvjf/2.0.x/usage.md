<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Vanilla Javascript 3D Flipbox (VVJF) adds a Views display **format** that renders results as an accessible grid of 3D flip cards using plain JavaScript instead of jQuery or any bundled library.

---

Install with `composer require drupal/vvjf:^2.0` (which also pulls the required **`vvj_core`** foundation) and enable both with `drush en vvjf`, then edit any View, set its **Format** to *Views Vanilla JavaScript 3D Flipbox*, and choose **Fields** as the row style — the module enforces this because the **first field becomes each card's front** and the remaining fields render onto the **back**. Everything is configured per view display in the Views UI (there is no global settings page): set card **dimensions** (height, minimum grid-box width, gap, and 3D perspective in pixels), choose the **trigger** (`click` — with Enter/Space keyboard support — or `hover`), the **flip direction** (horizontal Y-axis or vertical X-axis), independent **front and back background colors**, the **flip speed** (`0.1`–`2.0`s) and one of five **easing** curves (`ease`, `linear`, `ease-in`, `ease-out`, `ease-in-out`), and a responsive **breakpoint** (`all`/`576`/`768`/`992`/`1200`/`1400` px) below which the flip is disabled and both faces are shown so nothing is hidden from keyboard or touch users. Behaviour runs inside a lazy-hydrating `<vvjf-flipbox>` custom element that keeps `aria-hidden`/`tabindex` in sync with the flipped state, suppresses navigation on nested links in click mode, and resets on viewport resize. You can print first-row field values into the view's header/footer/empty text with `[vvjf:field_name]` (or `[vvjf:field_name:plain]`) tokens. It requires **Drupal 11.3+ or 12 and PHP 8.3+** — there is no Drupal 10 build — and is a byte-compatible upgrade from 1.x that preserves every option key, CSS class, template name, and JS behavior key (the outer tag changed from `<div>` to `<vvjf-flipbox>`); the `vvjf_update_10001` hook auto-enables `vvj_core` on upgrade. Deep linking does **not** apply here (per-card state is transient), and there is no public JavaScript API.

---

- Show a term on the front of a card and its definition on the back.
- Reveal an answer on a flip card for a quiz or FAQ grid.
- Present a person on the front and their biography on the back.
- Build a responsive flip-card grid from a filtered content View.
- Replace a jQuery-based flip-card plugin with a no-library alternative.
- Render taxonomy-filtered results as 3D flip cards.
- Combine the flipbox with a Views pager or exposed filters.
- Choose click or hover to trigger the flip.
- Flip cards horizontally (Y-axis) or vertically (X-axis).
- Set independent front and back background colors.
- Tune card height, minimum width, grid gap and 3D perspective in pixels.
- Adjust flip speed and pick an easing curve.
- Disable the flip below a chosen breakpoint so both faces show on small screens.
- Keep cards keyboard-operable with Enter/Space and avoid hover-only reveals.
- Meet screen-reader requirements with ARIA state synced to the flipped side.
- Suppress accidental navigation when clicking a link inside a click-to-flip card.
- Theme the flipbox entirely with your own CSS by disabling the bundled stylesheet.
- Override front/back styling through inline CSS custom properties.
- Print a first-row field into the view header with `[vvjf:title]` tokens.
- Reduce front-end payload by dropping a third-party flip-card library.
- Reuse the same `vvj_core` foundation across multiple VVJ display formats.
- Stand up a working demo quickly from the optional `vvjf_example` view.
