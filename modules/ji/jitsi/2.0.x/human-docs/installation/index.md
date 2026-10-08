# Installation

## Requirements

- **Drupal 9.4 or later** (`core_version_requirement: >=9.4`).
- Access to a **Jitsi Meet server** — either the public `meet.jit.si` instance or,
  preferably for sensitive meetings, one you host yourself.

There are no additional Composer or PHP library requirements; the Jitsi client
script is loaded from the Jitsi server at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/jitsi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jitsi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

The project is named `jitsi`, but the **module machine name is `ek_jitsi`** — use
that when enabling:

```bash
drush en ek_jitsi -y
```

## Verify it worked

After enabling, grant the module's permission at **People → Permissions**, then add
the **Jitsi block** at **Structure → Block layout** or the **Jitsi video field** to
a content type. Load a page where the block or field appears and confirm you can
start or join a meeting room. See the "How to use it" section of the
[guide index](../index.md), and mind the privacy notes there about which Jitsi
server you point at and room‑name guessability.
