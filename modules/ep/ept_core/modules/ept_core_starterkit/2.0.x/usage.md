<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Starterkit is a developer tool that scaffolds a brand-new Extra Paragraph Types (EPT) paragraph module from boilerplate, via a Drush code generator.

---

The submodule ships one thing of substance: a DrupalCodeGenerator command, `ept:module`
(alias `ept-module`, class `EptGenerator`), registered through Drush's `generate` command. Run
`drush generate ept:module`, answer the machine name and human name prompts, and it writes a
complete new EPT paragraph module from the Twig templates under the submodule's `generator/`
directory — an `.info.yml` (package "Extra Paragraph Types", depending on `ept_core` and
`paragraphs`), a `.libraries.yml`, a `paragraphs_type` config entity, `field.field` instances
for `field_ept_settings`/`field_ept_text`/`field_ept_title`, default form/view displays, a
paragraph Twig template, a `composer.json`, a functional install test, CSS and logo assets.
The generated module is a normal disabled module you then enable. The Starterkit itself has no
routes, permissions, services or config of its own; its `hook_requirements()` enforces that
**Drush 12+** is available (the generator will not work on older Drush). It exists so authors
can contribute new `ept_*` paragraph types to the EPT ecosystem without hand-writing the
repetitive boilerplate.

---

- Scaffold a new custom EPT paragraph module with `drush generate ept:module`.
- Generate the `paragraphs_type` config and EPT field instances for a new paragraph type.
- Produce boilerplate form/view displays wiring up the EPT Settings widget.
- Create a new `ept_*` module to contribute back to the EPT ecosystem.
- Skip hand-writing the repetitive info.yml/composer.json/libraries.yml for an EPT module.
- Generate a paragraph Twig template pre-named for the new bundle.
- Produce a functional install test alongside the new module.
- Speed up building a bespoke section/paragraph type on top of EPT Core.
- Ensure a new paragraph module correctly depends on ept_core and paragraphs.
- Standardise the structure of custom EPT paragraph modules across a team.
- Bootstrap a design-options-enabled paragraph without copying an existing module by hand.
- Use the `ept-module` alias in scripts to generate modules non-interactively (with `--answer`).
- Check that the environment has Drush 12+ before generating (enforced by hook_requirements()).
- Generate CSS and logo asset stubs for the new paragraph module.
- Learn the canonical EPT module layout by reading the generated output.
- Kick-start a client-specific paragraph library built on EPT.
- Create multiple related paragraph types quickly by re-running the generator.
- Provide junior developers a guided path to author EPT paragraph modules.
- Generate a composer.json so the new module can be released on Drupal.org.
- Base a proof-of-concept paragraph type on the Starterkit example before customising it.
