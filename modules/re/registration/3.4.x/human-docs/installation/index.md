# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core modules **Datetime**, **Field**, **Text**, **User** and **Workflows**, which
  Drupal enables automatically as dependencies. Workflows is what powers the
  registration states (pending / complete / held / canceled).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/registration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/registration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en registration -y
```

## Submodules — enable only what you need

The suite ships nine optional submodules. Enable any of them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Admin Overrides** | `registration_admin_overrides` | Let administrators override a host's capacity, open/close window or maximum-spaces limits. |
| **Cancel By** | `registration_cancel_by` | Add a "cancel by" deadline after which registrants can no longer self-cancel. |
| **Change Host** | `registration_change_host` | Move an existing registration to a different host entity. |
| **Confirmation** | `registration_confirmation` | Send confirmation emails when someone registers. |
| **Inline Entity Form** | `registration_inline_entity_form` | Edit registrations inline via Inline Entity Form. |
| **Purger** | `registration_purger` | Automatically delete a host's registrations and settings when the host is deleted. |
| **Scheduled Action** | `registration_scheduled_action` | Schedule automated email actions relative to open/close/reminder dates. |
| **Wait List** | `registration_waitlist` | Provide a wait list for overflow sign-ups once capacity is reached. |
| **Workflow** | `registration_workflow` | Add workflow transition operations for moving registrations between states. |

For example, to add a wait list:

```bash
drush en registration_waitlist -y
```

Each submodule requires the base Registration module, which is already present once
you have installed it above.

## Optional companion modules

Two suggested modules are not bundled but integrate well:

- **`drupal/commerce_registration`** — integrate with Drupal Commerce to sell
  fee-based registrations.
- **`drupal/entity`** — enables the reverse "user → their registrations" relationship
  in Views.

## Next step

Once enabled, nothing is registrable yet — you need to create a registration type and
add the Registration field to a host bundle. See
[Configuration](../configuration/index.md).
