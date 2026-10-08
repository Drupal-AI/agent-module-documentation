# Installation

## Requirements

Ultimate Cron needs **Drupal 9.3+, 10.1+, or 11** (the module declares a core
compatibility of `^9.3 || ^10.1 || ^11`). It has **no other module
dependencies** — nothing extra is pulled in — and no special PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/ultimate_cron -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any packages it
needs to satisfy the requirement.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ultimate_cron -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ultimate_cron -y
```

Once enabled, the cron screens appear under **Configuration → System → Cron →
Jobs** (`/admin/config/system/cron/jobs`), and Ultimate Cron takes over what runs
during cron.

## Trigger cron from outside Drupal (important)

Ultimate Cron takes over **what** cron executes, but it does **not** trigger cron
itself — it still relies on a normal Drupal cron run to fire. For reliable
scheduling you should:

1. **Disable Drupal's built-in Automated Cron.** Go to **Configuration → System →
   Cron** (Cron settings) and set the "Run cron every" interval to **Never**.
   Automated Cron only fires when a visitor loads a page, so on a heavily cached
   site it can miss its window — exactly the reliability problem Ultimate Cron is
   meant to solve.
2. **Trigger cron from the system crontab or Drush instead.** Add a line to your
   server's crontab that runs Drupal cron on a fixed cadence, for example every
   minute:

   ```bash
   * * * * * cd /path/to/drupal && drush cron
   ```

   Ultimate Cron then decides, on each of those runs, which individual jobs are
   actually due. Running the trigger frequently (for example every minute) lets
   per-job schedules like "every 5 minutes" fire accurately.

## Verify it worked

Log in as an administrator and go to `/admin/config/system/cron/jobs`. You should
see the **Cron jobs** list with one row per discovered job:

![The Cron jobs list after installation](../images/jobs.png)

If the page loads, the tabs (Cron Jobs, Run cron, Cron settings) are present, and
each job shows a **Run** button under Operations, the module is installed
correctly. Next, learn how to
[run and schedule jobs](../configuration/index.md).
