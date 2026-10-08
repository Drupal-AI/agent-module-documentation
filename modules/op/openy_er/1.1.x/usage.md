<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Open Y Entity Reference Tweaks supplies entity reference selection plugins that behave like the defaults but **do not** add a configuration dependency on the entities they reference.

---

The problem is specific and, once you have hit it, immediately recognisable. When a field's default value references a node or a block, Drupal records that entity as a config dependency of the field. Export the configuration, deploy it to another environment where that entity does not exist, and the import fails — or worse, deleting the referenced entity silently removes the field configuration that depended on it. For a distribution like Open Y, which ships field configuration that has to install cleanly on sites whose content it cannot know, that is fatal.

The plugins here — `DefaultSelectionNoDependency`, `NodeSelectionNoDependency`, `BlockSelectionNoDependency`, sharing `SelectionNoDependencyTrait` — provide the same selection behaviour with the dependency calculation suppressed. The field still references content at runtime; the config just stops claiming it cannot exist without it.

**This release may not install as shipped.** Its `info.yml` declares `drupal:plugin` as a dependency, but there is no core module named `plugin` — that is the contrib project `drupal/plugin`, and the module ships no `composer.json` to pull it in, so on a site without `drupal/plugin` present the module will not enable (missing dependency `plugin`). Nothing in the code actually uses that project, so the declaration looks like a mistake. Running `composer require drupal/plugin` before enabling resolves it; the upstream fix is to drop (or correct) the stray dependency.

---

- Reference a node in a field default without a config dependency.
- Reference a block without coupling config to content.
- Ship field configuration in a distribution safely.
- Deploy config to an environment lacking the referenced content.
- Stop a deleted node from removing field configuration.
- Avoid config import failures on missing entities.
- Keep default values pointing at optional content.
- Install a distribution's fields on an empty site.
- Choose a selection handler per field.
- Debug a config import that fails on a missing entity.
- Understand why deleting a node changed a field.
- Decouple configuration from content for portability.
- Install `drupal/plugin` before enabling this module.
- Audit which fields depend on specific content.
- Ship a field default that points at optional content.
- Explain a config export that will not import elsewhere.
