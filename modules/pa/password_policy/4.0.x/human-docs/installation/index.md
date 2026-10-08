# Installation

## Requirements

Password Policy runs on **Drupal 9.1, 10, or 11**. Its only hard dependency is
core's **Datetime** module (`datetime`), which ships with Drupal and is enabled
automatically.

Two optional modules improve how it behaves when they are present:

- **Masquerade** (`drupal/masquerade`) — when installed, the module skips forcing a
  password reset while an administrator is masquerading as another user.
- **External Authentication** (`drupal/externalauth`) — externally authenticated
  (SSO) users are excluded from password validation and time-based expiration.

The individual password rules are not in the main module. Each is a **submodule**
that provides one constraint, and you enable only the ones you want:

| Submodule | Enforces |
|---|---|
| `password_policy_length` | Minimum or maximum password length. |
| `password_policy_character_types` | At least N of: lowercase, uppercase, digit, special. |
| `password_policy_characters` | At least N characters of one chosen type. |
| `password_policy_consecutive` | Blocks long runs of identical characters. |
| `password_policy_blacklist` | Disallows listed passwords or substrings. |
| `password_policy_history` | Prevents reuse of a user's recent passwords. |
| `password_policy_username` | Password may not contain the username. |
| `password_policy_delay` | Minimum time between password changes. |

## Install with Composer

From the project root:

```bash
composer require drupal/password_policy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/password_policy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the main module first:

```bash
drush en password_policy -y
```

Then enable the constraint submodules you plan to use. For example, to require a
minimum length and a mix of character types:

```bash
drush en password_policy_length password_policy_character_types -y
```

Add any of the other submodules from the table above the same way — you can always
enable more later. Only the constraints from enabled submodules become available
when you build a policy.

## Verify it worked

Log in as an administrator and go to **Configuration → Security → Password Policy**
(`/admin/config/security/password-policy`). You should see the **Password Policies**
list with an **+ Add Policy** button:

![The Password Policies list after installation](../images/list.png)

If the page loads and the **+ Add Policy** and **+ Force Password Reset** buttons
are present, the module is installed correctly. Next, review the
[configuration overview](../configuration/index.md) and then
[create your first policy](../creating-a-policy/index.md).
