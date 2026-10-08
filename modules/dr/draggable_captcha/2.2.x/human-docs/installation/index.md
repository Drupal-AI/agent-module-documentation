# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **CAPTCHA** module (`captcha`) — Draggable CAPTCHA is a challenge type for
  it and cannot work without it.
- The **jQuery UI Droppable** module (`jquery_ui_droppable`) — provides the
  drag‑and‑drop library the challenge is built on.
- **GD library** with PNG support, plus rotate and desaturate effects, on your
  PHP install (used to render the challenge images).

There are no additional Composer PHP‑library requirements beyond the modules
above.

## Install with Composer

From the project root:

```bash
composer require drupal/draggable_captcha -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including the CAPTCHA and jQuery UI Droppable modules — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/draggable_captcha -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en draggable_captcha -y
```

Drush enables the required `captcha` and `jquery_ui_droppable` modules
automatically as dependencies.

## Verify it worked

1. Go to **Configuration → People → CAPTCHA module settings**
   (`/admin/config/people/captcha`).
2. On the **Form settings** tab, confirm **Draggable CAPTCHA** is available as a
   challenge type you can assign to a form.
3. Assign it to a test form and load that form as an anonymous visitor to see the
   challenge render.

For the full setup walkthrough, see "How to use it" in the
[overview](../index.md).
