<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Worked example plugins for the Cloner framework: node-article and image-style clone forms and cloners, plus a programmatic clone button, meant to be read and copied when writing your own. Not for production.

---

Cloner Examples (`cloner_examples`) is the optional demonstration submodule of Cloner. It contains no configuration or UI of its own beyond what its example plugins register; its purpose is to show every part of the Cloner plugin API working end to end. It provides a `@ClonerContentEntity` plugin that clones article nodes (setting the new title from the submitted form), a `@ClonerConfigEntity` plugin that clones image styles (setting a new machine name and label), and two `@ClonerForm` plugins that expose those cloners as clone forms and "Clone" operation links on article nodes and image styles respectively. It also demonstrates invoking a cloner plugin programmatically: a `hook_form_alter` adds a "Clone" button to the article edit form whose handler duplicates the node, runs the cloner plugin, saves, and redirects — proving the content/config cloner plugins are standalone and do not need the generated clone route. It depends on `cloner`, `node`, and `image`. Enable it while learning, then disable it in production.

---

- Learn how to write a `@ClonerContentEntity` plugin (see the node article example).
- Learn how to write a `@ClonerConfigEntity` plugin that assigns a new unique id/label (image style example).
- Learn how to write a `@ClonerForm` plugin with `isApplicable()`, `buildForm()`, `validateForm()`, and an `entity_operation_label`.
- See how form values reach the cloner via `$context['form_state']`.
- See how to invoke a cloner plugin programmatically from a `hook_form_alter` submit handler.
- Get a "Clone" operation link on article nodes and image styles once the submodule is enabled.
- Copy the plugin scaffolding into a custom module as a starting point for your own cloners.
