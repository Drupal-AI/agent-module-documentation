# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Contextual Links** (`contextual`), **Editor** (`editor`), **Field**
  (`field`), and **Filter** (`filter`) modules — these are the dependencies, and
  Drupal enables them automatically when you turn Quick Edit on. (The Editor module
  is what provides the WYSIWYG in-place editor for formatted-text fields, typically
  with CKEditor 5.)

There are no third‑party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/quickedit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quickedit -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quickedit -y
```

That's all the setup the module itself needs — there is no configuration form. Quick
Edit works as soon as it's enabled and a user has the right permission. Next, grant
the **Access in-place editing** permission and start editing on the page — see
[How to use it](../index.md#how-to-use-it).

## Verify it worked

Grant the **Access in-place editing** permission to your role at **People →
Permissions**, then visit a piece of content while logged in as that user. Hover over
the content — the contextual "pencil" links should appear, and clicking through lets
you edit a field in place and save without a full page reload.
