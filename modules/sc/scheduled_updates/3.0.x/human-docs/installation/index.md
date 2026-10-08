# Installation

## Requirements

- **Drupal core `^10.4 || ^11.3 || ^12`.** Note the `^11.3` — earlier 11.x
  releases are excluded — and that the `^12` end reaches toward a core major that
  does not exist yet, so in practice you need 10.4+ or 11.3+.
- Core's **Options** module (`options`).
- The **Inline Entity Form** module (`inline_entity_form`), a contributed
  dependency.

There are no additional PHP or third‑party library requirements. This 3.0.x branch
was updated to modern standards with AI assistance, so the maintainers ask you to
test heavily before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/scheduled_updates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Inline Entity Form
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scheduled_updates -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scheduled_updates -y
```

Drupal will enable the Options and Inline Entity Form dependencies at the same
time if they are not already on.

## Check your cron

Because scheduled updates fire on cron rather than at the exact configured moment,
confirm how often cron runs on this site before you depend on precise timing. If
minute‑level accuracy matters, arrange for frequent cron (for example a system
cron every few minutes) rather than relying on Drupal's automated cron.

## Verify it worked

Go to **Configuration → Workflow → Scheduled Updates → Scheduled Update Types** and
confirm the overview page loads. You are now ready to create your first Scheduled
Update Type — see [Configuration](../configuration/index.md).
