<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Classes Extractor collects CSS class names that are already stored in your Drupal configuration and exports the deduplicated list.

---

Classes Extractor is a developer/build utility. It walks a fixed set of Drupal configuration
sources — Views, entity view displays, Display Suite settings, and a text format's `allowed_html` —
and gathers the CSS class names configured there through a pluggable extraction system. It then
exports the combined, de-duplicated list. This is useful when a CSS optimiser such as Tailwind or
PurgeCSS needs a safelist of classes that were set inside the CMS and would otherwise be stripped.

It does not scan CSS files, templates, or module source code, and it renders nothing on the page.
The only thing you configure is the output file path; the set of sources is fixed by the four
built-in extractor plugins (you can add your own plugin to cover more sources).

There are two ways to get the collected classes out:

- **Drush** — `drush cec` (command `class_extractor:create`) runs the extraction and writes the
  space-separated list of classes to the file path configured on the settings form.
- **JSON route** — `GET /api/v1/classes-extractor` returns `{"classes": "…"}`. This route is
  restricted to users with the *Administer site configuration* permission; it is not a public
  endpoint.

---

- Collect CSS classes already configured in Views, entity view displays, Display Suite, and a text
  format's allowed HTML.
- De-duplicate the collected classes into a single space-separated list.
- Export the list to a file with `drush cec`.
- Retrieve the list as JSON at `/api/v1/classes-extractor` (admin permission required).
- Build a Tailwind/PurgeCSS safelist from CMS-configured classes.
- Extend the collection with a custom `@ClassesExtractor` plugin.
- Configure only the output file path on `/admin/config/classes-extractor`.
- Render nothing and hold no content or access role of its own.
