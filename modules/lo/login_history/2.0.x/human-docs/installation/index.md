# Installation

## Requirements

Login History is a self‑contained security/audit module. It needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — this is the only dependency, and Drupal
  enables it automatically. Views backs the site‑wide report and lets you build your
  own login reports.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/login_history -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_history -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_history -y
```

On install the module creates its own `login_history` database table and the default
site‑wide report view. It begins recording logins right away — every successful login
from that point on is captured.

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`), decide who can see the
data:

- **View own login history** — lets a user see their own `/user/{uid}/login-history`
  page and the link in the "Last login" block. Commonly granted to authenticated
  users.
- **View all login histories** — lets a user (typically an administrator or helpdesk
  role) see the site‑wide report.
- **Administer login history** — access the settings form.

## Verify it worked

Log out and back in, then visit **Reports → Login history**
(`/admin/reports/login-history`). You should see your login recorded with its
timestamp, IP address, and browser. Next, see
[Configuration](../configuration/index.md) to adjust retention and place the block.
