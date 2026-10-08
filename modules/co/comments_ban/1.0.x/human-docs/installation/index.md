# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Comment** module (`comment`) enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/comments_ban -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comments_ban -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comments_ban -y
```

## Set permissions

Grant core's **`administer users`** permission (at **People → Permissions**,
`/admin/people/permissions`) to the roles that should manage bans through the
profile checkbox and the management view. To let a role use the *Remove comment and
ban user* / *Unban user from the comments* bulk actions, also grant core's
**`administer comments`** permission.

## Expose the ban field on the user form

So administrators can tick the ban checkbox when editing a user, enable the **"User
banned from comments"** field on the account form:

1. Go to **Configuration → People → Account settings → Manage form display**
   (`/admin/config/people/accounts/form-display`).
2. Make sure the **User banned from comments** field is enabled (not disabled), then
   save.

## Verify it worked

Edit a test user, tick **User banned from comments**, and save. Then, logged in as
that user, try to post a comment — the submission should be rejected. Finally, open
**Configuration → People → Users banned from comments**
(`/admin/config/people/banned-from-comments`) and confirm the user appears in the
list, where you can unban them again.
