<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AnimateCSS UI adds an administration interface to the base AnimateCSS module: it lets you bind Animate.css animations to CSS selectors from the admin UI (no theming or code), and provides global settings for how and where the Animate.css library loads.

---

The submodule (depends on `animatecss`) manages a list of "animate" records — a CSS selector plus a serialized bag of animation options (animation name, delay, speed, duration, repeat, trigger event, once, clean, fix-display, and optional scroll-library flags). Records are stored in a custom database table `animatecss` (`hook_schema` in `animatecss_ui.install`) and managed through a small service `animatecss.animate_manager` (`AnimateCssManager`, `backend_overridable`) that runs parameterized/`escapeLike` queries. The admin section at `/admin/structure/animatecss` provides list, add, edit, delete, and duplicate forms (`src/AnimateCssAdmin.php`, `src/Form/AnimateCss*.php`); the global settings form is at `/admin/config/user-interface/animatecss/settings`. When enabled, this submodule's `hook_page_attachments()` takes over library loading from the base module: it honors a `method` (local vs `cdn`), a minified/source `variant`, a `compat` flag, a global on/off `load`, and a page-visibility list (`url.pages` + `url.visibility`, same show/hide-on-listed-paths model as the Block module, plus a `?animate=no` query bypass). Enabled selector records (and any global config selectors) are emitted to `drupalSettings.animatecss.elements` and initialized by `js/animatecss.init.js`. Serialized option blobs are read back with `unserialize(..., ['allowed_classes' => FALSE])`. All routes require the `administer animate css` permission. Config object is `animatecss.settings` (owned here; schema in this submodule).

---

- Bind an Animate.css animation to a CSS selector (e.g. `.hero h1`) from the admin UI without editing templates.
- Manage a list of animated selectors: add, edit, duplicate, delete, enable/disable.
- Choose the animation name, delay, speed, duration, and repeat per selector.
- Trigger animations on a specific event: page load, scroll, click, hover, focus, keypress, submit, etc.
- Run an animation only once per selector with the "once" option.
- Clean previous Animate.css classes before applying a new one ("clean" option).
- Switch the library loading method between local (`/libraries`) and CDN.
- Load the minified (production) or source (development) variant of Animate.css.
- Use the compat (`animate.compat.css`) build for older class names.
- Globally enable or disable Animate.css loading with one toggle.
- Restrict which pages load Animate.css using a path list (show on listed / hide on listed).
- Exclude admin, node-edit, IMCE, batch, and AJAX paths from animations (shipped defaults).
- Bypass animations on demand for a page via the `?animate=no` query parameter.
- Silence the "library not installed / using CDN" status warning.
- Apply a global selector + animation options as a site-wide default.
- Integrate scroll-reveal libraries (AOS/WOW) per selector via their option flags.
- Preview animations on the admin sample area before applying them.
- Search/filter the selector list by selector or label.
- Keep animation bindings in the database (survives config, decoupled from theme).
- Set a default animation/speed/delay used as the baseline for new selectors.
