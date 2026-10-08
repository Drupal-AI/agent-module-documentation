<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crossword Status is a lightweight client-side framework that adds completion-status CSS classes (such as solved or in-progress) to crossword fields wherever they are rendered — for example on teasers or listings — so you can style or filter puzzles by whether the visitor has finished them.

---

This submodule of Crossword (requires only `crossword`) implements `hook_preprocess_field()` (`crossword_status_preprocess_field`): for any field of type `crossword` that has a value, it adds a `data-crossword-fid` attribute (the file id of the first item) to the field wrapper and attaches the `crossword_status/crossword_status` library (`js/status.js`, depending on jQuery/once/Drupal/drupalSettings). The JavaScript reads per-puzzle progress kept client-side (in the browser) and applies status classes to those tagged field elements, so a teaser or grid list can visually distinguish solved puzzles from unstarted or in-progress ones. It is a "simple framework" starting point — it exposes the fid hook so a theme's CSS/JS can react to status; it ships no server-side storage, routes, permissions or config.

---

- Show which crossword puzzles a visitor has already solved in a listing.
- Mark in-progress puzzles differently from unstarted ones on teasers.
- Style solved-puzzle teasers (badge, checkmark, dimming) via a client-side status class.
- Tag every rendered crossword field with its file id (`data-crossword-fid`) for JS/CSS targeting.
- Build a "puzzles you've finished" visual view without server-side tracking.
- Give theme developers a hook to react to per-puzzle completion state on the client.
- Use it as a starting framework for a richer client-side progress display of your own.
