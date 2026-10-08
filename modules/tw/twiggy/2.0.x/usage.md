<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twiggy registers a text filter that runs the field's content through Drupal's Twig engine, so Twig syntax typed into a body field is executed and rendered rather than shown literally.

---

The whole module is one class. `FilterTwiggy::process()` fetches the `twig` service and calls `renderInline($text, ['langcode' => $langcode])`, wrapping the result in a `FilterProcessResult`. There is no configuration, no permission, no settings form and no dependency beyond core's filter system; `core_version_requirement` is `^10.6 || ^11 || ^12`, already covering Drupal 12. Enabling it means adding "Twiggy Filter" to a text format, at which point anyone who can author content in that format is supplying template source that the server compiles and executes. Attach it only to a format restricted to trusted authors.

---

- Let a trusted editor use Twig loops in a body field.
- Render a repeated block of markup from content.
- Insert a computed value into an article.
- Use Twig conditionals inside a text field.
- Build a small table from content-supplied data.
- Format a list without writing a template file.
- Prototype template logic without a theme deploy.
- Give a documentation site inline templating.
- Apply Twig filters to content strings.
- Generate a link with Twig's path function.
- Reuse Twig syntax editors already know.
- Restrict Twig authoring to one text format.
- Keep template snippets alongside the content they format.
- Avoid a custom filter module for a one-off need.
- Compose markup from content variables.
- Support Drupal 12 with a single filter.
- Render inline templates from a migrated CMS.
- Let a developer-editor iterate quickly.
