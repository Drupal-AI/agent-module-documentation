# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **ECA** (`eca`) — the Event‑Condition‑Action engine that Gamify uses to define
  its point‑awarding rules.
- **User Points** — a clone ships with Gamify as a submodule (the original module
  is unmaintained), so you do not need to install it separately.

This is a **beta** release (`1.1.0-beta11`) — evaluate it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/gamify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and update
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gamify -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Gamify (this brings in ECA and the bundled User Points functionality):

```bash
drush en gamify -y
```

## Verify it worked

Check that Gamify's permissions appear at **People → Permissions**, and that the
**ECA** UI (**Configuration → Workflow → ECA**) is available so you can author or
review the point‑awarding models. Perform a rewarded action (for example creating
a piece of content) as a test user and confirm their point total updates.
