Filter Twig adds a text-format filter that runs the field's content through Drupal's Twig engine at render time, so Twig syntax typed into a field is evaluated and replaced with its output.

---

The module ships one small filter plugin, id `filter_twig` ("Replaces Twig values"), of type `TYPE_TRANSFORM_IRREVERSIBLE`, with no settings. When a text format that has this filter enabled renders a field, the filter's `process()` builds a render array `['#type' => 'inline_template', '#template' => $text]` and returns the rendered result — meaning the stored text is treated as a Twig template and executed. That lets editors embed Twig such as `{{ … }}` expressions, loops, and filters directly in body/description fields. The module has no configuration UI (`configure` is null), no permissions, no routes, no schema, and no services; you enable it purely by ticking it on a text format at `/admin/config/content/formats`. Because it executes Twig from field content, it should only be enabled on text formats restricted to trusted/administrative roles — enabling it on a format available to untrusted users would let them run arbitrary Twig. It depends only on core `filter`.

---

- Evaluate `{{ … }}` Twig expressions typed into a body field at render time.
- Loop over data with `{% for %}` inside a rich-text field.
- Render a Twig `{% if %}` conditional in page content.
- Combine with Token/Twig Tweak-style patterns to output dynamic values in content.
- Let trusted admins compose small templating snippets without editing theme files.
- Produce computed markup in a block's body via Twig.
- Build a reusable "snippet" text format that renders Twig for staff authors.
- Output the current date/time or other Twig globals inside content.
- Format a list or table from inline Twig logic in a node body.
- Prototype template logic directly in content before moving it to a theme template.
- Render Twig inside a custom block placed by an administrator.
- Apply Twig transforms to a field only where the Twig text format is selected.
- Give a landing-page editor Twig power on an admin-only format.
- Interpolate values into marketing copy using Twig string filters.
- Keep Twig rendering scoped to a single "Twig" text format rather than sitewide.
- Chain the Twig filter with other filters in a format's processing pipeline.
- Add conditional call-to-action markup in content via Twig.
- Render structured HTML from compact Twig loops in documentation pages.
- Let a design-system team test component markup snippets in content.
- Export the Twig-enabled text format as config for repeatable deployment.
- Disable the filter to instantly stop Twig evaluation across all fields using that format.
- Restrict Twig execution to a format whose "use" permission is limited to trusted roles.
- Avoid writing a custom filter plugin just to render Twig in a field.
