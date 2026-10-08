# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Webform** module (`webform`) — required, since this tracks webform
  submissions.
- The base **SharpSpring** module (`sharpspring`) — required, and it must be
  configured with your SharpSpring account for tracking to work.

Composer pulls both dependencies in when you install with `-W`.

## Install with Composer

From the project root:

```bash
composer require drupal/sharpspring_webforms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Webform and SharpSpring modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharpspring_webforms -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharpspring_webforms -y
```

This also enables Webform and SharpSpring if they are not already on.

## Next steps

1. Configure the base **SharpSpring** module with your SharpSpring account so
   tracking has somewhere to report.
2. Select which webforms should be tracked in SharpSpring. Only the forms you choose
   will have their submissions linked to SharpSpring leads.

Remember to disclose the data flow and honor visitor consent, since form data is sent
to a third-party marketing platform.
