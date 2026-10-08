# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- Core's **File** (`file`) and **User** (`user`) modules — enabled automatically as
  dependencies (User is always on; File is on for most sites).
- **At least one access-storage backend submodule** enabled (see below), otherwise
  a correct password is never remembered and visitors would be re-prompted on every
  page.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_access_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_access_password -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module and a storage backend

Enable the base module **and at least one** access-storage backend:

```bash
# Base module + session backend (works for anonymous visitors):
drush en entity_access_password entity_access_password_session_backend -y
```

### Choosing a backend

| Submodule | Machine name | Remembers unlocked access… |
|-----------|--------------|----------------------------|
| **Session backend** | `entity_access_password_session_backend` | Per browser session. **Works for anonymous visitors** — the usual choice. |
| **User-data backend** | `entity_access_password_user_data_backend` | Per authenticated user, persisted across sessions/devices. Adds admin forms to grant access to a user manually. Logged-in users only. |

You can enable both. If you enable neither, protected content will keep re-showing
the password form because nothing records that the visitor already unlocked it.

## Next steps

1. Set an optional site-wide password at **Configuration → Content authoring →
   Entity Access Password → Settings**.
2. Add a **Password protection** field to a content type and choose which view
   modes it protects.

See [Configuration](../configuration/index.md) for the full walkthrough.
