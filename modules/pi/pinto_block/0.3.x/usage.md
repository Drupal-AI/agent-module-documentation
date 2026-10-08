<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pinto Block connects the Pinto theme-object system to custom block_content bundle classes, so Layout Builder blocks are built and rendered through Pinto objects.

---

It is a developer-facing integration with no UI. You declare a block_content bundle class (via a core `hook_entity_bundle_info_alter`, or the BCA / Hux modules), create a Pinto theme object implementing `BlockBundleObjectInterface`, and annotate the bundle class with the `#[PintoBlock(objectClassName: …)]` attribute to link the two. A `LayoutBuilderEventSubscriber` then intercepts the rendering of matching Layout Builder blocks and delegates the build to the associated Pinto object's `__invoke()`/`pintoBuild()` pipeline, letting you assemble the render array in typed PHP against your bundle class's accessors rather than in preprocess hooks.

The module ships only a services file (an autowired, private-by-default event subscriber), an `Attribute\PintoBlock` attribute class, the `BlockBundle`/`BlockBundleObject` interfaces and an `ObjectContext` helper. It defines no routes, permissions, or config, so it introduces no request-facing surface of its own — access is entirely governed by Layout Builder and block_content core. Set-up is purely code: add the attribute to your bundle class and implement the object.

---

- Render a custom Layout Builder block through a typed Pinto theme object.
- Associate a block_content bundle class with a Pinto object via `#[PintoBlock(objectClassName:)]`.
- Define a block_content bundle class using core `hook_entity_bundle_info_alter`.
- Define a bundle class using the BCA `#[Bundle]` attribute instead.
- Define a bundle class using a Hux `#[Alter('entity_bundle_info')]` hook.
- Implement a theme object with `BlockBundleObjectInterface` and `DrupalObjectTrait`.
- Declare the object's variables with a Pinto `#[ThemeDefinition]` attribute.
- Build the block render array in PHP against bundle-class accessor methods.
- Move block rendering logic out of preprocess hooks into a component object.
- Pass block, host entity and view mode into the object via its `create()` factory.
- Let the `LayoutBuilderEventSubscriber` auto-detect the attribute and delegate the build.
- Use `ObjectContext` to carry rendering context into the object.
- Keep a component-library-style structure for custom blocks.
- Add per-bundle behaviour without defining new block plugins.
- Integrate custom blocks with an existing Pinto object codebase.