<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Example/reference module showing how to register a custom Drush 9+ command as a tagged service.

---

Drush 9 Commands Example is a developer reference module: it ships one working Drush command class (`Drush9ExampleCommands` extending `Drush\Commands\DrushCommands`) wired in through `drush.services.yml` and `composer.json`, to demonstrate the modern (Drush 9+) way of adding a custom command to a Drupal module — a command class annotated with `@command`, `@aliases`, `@options` and `@usage`, registered as a service tagged `drush.command`. It has no admin UI, no configuration, no permissions and no runtime behavior beyond the single demo command. Install it on a development environment, read/copy the pattern into your own module, then remove it. Supports Drupal 10 and 11 and requires Drush 9 or later.

---

- Learn the modern Drush 9+ custom-command pattern (class-based, not `.drush.inc`).
- See the three files a Drush command needs: the command class, `drush.services.yml`, `composer.json`.
- Copy `drush.services.yml` to register a command class as a `drush.command`-tagged service.
- Copy the `extra.drush.services` block from `composer.json` that points Drush at the services file.
- See how a command class extends `Drush\Commands\DrushCommands`.
- Read how a command name is declared with the `@command` annotation (`drush9_example:hello`).
- Read how a command alias is declared with `@aliases` (`d9-hello`).
- See how a required positional argument (`$name`) maps to a method parameter.
- See how options are declared with `@options` and defaulted in the method signature (`msg`).
- See how `@usage` documents an example invocation for `drush list`/`drush help`.
- Learn to write to the console via `$this->output()->writeln()`.
- Run `drush drush9_example:hello akanksha` to print a greeting.
- Run `drush drush9_example:hello akanksha --msg` to print the greeting plus an extra message.
- Run the short alias `drush d9-hello akanksha`.
- Verify a custom command is registered by finding it in `drush list`.
- Scaffold a new module's first Drush command from a known-good skeleton.
- Teach onboarding developers how Drush command discovery works in a Drupal module.
- Use as a template when migrating legacy `hook_drush_command()` code to command classes.
- Confirm your Drush/Composer wiring works before adding real command logic.
