<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor 5 Custom Headings provides the option to configure custom heading styles for CKEditor 5.

---

CKEditor 5 Custom Headings lets you configure custom heading styles for CKEditor 5 — defining additional
heading options (with specific tags/classes/labels) in the editor's format dropdown beyond the default
H2–H6, so editors pick from your configured heading styles. It subclasses core's own `ckeditor5_heading`
plugin and adds a per-text-format "Customize headings" toggle plus a textarea where each line describes a
heading option. It depends only on core CKEditor 5.

Use it to offer custom heading styles in the editor. It is a content-editing/CKEditor feature; the headings
become markup, so ensure the text format's allowed tags/attributes permit the configured heading markup and
classes (and keep allowed attributes reasonable). Configuration is admin-only (editing a text format needs
*administer filters*), and it has no access-control role of its own. Configure the custom headings under
*CKEditor 5 plugin settings → Headings*.

---

- Configure custom heading styles in CKEditor 5, per text format.
- Add heading options with specific tags, CSS classes, and dropdown labels.
- Go beyond the default H2–H6 heading set.
- Toggle "Customize headings" on a format to switch to custom definitions.
- Define headings one-per-line as `h2.custom-heading-2|Custom heading (h2)`.
- Give an editor a friendly label in the Heading dropdown (the `|title` part).
- Attach a CSS class to a heading tag (the `.class` part) for styled headings.
- Provide a plain heading with no class (e.g. `h2|Heading 2`).
- Offer a paragraph option (`p|Paragraph`) alongside custom headings.
- Depend on core CKEditor 5 only — no extra libraries or Composer packages.
- Let editors pick configured headings from the toolbar Heading button.
- Save a text format with no standard headings enabled when using custom ones.
- Ensure the format's allowed HTML permits the configured heading markup.
- Keep allowed attributes reasonable (the module widens headings to allow `class`).
- Seed the textarea from the format's currently enabled headings as a starting point.
- Keep the standard core Heading behaviour when "Customize headings" is off.
- Match editor heading choices to your theme's typographic styles.
- Present consistent, on-brand headings across content authors.
- Configure headings without writing custom CKEditor plugin code.
- Restrict custom-heading definition to trusted admins via *administer filters*.
