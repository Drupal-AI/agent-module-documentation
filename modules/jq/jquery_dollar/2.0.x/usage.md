<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
jQuery Dollar makes `$` available globally as an alias for jQuery, by cloning core's `drupal.init.js` asset entry and loading a one-line script (`$ = jQuery;`) immediately after it.

---

Drupal runs jQuery in no-conflict mode, so `$` is not defined globally. That is the correct default — it kept Drupal compatible with Prototype and the other libraries that claimed `$` in the era when the decision was made, and it forces module JavaScript into the `(function ($) { … })(jQuery)` wrapper that makes the dependency explicit.

It is also a recurring obstacle when integrating third-party scripts written outside Drupal, which assume `$` exists. The usual answers are to wrap the script or edit it; this module offers the third: define `$` globally and let those scripts work unchanged. The entire implementation is worth quoting, because it explains both the appeal and the caveats. The JavaScript file is one line, `$ = jQuery;`, and `jquery_dollar_js_alter()` clones the asset definition of `core/misc/drupal.init.js`, points the copy at that file, and adds `0.1` to its weight so it loads directly after `drupal.js` — which is exactly where core calls `jQuery.noConflict()`.

Two things follow. The assignment has no `var`, `let` or `window.` prefix, so it creates an implicit global — which works in sloppy mode and **throws in strict mode**. And defining `$` globally is precisely what no-conflict mode was preventing, so any other library on the page that wants `$` now collides with jQuery, silently, in whichever order the assets happen to load. The module has no configuration, no permissions, no routes and no dependencies; enabling it is the entire setup, and its effect is site-wide, admin pages included. Use it as a deliberate, documented compatibility shim for a specific third-party script — not as a convenience to turn on because typing `jQuery` is tiresome.

---

- Make `$` available to a third-party script that assumes it exists.
- Run a vendor script written outside Drupal unmodified.
- Avoid manually wrapping vendor JavaScript in a jQuery closure.
- Alias jQuery to the global `$` across the whole site.
- Load the alias directly after `drupal.js` / `drupal.init.js`.
- Support legacy JavaScript copied from web snippets on a Drupal site.
- Undo Drupal's jQuery no-conflict default deliberately.
- Confirm no other library on the site claims the global `$` first.
- Anticipate failure of the assignment under strict mode / ES modules.
- Prefer the `(function ($) { … })(jQuery)` wrapper in code you control.
- Document in the codebase why the shim was added.
- Plan removal (`drush pmu jquery_dollar`) once vendor scripts are updated.
- Debug `$ is not defined` errors coming from third-party scripts.
- Verify aggregated JS load order after enabling the module.
- Keep it off any site that mixes jQuery with Prototype or MooTools.
- Treat it as a compatibility shim, not an everyday convenience.
- Enable with `drush en jquery_dollar -y` — no configuration step follows.
- Rely on it only where a single jQuery version serves every page.
- Explain to a reviewer why a project depends on it before merging.
- Rebuild caches (`drush cr`) after enabling so the alias is served.
