<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Formatter Template (FFT) lets a site builder pick a Twig template for any field's formatter, choosing from templates placed in a configured directory and annotated with a `{# Template Name: … #}` header.

---

The usual way to change one field's markup is a theme template with a long suggestion name, which means a theme change, a cache rebuild, and knowledge of Drupal's template-suggestion rules. FFT moves that choice into the *Manage display* UI: write a Twig file, give it a header comment, and it appears as a selectable option on any field's formatter. The template receives the field's `data`, the host `entity`, and any per-template `settings`, so it can produce arbitrary markup around the field's values.

Templates are discovered by scanning the configured directory for files matching the theme extension (`.html.twig`), reading each one, and keeping those whose contents contain a `{# Template Name: … #}` header and whose filename starts with the expected prefix (`fft` for field formatters, `views` for the Views submodule). An optional `{# Settings: … #}` block seeds default per-template settings, editable per formatter as simple `key = value` lines. The directory is set at `admin/config/content/fft`; note the shipped default `sites/all/formatter` is a Drupal 7 path and must be changed on a Drupal 8+ site before any template appears. A submodule, **vff** (Views Formatter), applies the same template-selection idea to a whole Views result set as a Views style plugin.

---

- Choose a Twig template for a single field's formatter from the *Manage display* UI.
- Change one field's markup without writing a theme template suggestion.
- Offer editors or site builders a menu of ready-made field renderings.
- Wrap a field's items in custom markup, classes, or containers.
- Render a taxonomy/entity-reference field as inline linked tags.
- Build a flexslider/carousel/owl-carousel image display over an image field.
- Attach per-template JavaScript or CSS via the `js`/`css` settings keys.
- Reference module, theme, or template-relative asset paths with `{module-name}`, `{theme}`, `{fft}` tokens in settings.
- Reuse one template across many content types and bundles.
- Carry default settings inside the template via a `{# Settings: … #}` header.
- Apply one or two image styles to an image field and expose the derivative URLs to the template.
- Reset Drupal's default field wrapper markup so the template controls the full output.
- Render a whole Views result set through a custom Twig template with the vff style plugin.
- Output raw rendered Views fields, or the styled row data, to a Views template.
- Build a nested tree (e.g. a taxonomy hierarchy) from flat Views rows using vff's tree-field options.
- Use a "clean" Views template that strips the default `views-view` wrapper markup.
- Show a template even when a View returns no rows (vff "show when empty").
- React to template variables before render by subscribing to the `fft.preprocess` event.
- Keep FFT templates in version control alongside the rest of the site's code.
- Point the template directory at a location the deployment controls rather than the default D7 path.
- Provide multilingual-aware Views templates using the `langcode`, `langcode_content`, and `langcode_interface` variables vff injects.
