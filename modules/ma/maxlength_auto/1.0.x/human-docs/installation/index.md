# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **MaxLength** module (`maxlength`) — this is the module that actually renders
  the character counter. MaxLength Auto depends on it and simply turns it on
  automatically for length‑limited fields. Composer installs it for you with the
  command below.

## Install with Composer

From the project root:

```bash
composer require drupal/maxlength_auto -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
MaxLength module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maxlength_auto -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maxlength_auto -y
```

Drupal will enable **MaxLength** at the same time if it isn't already on. There is no
configuration step.

## Verify it worked

Edit any content type that has a text field with a maximum length (for example the
default **Title** field). On the edit form, the field should now display a live
character counter as you type — that's MaxLength Auto applying the MaxLength counter
without any per‑field setup.
