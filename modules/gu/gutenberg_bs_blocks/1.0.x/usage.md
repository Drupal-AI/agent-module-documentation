<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gutenberg Bootstrap Blocks adds Container, Row and Column blocks to the Gutenberg editor so editors can build Bootstrap grids visually inside content.

---

Install the module with `composer require drupal/gutenberg_bs_blocks` and enable it (`drush en gutenberg_bs_blocks`); it depends on the **Gutenberg** editor module and needs no configuration of its own — there is no settings page. Two site prerequisites make it useful: enable the **Gutenberg Experience** on the content type you want to edit (done in the Gutenberg module's settings), and make sure your front theme ships **Bootstrap ≥ 4.5**, because the blocks only emit Bootstrap grid classes — they do not bundle Bootstrap for the front end. In the editor a new **Bootstrap** block category appears with three blocks: **Container** (`container`/`container-fluid`), **Row** (`row` with optional `justify-content-*` / `align-items-*` alignment), and **Column** (`col*` with per-breakpoint size, order and offset controls for Xs–Xl). Columns only insert inside a Row; when you add a Row you pick a variation such as `50 / 50`, `30 / 70`, `70 / 30`, `33 / 33 / 33`, or `25 / 50 / 25`. The blocks are **static** — the grid markup is written into the node body when you save and rendered as-is on the front end, so the visual result matches your theme's Bootstrap. You can also convert an existing core Group (or a multi-block selection) into a Container via the block transforms. The current release is `1.0.0-rc3`, a release candidate; the compiled assets live in `build/` and are what Drupal loads.

---

- Install Gutenberg Bootstrap Blocks with Composer and Drush.
- Enable the Gutenberg Experience on a content type before using the blocks.
- Ensure the front theme provides Bootstrap 4.5 or newer.
- Add a Bootstrap Container block in the Gutenberg editor.
- Choose a wide (`container`) or full-width (`container-fluid`) container.
- Add a Row block and pick a column-split variation.
- Build a 50 / 50 two-column layout.
- Build a 30 / 70 or 70 / 30 asymmetric two-column layout.
- Build a 33 / 33 / 33 or 25 / 50 / 25 three-column layout.
- Add Column blocks inside a Row.
- Set per-breakpoint column size for Xs, Sm, Md, Lg, Xl.
- Set column order and offset per breakpoint.
- Align a row's columns horizontally (start / center / end).
- Align a row's columns vertically (top / center / bottom).
- Put two paragraphs side by side without writing CSS classes.
- Convert an existing core Group block into a Bootstrap Container.
- Group several selected blocks into a Container via transforms.
- Compose responsive Bootstrap grids visually inside content.
- Preview the grid inside the editor with bundled Bootstrap CSS.
- Rebuild the JS/CSS bundles after editing source under `libraries/`.
- Evaluate the 1.0.0-rc3 release candidate on a Gutenberg site.
