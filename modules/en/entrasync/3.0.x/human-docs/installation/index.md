# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **[Key](https://www.drupal.org/project/key)** (`key`) — stores the Entra app
  credentials securely.
- **[MS Graph API](https://www.drupal.org/project/ms_graph_api)** (`ms_graph_api`)
  — provides the Graph SDK and the Graph API key; it in turn depends on Key. You
  do not configure this module manually — Entra User Sync uses it.
- An **Azure app** configured with the right Graph permissions. `User.Read.All` is
  the only permission this module needs.

To experiment safely, the free [Microsoft 365 Developer
Program](https://developer.microsoft.com/microsoft-365/dev-program) gives you a
tenant with demo users.

Note this release is a beta and is **not** covered by the security advisory
policy.

## Install with Composer

From the project root:

```bash
composer require drupal/entrasync -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Key and MS Graph API and
updates any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entrasync -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entrasync -y
```

Drush enables the Key and MS Graph API dependencies at the same time if they are
not already on.

## Post‑installation

1. **Grant permissions restrictively.** Give only trusted role(s) the permission
   to administer the module — it works directly with users and can grant roles, so
   it can be used to escalate permissions.
2. **Add your tenant key(s)** via the Key module (see
   [Configuration](../configuration/index.md)).
3. **Create your synchronisations** using those keys.

## Verify it worked

Confirm the Key and MS Graph API modules are enabled, then check that you can add
a Key for your tenant and reach the module's synchronisation setup. Continue with
[Configuration](../configuration/index.md).
