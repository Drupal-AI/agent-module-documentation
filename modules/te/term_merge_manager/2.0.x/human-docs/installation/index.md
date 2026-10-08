# Installation

## Requirements

Term Merge Manager builds on the Term Merge module:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **[Term Merge](https://www.drupal.org/project/term_merge)** (`term_merge`) — required;
  Composer installs it for you. (Term Merge in turn works with core's Taxonomy module.)
- Optional: the **[Redirect](https://www.drupal.org/project/redirect)** module. If it
  is enabled and auto‑redirect is turned on, Term Merge Manager will create 301
  redirects from merged source terms to their targets.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/term_merge_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Term Merge and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_merge_manager -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_merge_manager -y
```

Drupal enables Term Merge at the same time if it is not already on.

## Grant permissions

Term Merge Manager defines a set of permissions at **People → Permissions**
(`/admin/people/permissions`), covering who can view, add, edit, delete, and
administer the two kinds of merge rule (the *term merge from* source rules and the
*term merge into* target rules), plus one message toggle:

- **View term merged manager messages** — controls whether a user sees the "we merged
  X into Y" notice when a term they created is auto‑merged.
- The various **add / edit / delete / view … entities** permissions gate the rule
  lists under Structure. The **administer …** permissions are marked as sensitive, so
  grant them only to trusted taxonomy managers.

Most sites can leave the rule permissions to administrators — the automatic merging
works regardless, since it runs on term save rather than through the admin UI.

Once enabled, the module is active immediately; there is nothing else to configure.
