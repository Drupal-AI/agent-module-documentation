# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Options** module (`options`) and **Field** module (`field`) — these are
  the only dependencies and are enabled automatically as needed.

There are no third‑party Composer packages or PHP library requirements.

> **A note on security coverage:** this project is **not** currently covered by
> the Drupal security advisory policy. That's common for young modules; weigh it
> when deciding where to use it.

## Install with Composer

From the project root:

```bash
composer require drupal/list_value_archive -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/list_value_archive -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en list_value_archive -y
```

## Grant the permission

The archive controls appear only for users who hold the **Archive List field
values** permission. Assign it to the roles that manage fields at **People →
Permissions** (`/admin/people/permissions`), or with Drush:

```bash
drush role:perm:add site_builder 'archive list field values'
```

(Adjust the role machine name and confirm the exact permission string on the
Permissions page for your version.)

## Verify it worked

Edit any List field at **Structure → Content types → *(bundle)* → Manage fields**.
You should now see an **Archived values** section on the field edit form where you
can tick individual allowed values to archive them. Archive one, then add new
content using that field and confirm the archived option no longer appears in the
widget — while existing content that used it still saves cleanly.
