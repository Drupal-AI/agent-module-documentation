# Drupal Module Upgrader — manual setup guide

**Drupal Module Upgrader** (`drupalmoduleupgrader`, often shortened to *DMU*)
is a developer tool that reads the source of an old **Drupal 7 module** and tells
you — and in many cases rewrites for you — what has to change so the module can
run on a modern Drupal 10 or 11 site. It is a command-line tool: you drive it
entirely through Drush, and its main output is a report.

Porting a custom module away from Drupal 7 is a large job with a small creative
core. The bulk of it is mechanical translation — hooks became services and event
subscribers, `hook_menu` became routing YAML plus controllers, `drupal_add_js`
became asset libraries, `db_query` became the database API, variables became
configuration, and forms became classes. DMU finds each of those instances,
links you to the relevant API change notice so you can read more, and, where the
pattern is safely convertible, attempts the conversion automatically. That turns
an intimidating rewrite into a reviewable checklist.

Treat its output as a starting point, not a finished port. A module that runs is
not necessarily a module that is *correct*, and the parts a tool cannot convert
are usually the parts that carried the original author's intent. The module is on
minimal maintenance ("life support") to help people through the Drupal 7
end-of-life migration — Drupal 7 reached end of life in January 2025 — so the
honest first question for each legacy module is whether a modern contrib module
now covers the same need and makes the port unnecessary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — set `minimum-stability` to `dev`,
   install with Composer, and enable the module.

There is **no configuration page** for this module. It is a Drush command
provider, described under "How to use it" below.

## How to use it

DMU works on Drupal 7 module source that you have placed inside your modern
site's `modules/` directory. From the Drupal root, run its two Drush commands:

- **Analyse** a module and get a report of what needs updating and how:

  ```bash
  drush dmu-analyze MODULE_NAME
  ```

  The report lists the code that must change and points to any relevant API
  change notices where you can read more.

- **Attempt an automatic upgrade** of the module's code to modern Drupal:

  ```bash
  drush dmu-upgrade MODULE_NAME
  ```

  The script prints a few lines as it works through the conversions it can do.
  Afterwards, look inside `modules/MODULE_NAME` and review the new YAML files and
  rewritten classes it generated — then finish by hand whatever it could not
  convert.
