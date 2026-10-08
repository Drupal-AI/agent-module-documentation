# Sheephole helper — manual setup guide

**Sheephole helper** (`sheephole_helper`) is a bridge between Drupal's Project
Browser and a small desktop application called Sheephole that runs on your own
computer. Its whole reason to exist is to let a non-technical site owner install
contrib modules *the right way* — with Composer, over SSH — without ever opening a
terminal or learning what SSH and Composer are.

Here is the shape of it. When you browse for modules in Project Browser, this
module adds a download button next to each one. Clicking that button hands the
module's machine name to the Sheephole desktop app, which is listening quietly on
your own machine at `http://127.0.0.1:41295`. The desktop app already knows your
server's SSH login (you set that up once as a "profile"), so it opens the SSH
connection and runs the Composer command that installs the module. Nothing about
the Composer install happens inside Drupal — Drupal only points at the local
helper and lets it do the heavy lifting. The Sheephole app is free and open
source, and it needs Java 17 on your computer (not on your server).

The sensible practice is to treat this module as a **setup-time convenience**:
use it while you are getting the site going, then restrict or remove the helper
routes once you are done.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Project Browser.

## Where it lives in the admin menu

Sheephole helper has no settings form of its own. It surfaces entirely inside
**Project Browser** — go to **Extend → Browse** (`/admin/modules/browse`), and as
long as the Sheephole desktop app is running you will see the extra download
button on each module.
