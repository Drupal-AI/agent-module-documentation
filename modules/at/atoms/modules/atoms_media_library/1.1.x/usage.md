<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Atoms Media Library is a submodule of Atoms that adds a **media** atom value-type, letting reusable atoms hold a reference to a Media entity selected through Drupal's Media Library.

It provides a single `Media` atom plugin (`Plugin/Atoms/Media`) and depends on core `media_library` plus the contrib `media_library_form_element` module to render the picker inside the atom edit form. Once enabled, editors can create atoms whose value is an image/document/video media item and render it in templates like any other atom.

Typical setup: install `media_library_form_element`, enable this submodule, then define a media-typed atom and let editors pick media at `/admin/content/atoms`.

---

Short summary: a media atom type for the Atoms module, backed by the Media Library widget.

It solves the gap that base Atoms ships text/number/link/entity/etc. types but no first-class media picker. It works by registering an `Atoms` plugin that uses the Media Library form element for selection and stores the chosen media reference.

Operationally it inherits all of Atoms' permissions and admin routes; it adds no routes of its own. It requires `media_library` and `media_library_form_element` to be present.

---

- Enable the submodule to add a media atom type to Atoms.
- Define an atom of type `media` in `*.atoms.yml` or `hook_atoms_alter()`.
- Let editors pick a media item for an atom via the Media Library.
- Store a reusable site logo as a media atom.
- Reference a shared hero image across templates through one atom.
- Render the media atom in Twig with `{{ atom('machine_name') }}`.
- Reuse a downloadable document (PDF) as a media atom.
- Combine media atoms with other atom types on the overview form.
- Translate media atom references per language (via Atoms translate forms).
- Swap the referenced media in one place to update it site-wide.
- Rely on the Media Library UI for browsing and uploading.
- Keep media selection consistent with the rest of the site's media workflow.
- Grant editing via the standard *edit atom* permission.
- Use media atoms in Views through the Atoms area handler.
- Extend further by cloning the `Media` plugin for custom media handling.
