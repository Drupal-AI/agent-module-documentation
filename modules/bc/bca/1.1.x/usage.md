<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bundle Class Annotations lets a bundle class declare which bundle it serves with a PHP attribute on the class itself, instead of the site registering it in a hook far away from the code.

---

Drupal 9.3 introduced bundle classes — a dedicated PHP class per bundle, so an Article node can have `Article::getByline()` rather than everything being a generic `Node`. The registration mechanism is `hook_entity_bundle_info_alter()`, which means the association between class and bundle lives in a `.module` file, separate from the class, and is easy to forget when adding a bundle. This module inverts it: `src/Attribute` and `src/Annotation` let the class say what it is for, `BundlePluginManager` discovers those declarations from each module's `src/Entity/` directory, and `bca.module`'s `hook_entity_bundle_info_alter()` attaches the class (and optional label) to the matching existing bundle. The bundle itself must already exist — bca does not create bundles, it only wires an existing one to your class. The result is that adding a bundle class is a single file, and deleting it removes the registration with it. Requirements are PHP 8.1+ (attributes) and core `^10.2 || ^11`, with no module dependencies, no routes, permissions or configuration. It is upstream-linted with `phpstan.neon`, a baseline and `phpcs.xml`. This is developer ergonomics rather than new capability — the bundle classes behave identically once registered — so its value is in codebases with many bundles, where the hook-based registration becomes a list nobody maintains. Note that since Drupal 11.4.0 this capability ships in core as `Drupal\Core\Entity\Attribute\Bundle`; existing sites keep working, and migrating off this module is usually just swapping the `use` namespace. Install with `ddev composer require drupal/bca` and `ddev drush en bca`; there is nothing to configure afterwards.

---

- Declare a bundle class with an attribute on the class.
- Keep bundle registration next to the class it registers.
- Avoid a growing hook_entity_bundle_info_alter().
- Add a bundle class as a single file.
- Remove a bundle class without editing a hook.
- Give Article nodes their own methods.
- Model domain behaviour on entity bundles.
- Reduce boilerplate in a large codebase.
- Make bundle classes discoverable by IDEs.
- Type-hint a specific bundle in code.
- Encapsulate field access behind methods.
- Support many bundles without a registration list.
- Prevent forgotten registrations when adding a bundle.
- Use PHP 8 attributes in a Drupal codebase.
- Refactor procedural entity helpers into classes.
- Keep custom entity logic testable.
- Onboard developers to bundle classes.
- Standardise bundle classes across projects.
