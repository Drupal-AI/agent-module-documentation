<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imagefield Default Alt And Title fills empty image alt and title attributes with the host entity's label, both as a client-side autofill on the edit form and as a batch backfill over existing content.

---

Empty alt text is the most common content-management accessibility failure, and the cause is workflow: an editor adding several images to a node will rarely stop to write a description for each. This module attacks that cheaply by defaulting the alt and title attributes to the entity's own label (node title, term name, or Commerce product title). It works two ways that are configured independently. First, on the settings page you pick which bundles get the on-form helper; for those, a small JavaScript behavior prefills any empty image-widget Alt and Title inputs from the Title/Name field and keeps them in sync while the editor types, stepping aside the moment the editor fills an input by hand. Second, an "Update images" batch form lets you select node types, taxonomy vocabularies, or Commerce product types and sweep all existing entities of those bundles, writing the entity label into every image field's empty alt and title without touching values that are already filled. The default is always the label — there is no configurable template and no token replacement — so a title-derived alt conveys what an image belongs to rather than what it depicts; it is a sensible baseline for illustrative photos and for backfilling a legacy library, not a replacement for written descriptions of informational images. The module defines no permissions of its own (both admin pages use "administer site configuration"), ships no config schema, and requires PHP 8.1 and Drupal core ^10.3 || ^11.

---

- Prefill empty image alt text from the node title as editors type.
- Prefill the image title attribute from the entity label on the edit form.
- Enable the autofill only for selected node types.
- Enable the autofill for taxonomy vocabularies.
- Enable the autofill for Commerce product types.
- Backfill alt attributes across all existing nodes of a type.
- Batch-fill alt and title over a legacy image library.
- Fill missing alt text after a content migration or import.
- Reduce the count of empty-alt accessibility errors site-wide.
- Improve an accessibility audit score with minimal effort.
- Provide a default alt value before editors write a real one.
- Avoid per-image manual alt/title entry during bulk content entry.
- Give imported images a contextual default description.
- Sweep taxonomy term images to add missing alt/title.
- Sweep Commerce product images to add missing alt/title.
- Establish an SEO baseline for image alt and title attributes.
- Preserve any alt/title an editor already entered while filling the rest.
- Keep alt and title in sync with the title during initial content creation.
- Run a one-off cleanup over content created before the module was installed.
- Provide a baseline before layering an AI image-description tool on top.
