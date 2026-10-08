# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Field Group** (`field_group`) — the contributed module this one extends. It
  provides the field‑grouping tools that Inline Popup Field Group adds a new format
  to.

> **Note on security coverage.** This project is **not** covered by Drupal's
> security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_popup_field_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch the Field Group
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_popup_field_group -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it (Drush will enable the required Field Group module automatically):

```bash
drush en inline_popup_field_group -y
```

## Verify it worked

Go to **Structure → Content types → *(a type)* → Manage form display** and use
Field Group's **Add group** control. In the format list you should now see the
**popup** ("Popup Fake container") option. Choosing it, moving a field or two into
the group, and setting the group's **Link text** is all it takes — see
[How to use it](../index.md#how-to-use-it) for the full walkthrough.
