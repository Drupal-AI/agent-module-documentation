# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) — enabled in a standard install.
- The **Dynamic Entity Reference** module (`drupal/dynamic_entity_reference`) —
  used by the deployment changelog's "contents" field. Composer installs it.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/build_hooks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Dynamic
Entity Reference dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/build_hooks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en build_hooks -y
```

## Provider submodules — enable one if you use a supported host

The base module includes only the **generic** plugin, which POSTs to any
build‑hook URL you paste in. If your host is one of the supported providers,
enable its submodule instead (or in addition) to get a plugin that talks to that
provider's API and stores its credential:

| Submodule | Machine name | For |
|-----------|--------------|-----|
| Bitbucket | `build_hooks_bitbucket` | Bitbucket Pipelines |
| CircleCI | `build_hooks_circleci` | CircleCI v2 pipelines |
| GitHub | `build_hooks_github` | GitHub Actions |
| Netlify | `build_hooks_netlify` | Netlify build hooks + recent‑deploy listing |

For example:

```bash
drush en build_hooks_netlify -y
```

Each provider submodule adds one environment plugin and, in most cases, its own
credential settings form. (CircleCI stores its token on the environment itself.)

## Grant permissions

Build Hooks adds two restricted permissions — assign them under **People →
Permissions**:

- **Manage frontend environments** — create and edit deploy targets.
- **Trigger deployments** — review the changelog and press deploy.

The settings form (choosing loggable entity types) is gated by the core
**Administer site configuration** permission.

## Next step

Configure your loggable content and create a frontend environment — see
[Configuration](../configuration/index.md).
