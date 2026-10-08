# Drush 9 Commands Example — manual setup guide

**Drush 9 Commands Example** (`drush9_example`) is a developer reference module.
It exists to answer the question "how do I write custom Drush commands for a
modern Drupal site?" by giving you a small, working example you can read and copy
from — the structure of a command class, how services are wired in, and how
options and arguments are declared.

Since Drupal 8.4, Drush 9 (and later) is the supported way to run Drush commands,
and the way you register a custom command changed from the old `.drush.inc`
approach to command classes. This module demonstrates that modern pattern so you
do not have to reverse-engineer it from core or another contrib module.

It is a learning aid, not a feature you run on a live site. Install it on a
development environment, study the code, adapt it into your own module, and then
remove it. It has no settings, no admin pages, and no runtime behavior beyond the
example commands themselves. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module on a development environment.

There is **no configuration page** for this module — it is example code you read
and copy, described under "How to use it" below.

## How to use it

1. Install and enable the module on a local or development site (see
   [Installation](installation/index.md)).
2. Open the module's source in your editor and read the example command class,
   its service definitions, and its use of options and arguments.
3. Copy the parts you need into your own custom module, renaming the command,
   class, and service to match your project.
4. Once you have your own command working, disable and remove this example module
   — it is not meant to stay installed.
