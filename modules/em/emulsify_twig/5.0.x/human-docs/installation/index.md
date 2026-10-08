# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies, no third-party libraries, and no configuration.
- Usually installed as a dependency of an **Emulsify**-based theme or starter kit.

## Install with Composer

Note the composer namespace is **`emulsify-ds/emulsify_twig`**, not `drupal/…`:

```bash
composer require emulsify-ds/emulsify_twig -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require emulsify-ds/emulsify_twig -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en emulsify_twig -y
```

That is the whole setup. The `bem()` and `add_attributes()` Twig functions become
available in every template immediately — there is no settings form and no
permission to grant.

## Verify it worked

You can confirm the functions are registered without building a theme, by rendering
a tiny inline template with Drush:

```bash
drush ev '$t = \Drupal::service("twig");
print $t->createTemplate("<h1 {{ bem(\"title\", [\"big\"], \"card\") }}>x</h1>")->render([]) . PHP_EOL;'
# <h1  class="card__title card__title--big">x</h1>
```

If that prints the BEM classes, the module is working. (The double space before
`class` is normal — a Drupal `Attribute` renders with a leading space.)

## A note on the module's future

Per the project README, this 5.0.x branch is the **last supported release**, and
development continues in the separate **Emulsify Tools** module. For a brand-new
project, consider whether Emulsify Tools is the better long-term choice.
