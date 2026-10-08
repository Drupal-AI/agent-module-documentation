<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush subtheme generator (`drush generate drulma`)

`src/Generators/SubthemeGenerator.php` — a Drupal Code Generator (DCG) v2 generator registered in
`drush.services.yml`:

```yaml
Drupal\drulma_companion\Generators\SubthemeGenerator:
  arguments: ['@extension.list.theme']
  tags:
    - {name: drush.generator.v2}
```

It extends `DrupalCodeGenerator\Command\ThemeGenerator`. DCG name `theme:drulma`, **alias
`drulma`**, description *"Generates a drulma subtheme."* Template path is the generator's own
directory (`src/Generators/`). It exists in the module (not the theme) because Drush cannot run
generate commands shipped inside a theme.

## Run it

```bash
drush generate drulma      # or: drush generate theme:drulma
# with DDEV from the host: ddev drush generate drulma
```

It prompts (via DCG `collectDefault()`) for the machine name, then asks for a **Theme name**
(default *"Drulma subtheme"*) and **Theme description** (both required).

## What it scaffolds

`generate()` writes, into a new `{machine_name}` theme:

- `{machine_name}.info.yml`, `{machine_name}.theme`, `{machine_name}.libraries.yml`, `css/overrides.css`
  — from the module's Twig templates (`subdrulma.info.yml.twig`, `subdrulma.theme.twig`,
  `subdrulma.libraries.yml.twig`, `css.overrides.css.twig`). The generated `.info.yml` sets
  `base theme: drulma` with Drulma's region set.
- `config/install/{machine_name}.settings.yml` and `config/schema/{machine_name}.schema.yml` —
  copied from the installed **drulma** theme's own settings/schema (schema has `drulma.settings`
  rewritten to `{machine_name}.settings`). Drulma's path is resolved via the injected
  `extension.list.theme` (`getPath('drulma')`), so the drulma theme must be present.
- `favicon.ico` and `logo.svg` — copied from the drulma theme.
- Every `config/optional/*.yml` from drulma, with `block.block.drulma_*` filenames and the
  `id:`/theme references rewritten to the new machine name.
- Empty template directories: `templates/{page,node,field,views,block,menu}` and `images/`.

The result is a ready-to-enable Drulma subtheme you then customize.
