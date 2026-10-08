# Installation

## Requirements

Tasks is a configuration kit, so it leans on several other modules to supply the
behaviour its configuration references:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core **Link** (`link`) and **User** (`user`).
- **Flag** (`flag`) — provides the check‑off / "done" behaviour.
- **Storage** (`storage`) — the entity type the tasks are stored as.
- **Add Content by Bundle**, **Display Link Plus**, and **Draggable Views** —
  used by the provided content type and Views for adding and ordering tasks.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/tasks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the contrib
dependencies (Flag, Storage, Add Content by Bundle, Display Link Plus, Draggable
Views) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tasks -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tasks -y
```

Enabling Tasks also enables its dependencies and installs the bundled
configuration (the task content type, Views, and Flag setup).

## Verify it worked

After enabling, you should have a new task content type and a Views‑powered
listing for it. Add a task as you would any content and confirm it appears in
the list with the ability to reorder and to check it off as done. From here you
can extend the content type with extra fields and tune the Views to suit your
site.
