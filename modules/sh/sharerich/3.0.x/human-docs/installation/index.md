# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- The **Token** module (`token`) — required, for the `[sharerich:*]` token
  substitution in button markup.
- Core's **Block** module (`block`) — required, since the buttons are rendered as a
  block.

Composer pulls Token in for you when you install with `-W`; Block ships with Drupal
core. No third-party JavaScript library is needed.

## Install with Composer

From the project root:

```bash
composer require drupal/sharerich -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Token module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharerich -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharerich -y
```

This also enables Token and Block if they are not already on. On install, Sharerich
automatically places one **Sharerich** block in the content region of your default
theme, showing the default button set.

## Grant the permission

All of Sharerich's admin pages are controlled by the restricted **Administer
sharerich** (`administer sharerich`) permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant it only to roles you trust — this permission
allows editing raw button markup.

## Upgrading from 2.x

3.0.x is a major release. When you run database updates
(`drush updatedb`), Sharerich removes the retired Google+ button from your existing
sets and rebrands the Twitter button as **X** (icon and label) while keeping its
`twitter` machine name, so your configuration keeps working. Any button whose icon
or link you had already customised is left untouched. The **Print** and **WhatsApp**
buttons now rely on JavaScript to work (see the main guide); the rest do not.

## Next step

With the module enabled, build a button set, set your global options, and place the
block. See [Configuration](../configuration/index.md).
