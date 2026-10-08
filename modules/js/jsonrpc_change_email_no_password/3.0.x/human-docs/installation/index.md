# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The contributed **JSON-RPC** module (`jsonrpc`) — a hard dependency, and the
  endpoint through which the method is called.

There are no third‑party Composer or PHP library requirements.

> **Note:** this release is a beta (`3.0.0-beta1`). Review the account-security
> consideration in the [overview](../index.md) before enabling it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonrpc_change_email_no_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the JSON-RPC module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonrpc_change_email_no_password -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonrpc_change_email_no_password -y
```

Drupal enables the JSON-RPC module automatically as a dependency if it is not on
already.

## Grant the permission

The method does nothing until a role holds its permission. Go to **People →
Permissions** (`/admin/people/permissions`) and grant **Change one's email address
without a password via JSON-RPC** to the appropriate roles.

**Grant this only to trusted, non-admin roles.** Because the method removes the
password re-authentication step, any valid session or token for a permitted account
can change that account's email — see the account-security consideration in the
[overview](../index.md). The module already blocks the `admin` role; be equally
careful with your own high-privilege roles.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep jsonrpc_change_email_no_password
```

Then, as a permitted non-admin user, call the `user.change_email_no_password`
method through the JSON-RPC endpoint and confirm the account's email updates.
