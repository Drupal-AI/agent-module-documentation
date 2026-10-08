# Drush commands

Registered in `drush.services.yml` (service `image_effects.commands`, class
`Drupal\image_effects\Commands\ImageEffectsCommands`).

| Command | Purpose |
|---|---|
| `image-effects:convert-rotate <style_names>` | Convert core's built-in Rotate effect to the Image Effects Rotate effect in the named image styles. |

Options:
- `--name-contains=<str>` — only styles whose machine name contains the string.
- `--label-contains=<str>` — only styles whose label contains the string.
- `--revert` — convert back (Image Effects Rotate → core Rotate).

Interactive prompts fill in style names when omitted. Uses the `image_effects.converter`
service.
