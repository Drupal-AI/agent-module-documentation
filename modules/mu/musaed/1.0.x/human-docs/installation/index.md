# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contributed‑module dependencies and no bundled third‑party libraries.
- A **Musaed subscription** from [musaed.co](https://musaed.co) and the **client
  ID** it issues — the widget will not function without it.
- Awareness that the module loads a **third‑party script** from Musaed, with the
  privacy/consent implications that carries.

## Install with Composer

From the project root:

```bash
composer require drupal/musaed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/musaed -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en musaed -y
```

> This is a beta release (1.0.0‑beta2). Review it before relying on it in
> production.

## Provide your client ID

The widget is driven by the **client ID** from your musaed.co subscription. Enter
it where the module asks for it after enabling. Because the ID ties your site to
your paid subscription, keep it out of public version control — prefer supplying
it per environment rather than hard‑coding it into committed configuration.

## Verify it worked

Load a front‑end page of your site and confirm the Musaed accessibility widget
appears and opens. If it does not, the most common cause is a missing or
incorrect client ID.
