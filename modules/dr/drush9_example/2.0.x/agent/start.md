<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush 9 Commands Example (drush9_example) — agent index

Educational/reference module. Ships **one** example Drush command to demonstrate the modern
(Drush 9+) class-based command pattern. Package `Examples`. No dependencies (info.yml lists none),
no Composer `require`, no PHP/library requirements. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 2.0.3.

## What it actually provides

- **No** routes, controllers, forms, entities, plugins, permissions, hooks, config objects or
  config schema. Nothing runs at request time.
- **One Drush command**, registered as a service — see [drush/commands.md](drush/commands.md).

## The three wiring files (the whole point of the module)

- `src/Commands/Drush9ExampleCommands.php` — command class extending
  `Drush\Commands\DrushCommands`.
- `drush.services.yml` — registers service `drush9_example.commands`
  (class `Drupal\drush9_example\Commands\Drush9ExampleCommands`) with tag `{ name: drush.command }`.
- `composer.json` — `extra.drush.services` maps `drush.services.yml` to Drush `^9`, so Drush
  discovers the command file. No `require` section.

## The command

`drush9_example:hello` (alias `d9-hello`) — one required argument, two documented options. Full
signature, options and behavior in [drush/commands.md](drush/commands.md).

## Use it

Install/enable on a dev site (`drush en drush9_example -y`), run
`drush drush9_example:hello <name>`, read the source, copy the pattern into your own module, then
remove it. Also has manual guidance in `human-docs/` (not for agents).
