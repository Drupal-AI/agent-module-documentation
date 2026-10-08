<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bring Back jQuery.once() restores the `core/jquery.once` asset library (and a bundled jQuery 3.7.1) that Drupal 10 removed, so legacy JavaScript calling `$(selector).once('id')` keeps working.

---

Drupal 10 dropped the `jquery.once` plugin in favour of the framework-agnostic `core/once` (`Drupal.once`), which broke every contrib module, theme and custom behaviour still written against `$.fn.once()`. This module is a single `hook_library_info_alter()` implementation: when the `core` extension's libraries are being assembled it **re-defines** `core/jquery` (version 3.7.1, serving `lib/jquery_3.7.1_jquery.min.js` from this module at weight `-20`, marked minified, MIT) and **re-adds** `core/jquery.once` (version 2.2.3, serving `lib/jquery-once-2.2.3/jquery.once.min.js` at weight `-19`, GPL-2.0-or-later, depending on `core/jquery`). The same two libraries are also declared in the module's own `jquery_once.libraries.yml` as `jquery_once/jquery` and `jquery_once/jquery.once`, so you can depend on either namespace. Nothing else is provided: no configuration, no configure route, no permissions, no services, no plugins, no Drush commands, no config schema, no submodules. Installing (and clearing caches) is the entire setup. Crucially the module does **not** touch Drupal 10's `core/once` / `Drupal.once` API — the two coexist, so it is a bridge for legacy code rather than a replacement for the modern one, and code should still be migrated to `once()` over time.

---

- Keep a Drupal 9 theme's `$(...).once('mybehavior')` JavaScript working after upgrading to Drupal 10/11.
- Unblock a Drupal 11 upgrade blocked by a contrib module that still declares `core/jquery.once`.
- Buy time to migrate custom behaviours from `$.fn.once()` to `Drupal.once()` incrementally.
- Restore `core/jquery.once` so an unmaintained module's library definition resolves again.
- Avoid patching a third-party module just to swap its `jquery.once` dependency.
- Ship a bundled jQuery 3.7.1 that is guaranteed present regardless of core's own jQuery handling.
- Add `core/jquery.once` as a dependency of a custom module library and use `$.fn.once` in its JS.
- Use `$('p').once('changecolor').css('color','red')` idioms in a custom behaviour again.
- Use `.findOnce('id')` to re-select elements a behaviour has already processed.
- Use `.removeOnce('id')` in a `detach()` implementation so a behaviour can re-run after AJAX.
- Keep older jQuery UI / third-party widget integrations that assume `$.fn.once` working.
- Keep a legacy admin theme's JavaScript operational on a modern core.
- Provide `jQuery.once` to inline JavaScript injected by a page builder or asset-injector module.
- Debug a "TypeError: $(...).once is not a function" error on a freshly upgraded site.
- Depend on the module's own namespace (`jquery_once/jquery.once`) instead of the core alias.
- Confirm which file supplies jQuery on a site with `\Drupal::service('library.discovery')->getLibraryByName('core','jquery')`.
- Pin the jQuery version served to the front end at 3.7.1 while core moves on.
- Run legacy and modern once implementations side by side during a migration sprint.
- Keep AJAX-heavy admin screens (Views UI, Layout Builder) working with old custom behaviours.
- Restore JS on a decoupled-ish site whose front-end scripts were written for Drupal 8.
- Support a client's long-lived custom module during a phased rewrite.
- Verify the alteration is active by checking that `core/jquery.once` reports version 2.2.3.
- Remove the module cleanly once every `$.fn.once()` call has been migrated — no config to unwind.
- Serve the library from a module rather than adding a jQuery CDN tag in a theme template.
- Give a QA environment the same legacy JS surface as production during an upgrade rehearsal.
