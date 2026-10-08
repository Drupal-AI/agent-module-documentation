<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Generator scaffolds a module containing VLSuite components — `drush generate vlsuite-module` — from a chosen library template.

---

Every project extending a component library writes the same boilerplate: a module, a block type with fields, form and view displays, a template, and the configuration that registers it with the layout system. Getting it right by hand takes an afternoon and getting it subtly wrong takes longer to discover.

This submodule turns it into a Drush command. Choose a library template, generate, and the module is scaffolded with the structure the suite expects — which also means the generated component behaves like the shipped ones rather than being a special case.

The `default_content` dependency is what lets generated components ship with example content, so a new component arrives with something to look at rather than an empty placeholder. `section_library` means generated sections can be saved and reused like the built-in ones.

Two practical points. Generated code is a starting point, not a finished component — the fields and templates will need adjusting to the design. And the generator encodes the suite's conventions, so a component generated against one version may need updating when those conventions change; regenerate rather than hand-patch where you can.

---

- Scaffold a module containing a VLSuite component.
- Generate a component from a library template.
- Avoid writing block type boilerplate.
- Ship a generated component with example content.
- Make a custom component behave like built-in ones.
- Save generated sections to the section library.
- Speed up extending the suite.
- Standardise component structure across a team.
- Start from generated code and adjust.
- Regenerate after a convention change.
- Learn the expected structure from output.
- Create several components consistently.
- Add a project-specific component set.
- Document a component's generated structure.
- Keep custom components in their own module.