Bundle Classes is a reference/teaching module that shows how to attach behaviour to a specific entity bundle through a dedicated PHP bundle class instead of scattering logic across global hooks and preprocess functions.

---

The module ships a single worked example: an `Article` bundle class for the `article` node type, registered with the `#[Bundle]` attribute from the `bca` (Bundle Class Attribute) contrib module and wired up via an OOP `#[Hook('entity_bundle_info_alter')]` implementation. The `Article` class adds a `getLastUpdatedDate()` method that returns a render array for the node's "Last updated" (changed) timestamp — logic that pre-bundle-classes would have lived in a preprocess function. A bundled Olivero sub-theme, Bundle Class Demo, ships a `node--article.html.twig` that calls `{{ node.getLastUpdatedDate }}` to show the method being used directly from a template. The module is explicitly NOT for production sites; it exists to be read and copied. It provides no routes, permissions, config, services (beyond the hook class), or Drush commands, and is verified by a small kernel test suite.

---

- Learn how to register an entity bundle class in Drupal 10.5+/11/12 using the `bca` `#[Bundle]` attribute.
- See a minimal `hook_entity_bundle_info_alter()` implementation written as an OOP `#[Hook]` class method.
- Copy the `Article extends Node` pattern into your own project module to add methods to article nodes.
- Move markup-building logic (like a formatted "Last updated" date) off preprocess functions and onto the entity object.
- Understand how a bundle class is only applied to matching-bundle entities (article) and not to others (page).
- Reference `getLastUpdatedDate()` as a template for returning a `#theme`-driven render array from a bundle-class method.
- See how to call a bundle-class method from a Twig template with `{{ node.getMethodName }}`.
- Study how `field->view()` with a custom timestamp format produces a labelled inline date render array.
- Use the bundled Bundle Class Demo theme as an Olivero sub-theme example that overrides `node--article.html.twig`.
- Learn the recommended convention of naming your own project's bundle-class module `bundle_classes` so classes always live in the same place.
- Understand why bundle classes avoid the naming conflicts you would risk by enabling a contrib module of the same name.
- Use the kernel test (`ArticleBundleClassTest`) as a template for asserting `Node::load()` returns your bundle class instance.
- Teach a team the difference between global-function/preprocess theming and OOP bundle-class methods.
- Demonstrate the `#[Bundle(entityType: 'node', bundle: 'article')]` attribute syntax to colleagues.
- Verify the `bca` dependency and `#[Bundle]` attribute are working in a fresh Drupal install by enabling this module.
- Prototype adding computed/display helper methods to a content type without writing a full custom module first.
- Show how `TranslatableMarkup` is used to set a translatable `#title` on a render array.
- Explore how `RunTestsInSeparateProcesses` and `#[Group]` PHPUnit attributes are used in a Drupal kernel test.
- Use as CI-verified living documentation: the examples stay compiling because the test suite exercises them.
