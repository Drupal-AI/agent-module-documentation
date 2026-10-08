<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ept:module` Drush generator

Provided by `src/Drush/Generators/EptGenerator.php`, a `DrupalCodeGenerator` generator surfaced
through Drush's `generate` command. **Requires Drush 12+** (older Drush is blocked by
`ept_core_starterkit_requirements()`).

## Run it

```bash
drush generate ept:module            # interactive: asks machine name, then human name
drush generate ept-module            # alias
```

Non-interactive (answers in prompt order — machine name, then name):

```bash
drush generate ept:module \
  --answer=ept_hero --answer='EPT Hero' \
  --destination=modules/custom/ept_hero
```

- `--destination` is a **base directory** the files are written into (relative to the Drupal
  web root); the generator writes files at the root of that directory, so point it at the new
  module's own folder (e.g. `modules/custom/ept_hero`) to get a self-contained module.
- `--dry-run` prints what it would create without writing.

## What it generates

From the Twig templates in the submodule's `generator/` directory:

- `{machine_name}.info.yml` — package "Extra Paragraph Types", depends on `ept_core:ept_core`
  and `paragraphs:paragraphs`.
- `{machine_name}.libraries.yml`, `css/styles.css`, `logo.png`/`logo.svg`, `.gitignore`,
  `README.md`, `composer.json`.
- `config/install/paragraphs.paragraphs_type.{machine_name}.yml` — the new paragraph type.
- `config/install/field.field.paragraph.{machine_name}.field_ept_settings.yml` (+ `field_ept_text`,
  `field_ept_title`) — instances of EPT Core's shared field storages.
- `config/install/core.entity_form_display…` and `…entity_view_display…` — displays wiring the
  EPT Settings widget.
- `templates/paragraph--{machine-name}--default.html.twig`.
- `tests/src/Functional/InstallTest.php`.

The result is a normal, **disabled** module. Enable it with `drush en {machine_name} -y` to get
a working EPT paragraph type. (Remember: if you enable a generated module you must
`drush pmu {machine_name} -y` before deleting its directory.)
