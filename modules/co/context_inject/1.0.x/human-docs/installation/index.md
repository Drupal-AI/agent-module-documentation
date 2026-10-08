# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer.
- The contrib **Context** (`context`) module — a hard dependency. Context
  provides the reaction framework and the conditions that scope where injections
  apply.
- No third‑party Composer packages or external libraries of its own, and it makes
  no outbound HTTP calls.

> **Security coverage:** this project is **not covered** by Drupal's security
> advisory policy at the time of writing. Combined with the fact that the snippet
> reaction outputs unfiltered markup, keep the **administer contexts** permission
> with fully trusted roles only.

## Install with Composer

From the project root:

```bash
composer require drupal/context_inject -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the Context requirement — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/context_inject -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Context (if it is not already) and this module together:

```bash
drush en context context_inject -y
```

## Verify it worked

Edit an existing context (or create one), and confirm that **Inject HTML snippet**
and **Attach library** now appear in the list of available **reactions**. Add the
snippet reaction with a harmless test snippet, save, and load a page the context
matches to confirm the markup appears where you chose (top or bottom). Remember
that only users with **administer contexts** should be allowed to do this.
