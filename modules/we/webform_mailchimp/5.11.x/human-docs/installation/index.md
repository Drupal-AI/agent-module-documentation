# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Webform** module (`drupal/webform`, `^6.2`).
- The **Mailchimp** module (`drupal/mailchimp`, `^2.2 || ^3`) — this holds your
  Mailchimp API key and knows about your audiences, merge fields, and interest
  groups.
- A working **Mailchimp account**, an **API key**, and at least one **audience
  (list)**. Without these the handler cannot subscribe anyone.

Composer pulls in both the Webform and Mailchimp modules as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_mailchimp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Webform and Mailchimp.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_mailchimp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_mailchimp -y
```

This also enables Webform and Mailchimp if they are not already on.

## Connect the Mailchimp module first

Before the handler can do anything, configure the **Mailchimp** module with your
Mailchimp **API key** (**Configuration → Web services → Mailchimp**), then pull in
your audience(s) so they appear in Drupal. Once your audience, merge fields, and
interest groups are visible there, continue to
[Configuration](../configuration/index.md) to add the handler to a webform.
