<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Robots.txt Utils is an Htaccess submodule that deletes the physical robots.txt file, on form save and on every cron run, so the Robotstxt module's dynamically generated version is always what search engines see.

---

Drupal's contrib Robotstxt module serves robots.txt dynamically from a route, but a physical `robots.txt` file left in the docroot (for example the one shipped by core or a scaffold tool) takes precedence and shadows it. This submodule fixes that: it depends on the `robotstxt` module and alters that module's settings form to add a "Delete physical robots.txt" checkbox. When the box is checked, a custom submit handler deletes `DRUPAL_ROOT/robots.txt` immediately, and `robotstxt_utils_cron()` deletes it again on every cron run (as long as the Robotstxt module is enabled), so a redeploy that restores the file gets cleaned up automatically. It is a single `.module` file — one form alter, one submit handler, one cron hook — plus a one-boolean config object, and it defines no routes or permissions of its own (the checkbox lives on the Robotstxt admin form, gated by that module's permission).

---

- Guarantee the Robotstxt module's dynamic robots.txt is served, not a stale file on disk.
- Delete a physical `robots.txt` left behind by core or a scaffold tool.
- Automatically remove `robots.txt` again after each deploy via cron.
- Keep robots.txt centrally managed in Drupal configuration rather than on the filesystem.
- Add the delete option directly on the existing Robotstxt settings form.
- Ensure crawler directives edited in Drupal actually reach search engines.
- Clean up a docroot where a physical robots.txt keeps reappearing.
- Toggle the behavior off to leave any physical robots.txt in place.
- Support SEO workflows that rely on the dynamic robots.txt output.
- Avoid manual filesystem edits when switching to dynamic robots.txt.
