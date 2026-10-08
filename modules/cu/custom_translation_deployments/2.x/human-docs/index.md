# Custom Translation Deployments — manual setup guide

**Custom Translation Deployments** (`custom_translation_deployments`) makes it
possible to keep custom interface-translation (`.po`) files in your translations
directory and **deploy translation overrides alongside your code**. Normally, when
you reword an interface string in Drupal, that override lives only in the database
and doesn't travel with a deployment. This module lets those custom `.po` files
ship in your project (typically under version control) and get imported
automatically during a locale update — so your string changes deploy like any
other artifact.

It's a developer/deployment tool with no admin settings screen and no security
surface. It depends on Drupal core's **Locale** (interface translation) module and
supports Drupal 8 through 11. Two approaches are supported: a ready-made
project-specific translation file the module recognizes, or your own custom files
registered through a hook (handy for an agency or distribution that reuses the same
overrides across sites).

Because it's a deployment workflow rather than a configuration form, there's
nothing to click through in the admin UI. See "How to use it" for the process.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. Setup
is a file-and-deploy workflow, described below.

## How to use it

The typical deployment workflow has three parts:

1. **Have a translation file you can update.** You have two options:
   - **Use the module's default project file.** Place a file named
     `project_specific-custom.LANGUAGE.po` (for example
     `project_specific-custom.nb.po` for Norwegian) in your translations folder,
     with the standard `.po` header and your `msgid`/`msgstr` overrides. The module
     imports it automatically on locale updates.
   - **Register your own custom files.** Implement
     `hook_custom_translation_deployments_files()` in a module to declare
     additional translation files the system should expect in the translations
     directory (useful for shared agency/organization overrides). Files then follow
     a name like `custom-<version>.LANGUAGE.po` (e.g. `custom-mycompany.nb.po`).

2. **Keep the translation files in version control.** For example, store them in
   `PROJECT_ROOT/translations`, and set that path as your interface-translations
   directory in Drupal's **File system** settings so Drupal looks for them there.

3. **Import them during deployment.** Add a step to your deploy job that updates
   translations — for example running `drush locale-update` — so the custom `.po`
   files are picked up and applied on each deployment.

> **Tip:** After deploying, confirm the shipped translations are the overrides you
> intended and don't unexpectedly change strings elsewhere on the site.
