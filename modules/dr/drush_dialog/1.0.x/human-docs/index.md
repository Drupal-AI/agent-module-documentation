# Drush dialog — manual setup guide

**Drush dialog** (`drush_dialog`) provides an on-screen overlay for running Drush
commands, aimed at site administrators. It puts a single command input in the
browser so you can run a Drush command without switching to a terminal.

It is a developer and administrator convenience tool. You type a Drush command
into the overlay's text field and press Enter; the command runs on the server and
its output is shown back in the overlay, with a short history of the commands you
have run. The module supports Drupal 9.2 and up, 10, and 11.

Because the tool runs whatever Drush command you type, keep it to trusted
operators — anyone able to use it can run any Drush command available on the site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is an on-screen tool you
open rather than a settings form.

## How to use it

Once the module is enabled, open the overlay, type a Drush command into its input
field, and press Enter to run it; the output appears in the overlay. Restrict its
use to trusted administrators, since the commands it runs are the same powerful
Drush commands you would otherwise run by hand.
