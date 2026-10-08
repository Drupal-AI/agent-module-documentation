# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The base module has **no third-party Composer or PHP library requirements and no module
  dependencies**.
- To get a working support form via the bundled submodule (**Client Support - Contact Form**), the
  core **Contact**, **File**, **Link** and **Options** modules are required — Drupal will enable
  them automatically as dependencies — and the site needs a working **outbound email** setup, since
  submissions are sent by email.

## Install with Composer

From the project root:

```bash
composer require drupal/client_support -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/client_support -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module, and — unless you're writing your own integration plugin — the Contact Form
submodule too, so there's a support destination to select:

```bash
drush en client_support client_support_contact_form -y
```

Enabling the submodule installs a core Contact Form called **Support Form** (with Severity, Issue
URLs and Issue attachments fields).

## Grant the permissions

Client Support adds two permissions, assigned under **People → Permissions**:

- **`access client support`** — lets a role see and use the Support tab. Grant this to the
  editors/clients who should be able to ask for help. (They also need access to the destination —
  for the Contact Form submodule, core's *"Use the site-wide contact form"* permission.)
- **`administer client support`** — lets a role configure the module (choose the active plugin).
  Because support requests can contain personal data, grant this only to your support staff.

## Verify it worked

Select the active plugin and set the recipient email address (see
[Configuration](../configuration/index.md)), then log in as a user with `access client support`,
click the **Support** tab in the admin toolbar, and submit a test request. The configured recipient
should receive an email containing the submitter's name and email and the message.
