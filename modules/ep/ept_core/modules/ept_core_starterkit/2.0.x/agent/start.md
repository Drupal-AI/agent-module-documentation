<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Starterkit — agent index

Submodule of **EPT Core**. A developer scaffolding tool: it adds one Drush code generator,
`ept:module` (alias `ept-module`), that generates a complete new EPT paragraph module from
boilerplate. No routes, permissions, services, or config of its own. Depends on
`ept_core:ept_core`; requires **Drush 12+** (enforced by `hook_requirements()`).

- **The `ept:module` generator: what it makes and how to run it** →
  [drush/generator.md](drush/generator.md)

Key facts:
- Generator class `EptGenerator` (`#[Generator(name: 'ept:module', aliases: ['ept-module'])]`),
  templates in the submodule's `generator/` dir.
- Prompts for machine name + human name, then writes info.yml, libraries.yml, a
  `paragraphs_type`, `field.field` instances (`field_ept_settings`/`field_ept_text`/
  `field_ept_title`), form/view displays, a paragraph template, composer.json and a test.
- Generated module depends on `ept_core` + `paragraphs`, package "Extra Paragraph Types".
- Parent module docs: [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md).
