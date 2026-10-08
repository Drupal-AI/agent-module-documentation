<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled CE API exposes Drupal's rendered output as custom elements at `/ce-api`, which is the endpoint the Nuxt front end fetches.

---

This is the load-bearing submodule of the suite and the piece that makes its architecture different from a JSON:API build. Instead of serving raw entity data for the front end to render, Drupal renders the page as it normally would — field formatters, text formats, view modes, access-aware markup — and emits the result as `<drupal-…>` custom elements. The front end fetches that from `/ce-api` and hydrates the elements into components.

The consequence is a different division of labour. Everything Drupal already knows how to do stays in Drupal; the front end owns presentation and interaction. Adding a field, changing a formatter or altering a view mode does not require front-end work, which is the recurring cost of the data-plus-component-library approach.

**Two integration facts worth knowing.** It **replaces the `file_url_generator` service** with its own implementation, so file URLs are rewritten for the decoupled front end. That is legitimate — the replacement implements `FileUrlGeneratorInterface` — but any module that type-hints the concrete `Drupal\Core\File\FileUrlGenerator` class will fatal; verified in this wave against `complete_webform_exporter`, whose download route returns 500. And it is a **hard dependency of the top-level module**, so it is present on every Lupus Decoupled site.

---

- Serve rendered output as custom elements.
- Fetch page content from `/ce-api`.
- Keep field formatters in Drupal.
- Keep text format processing in Drupal.
- Avoid reimplementing view modes in the front end.
- Add a field without front-end work.
- Hydrate custom elements into Nuxt components.
- Preserve access-aware markup in a decoupled build.
- Rewrite file URLs for the front end.
- Debug a module that fatals on the file URL generator.
- Compare against a JSON:API architecture.
- Understand the suite's division of labour.
- Trace what the front end actually receives.
- Check for concrete type hints after installing.
- Plan a progressive decoupling strategy.