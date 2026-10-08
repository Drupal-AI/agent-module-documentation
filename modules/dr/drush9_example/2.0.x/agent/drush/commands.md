<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command example (`Drush9ExampleCommands`)

The module exists to demonstrate one thing: how to register a custom Drush command (Drush 9+)
via a command class + tagged service, replacing the legacy `hook_drush_command()` / `.drush.inc`
approach. Everything below is in `src/Commands/Drush9ExampleCommands.php`,
`drush.services.yml` and `composer.json`.

## Install / enable

```bash
composer require drupal/drush9_example
drush en drush9_example -y
```

No module dependencies, no third-party libraries. Requires Drush 9 or later. Intended for a
development environment only.

## Registration (how Drush finds the command)

- **Command class** `Drupal\drush9_example\Commands\Drush9ExampleCommands extends
  Drush\Commands\DrushCommands`. Each public method annotated with `@command` becomes a Drush
  command; the class is the "command file".
- **`drush.services.yml`** registers the class as a service and tags it so Drush picks it up:

  ```yaml
  services:
    drush9_example.commands:
      class: Drupal\drush9_example\Commands\Drush9ExampleCommands
      tags:
        - { name: drush.command }
  ```

- **`composer.json`** tells Drush which services file to load:

  ```json
  "extra": { "drush": { "services": { "drush.services.yml": "^9" } } }
  ```

That trio (command class → services file → composer `extra.drush.services`) is the reusable
pattern; copy it into your own module and rename.

## The command: `drush9_example:hello`

Method `hello($name, $options = ['msg' => FALSE])`. Declared entirely through docblock annotations:

| Annotation | Value | Purpose |
|---|---|---|
| `@command` | `drush9_example:hello` | Command name. |
| `@aliases` | `d9-hello` | Short alias. |
| `@options arr` | "An option that takes multiple values." | Documents a multi-value option. |
| `@options msg` | "Whether or not an extra message should be displayed." | Boolean flag; defaulted to `FALSE` in the method signature. |
| `@usage` | `drush9_example:hello akanksha --msg` | Example shown in `drush help`. |

- **Argument** `$name` — required positional argument (the person to greet).
- **Options** — declared with `@options`. Only `msg` is bound in the signature
  (`$options = ['msg' => FALSE]`); `arr` is documented as an example of a multi-value option but is
  not read by the method body (it is there purely to show the annotation syntax).
- **Output** uses the base class helper: `$this->output()->writeln(...)`.

Behavior:

```php
public function hello($name, $options = ['msg' => FALSE]) {
  if ($options['msg']) {
    $this->output()->writeln('Hello ' . $name . '! This is your first Drush 9 command.');
  }
  else {
    $this->output()->writeln('Hello ' . $name . '!');
  }
}
```

## Run it

```bash
drush drush9_example:hello akanksha          # -> Hello akanksha!
drush drush9_example:hello akanksha --msg    # -> Hello akanksha! This is your first Drush 9 command.
drush d9-hello akanksha                       # same, via alias
```

Confirm registration with `drush list` (look for `drush9_example:hello`) or
`drush help drush9_example:hello`.

## Notes

- The annotation-based style shown here is what Drush 9/10 read from the docblock. Newer Drush also
  supports PHP 8 attributes for the same metadata; this module predates that and uses annotations
  only — a fine, still-working reference for the class + service wiring.
- `tests/src/Functional/LoadTest.php` is a minimal install/load test; there is no runtime feature
  to test beyond enabling the module.
