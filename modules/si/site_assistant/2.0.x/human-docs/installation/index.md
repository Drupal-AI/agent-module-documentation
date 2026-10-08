# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11`).
- The **Inline Entity Form** module (`inline_entity_form`), which lets you edit the
  assistant's list entries directly within the assistant form. Composer pulls it in
  as a dependency.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/site_assistant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Inline Entity Form.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_assistant -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_assistant -y
```

Drush enables Inline Entity Form automatically. If you enable through the UI at
**Extend** (`/admin/modules`), confirm when Drupal offers to turn on the dependency.

## Verify it worked

After enabling, grant the relevant Site Assistant permissions (including
`administer site_assistant`) to the roles that will build assistants, then create your
first assistant — give it some content entries and a visibility condition — and load a
page that matches the condition to confirm it appears.
