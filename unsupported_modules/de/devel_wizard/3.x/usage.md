<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Devel Wizard is a developer productivity tool that scaffolds Drupal code from reusable generators it calls "spells".

---

Each spell (an `@DevelWizardSpell` plugin) collects configuration on an autocomplete-rich form under `/admin/devel-wizard-spell`, then emits boilerplate for things like content/block/taxonomy types, entity types, controllers, plugin managers, event subscribers, route param converters, image effects, libraries, Behat tests and full Drush projects. The same spells are exposed as Drush commands. Some spells (e.g. the Drush project and package-manager spells) shell out via a `ShellProcessFactory` to run `composer`/`drush`; commands are built as argument arrays passed to Symfony `Process` (no shell string interpolation).

Every route is gated behind restricted permissions — `devel_wizard.spell` for the spell overview, autocomplete endpoints and spell forms, and `devel_wizard.settings.admin` for settings — so the whole surface is admin/developer-only. It is a development-time tool and should not be enabled on production. Setup is: enable it in a dev environment, open the spell list, pick a spell, fill the form (or run the matching `drush` command), and review the generated code before committing.

---
- Scaffold a new custom module with standard structure.
- Generate a content type and its admin view/config.
- Generate a block content type with create/admin/Behat variants.
- Generate a taxonomy vocabulary and related config.
- Scaffold a custom entity type (plus bundle class, group).
- Generate a controller with a route.
- Generate a plugin manager and plugin type boilerplate.
- Generate an event subscriber skeleton.
- Generate a route param converter.
- Generate an image effect plugin.
- Scaffold a library definition and libraries-extend.
- Generate token hook implementations.
- Emit a full Drush project via the project spell (runs composer/drush).
- Run any spell from the CLI with its Drush command.
- Use autocomplete for modules, themes, profiles, libraries and entity types while filling forms.
- Compare/inspect spell definitions on the overview page.
- Restrict spell access to developers via `devel_wizard.spell`.
- Keep the tool in dev only; review generated code before commit.
