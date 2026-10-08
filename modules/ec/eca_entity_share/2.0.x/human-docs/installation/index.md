# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4||^11`).
- The **ECA** base module (`eca`).
- The **Entity Share** module (`entity_share`), installed and configured for
  client/server syndication.

The base `eca_entity_share` module wires the two together; the actual events live
in its two submodules (see below). You will also want one of ECA's modelling tools
(BPMN.iO or the ECA Classic Modeller) installed.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_entity_share -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA (and Entity
Share, if you require it too) and update any shared dependencies as needed. If
Entity Share is not yet present, add it: `composer require drupal/entity_share -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_entity_share -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module plus the submodule that matches this site's role:

```bash
# On the exporting (server) site:
drush en eca_entity_share_server -y

# On the importing (client) site:
drush en eca_entity_share_client -y
```

Enabling either submodule enables the base `eca_entity_share` module (and `eca`)
automatically.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **ECA Entity Share Server** | `eca_entity_share_server` | Makes the *Channel list prepared* event available to ECA on the exporting site. |
| **ECA Entity Share Client** | `eca_entity_share_client` | Makes the *Relationship Field Value* event available to ECA on the importing site. |

Enable only the side that matches the role the site plays in your syndication
setup — or both, if a site acts as both client and server.

## Verify it worked

Open an ECA model at **Configuration → Workflow → ECA** and add an event. The
Entity Share event for the submodule you enabled (*Channel list prepared* or
*Relationship Field Value*) should now appear in the list of available events.
