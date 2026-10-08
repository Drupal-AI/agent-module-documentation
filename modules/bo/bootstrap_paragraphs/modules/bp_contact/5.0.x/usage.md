<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Paragraphs Contact Form ships a `bp_contact` Paragraph bundle that embeds a core Contact form inside a page section. **It is not Drupal 11 compatible** — it declares `core_version_requirement: ^8 || ^9 || ^10` and requires the contrib module `contact_formatter`.

---

**Compatibility first: this submodule cannot be installed on Drupal 11.** Its `bp_contact.info.yml` declares `core_version_requirement: ^8 || ^9 || ^10`, and it depends on `contact_formatter`, a contrib module that is not part of the `bootstrap_paragraphs` package. On the documentation site `drush en bp_contact` fails with *"module 'bp_contact' is missing its dependency module contact_formatter"*. Everything below is read from its shipped source. Structurally it is the simplest bundle in the suite: no PHP classes, no services, no plugins, no permissions, no Twig template of its own, no CSS, no settings form and no configure route — `bp_contact.module` contains only `hook_help()`, which prints the README. Note that, unlike its siblings, its config lives in **`config/install/`** rather than `config/optional/`, so the config is a hard install requirement rather than an opportunistic import. It creates `paragraphs.paragraphs_type.bp_contact` (label "Contact Form") and three field instances: `bp_contact`, an `entity_reference` (cardinality 1) targeting core's **`contact_form`** config entity with `handler: 'default:contact_form'` and `target_bundles: null` (any contact form), plus the shared `bp_background` and `bp_width` list fields whose storages belong to the parent module. The form display renders all three with `options_select`. The view display is where `contact_formatter` earns its dependency: the `bp_contact` field uses the **`contact_field_formatter`** formatter, which renders the referenced contact form as an actual submittable form in the paragraph's output. Without that module the field would only render a label.

---

- Embed a core Contact form directly into a landing page built from paragraphs.
- Let editors choose which contact form appears on each page without a developer.
- Put a "Contact sales" form at the bottom of a product page.
- Put a "Report a problem" form inside a support article.
- Reuse one core contact form across many pages by referencing it from several paragraphs.
- Give a contact-form section a background colour using the shared `bp_background` field.
- Constrain a contact-form section's width using the shared `bp_width` field.
- Avoid hand-building an embedded form block for each page.
- Reference the site-wide default "Website feedback" contact form on a contact page.
- Restrict which contact forms may be selected by setting `target_bundles` on the field instance.
- Audit which pages embed a contact form by querying paragraphs of type `bp_contact`.
- Migrate legacy "contact block" placements into `bp_contact` paragraphs.
- Understand why the bundle renders only a label when `contact_formatter` is missing.
- Diagnose the D11 install failure ("missing its dependency module contact_formatter") on an upgrade.
- Plan a Drupal 11 upgrade path off this submodule — e.g. replace it with `bp_webform`.
- Recreate the same structure by hand on D11: a paragraph bundle with an `entity_reference` field to `contact_form`.
- Use the shipped `config/install/*.yml` as a template for a D11-compatible replacement bundle.
- Decide between `bp_contact` (core Contact) and `bp_webform` (Webform) for a site's form needs.
- Keep contact forms editorially placeable rather than hard-coded in a theme template.
- Ship contact-section placement as exported config so it deploys identically across environments.
- Inspect `core.entity_view_display.paragraph.bp_contact.default` to see the `contact_field_formatter` wiring.
- Explain to a site owner why the Contact Form paragraph type is missing after a D11 upgrade.
