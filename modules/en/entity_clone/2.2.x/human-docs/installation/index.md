# Installation

## Requirements

Entity Clone needs **Drupal 10.3+ or 11** (`^10.3 || ^11`). It has no other
contrib module dependencies — it works with core's Entity API to attach a clone
action to the entity types already on your site.

The project also bundles an optional submodule, **Entity Clone Extras**
(`entity_clone_extras`), which adds bundle-level clone permissions for nodes and
media (for example, allowing a role to clone only *article* nodes). Enable it
only if you need that finer-grained control.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_clone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_clone -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_clone -y
```

Once enabled, the configuration screens appear under **Configuration → System →
Entity Clone settings** (`/admin/config/system/entity-clone`).

## Grant the clone permissions

Enabling the module is not enough on its own — cloning is gated by permissions,
so decide who is allowed to clone what. Go to **People → Permissions**
(`/admin/people/permissions`) and look for the Entity Clone section:

- **Administer entity clone** — lets a role reach the two settings pages
  described in [Configuration](../configuration/index.md). Grant this only to
  administrators.
- **Clone _{entity type}_ entity** — one permission is generated per cloneable
  entity type (for example *Clone node entity*, *Clone taxonomy_term entity*,
  *Clone media entity*). A role can only clone an entity type if it holds that
  type's permission, so you can let a role clone nodes without letting it clone
  users or configuration.

Tick the permissions each role should have and click **Save permissions**. If
you enabled **Entity Clone Extras**, you will also see bundle-level permissions
for nodes and media (for example *Clone article node*) that let you restrict
cloning to specific bundles.

## Verify it worked

Log in as an administrator and go to `/admin/config/system/entity-clone`. You
should see the **Entity clone settings** page with its two tabs — *Entity clone
settings* and *Cloneable entities*:

![The Entity clone settings page after installation](../images/settings.png)

If the page loads with both tabs present, the module is installed correctly.
Next, review the [configuration](../configuration/index.md) to control how each
entity type clones.
