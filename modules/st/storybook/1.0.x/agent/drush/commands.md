<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

`src/Drush/Commands/StorybookCommands.php`. These compile Twig stories into the JSON the
Storybook app reads. They do **not** need the external Storybook app running.

## `storybook:generate-all-stories`

```bash
drush storybook:generate-all-stories            # alias: generate-all-stories
drush storybook:generate-all-stories --force    # regenerate even unchanged
drush storybook:generate-all-stories --omit-server-url
drush storybook:generate-all-stories --uri=https://my-site.com   # override endpoint domain
```

Scans `modules`, `profiles`, `themes` (relative to the Drupal root) for files matching
`*.stories.twig` and compiles each to a sibling `*.stories.json`. Skips files whose JSON is
newer than the Twig source unless `--force`.

## `storybook:generate-stories <template_path>`

```bash
drush storybook:generate-stories modules/custom/my_theme_stuff/foo.stories.twig
```

Compiles a single template. **`template_path` is relative to the Drupal root** (the docroot,
e.g. `web/`), must end in `.stories.twig`, and must resolve inside the Drupal app. Output is
the same path with `.stories.json`.

### cwd gotcha

The command reads the template from `\Drupal::root() . '/' . $template_path` but **writes the
JSON with `file_put_contents($destination_path)` — relative to the current working
directory**. So run Drush from the **Drupal docroot** (the dir that is `\Drupal::root()`, e.g.
`web/`) so the `.stories.json` lands next to its `.stories.twig`:

```bash
cd web && drush storybook:generate-stories modules/custom/my_theme_stuff/foo.stories.twig
```

Options `--force` and `--omit-server-url` behave as above.

## What the JSON contains

For each `{% stories %}` group: `title`, `stories[]` (each with `name`, `args`, and a
`parameters.server.id` hash), and — unless `--omit-server-url` — `parameters.server.url`
pointing at `/storybook/stories/render`. Example:

```json
{"title":"Components/Probe/Card","parameters":{"server":{"url":".../storybook/stories/render"}},
 "stories":[{"name":"Default","args":{"text":"Hello"},"parameters":{"server":{"id":"…"}}}]}
```

With `--omit-server-url` you must instead set the server URL in Storybook's
`.storybook/preview.js` (`parameters.server.url = '<drupal>/storybook/stories/render'`).

Continuous recompile while editing:

```bash
watch --color drush storybook:generate-all-stories
```
