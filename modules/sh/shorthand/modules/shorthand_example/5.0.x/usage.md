<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shorthand example is a demonstration submodule of Shorthand that installs a ready-made `shorthand_story` content type wired to a Shorthand select field, so you can see the integration working without configuring a content type by hand.

---

Enabling `shorthand_example` imports config that creates a node type **Shorthand story**
(`shorthand_story`) with a required Shorthand field **`field_shorthand_story`** (field type
`shorthand_local`, provided by the parent `shorthand` module). Its form and view displays are
preconfigured so a story selected in the field renders on the node. The submodule depends on core
`node` and the `shorthand` module (its config also references `menu_ui`). It is intended as an
example/reference: install it to get a working story bundle quickly, then adapt or replace it with
your own content type. Note that the parent module's `drush shorthand:clean-up` command looks for a
field named `field_shorthand` (not the `field_shorthand_story` this submodule creates), so the
cleanup command will not detect stories referenced through this example's field.

---

- Get a working "Shorthand story" content type without building one manually.
- See how a `shorthand_local` field is attached to a node bundle.
- Use as a starting point/reference when adding Shorthand fields to your own content types.
- Demo the Shorthand integration end to end (download a story, select it, view the node).
- Inspect the shipped form display config to learn the recommended widget settings.
- Inspect the shipped view display config to learn how a story is rendered on a node.
- Provide a quick QA fixture for testing story download and rendering.
- Create example story nodes for training editors on the Shorthand workflow.
- Compare your own bundle configuration against the example's field setup.
- Learn that the Shorthand field should be set `required` and cardinality 1.
- See how `menu_ui` third-party settings appear on an example content type.
- Prototype a decoupled/immersive story landing page bundle quickly.
- Verify a Shorthand token + download pipeline works before building production content types.
- Copy the field storage/field config YAML as a template for a custom Shorthand field.
- Understand the `field_shorthand_story` vs `field_shorthand` naming caveat for cleanup.
- Enable temporarily on a staging site to validate the module, then uninstall.
- Seed a demo site with a Shorthand story content type for stakeholder review.
