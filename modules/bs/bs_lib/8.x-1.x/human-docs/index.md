# BS Lib — manual setup guide

**BS Lib** (`bs_lib`) is a component‑oriented Bootstrap library module for the
`bs_base` theme family, plus a set of Drush commands for scaffolding new
`bs_base`‑compatible child themes. In that family the **theme** provides the
Bootstrap foundation and this **module** carries the shared component library,
templates, and the generator commands — so on a project already committed to
`bs_base` it removes the boilerplate of standing up a child theme by hand. It has
no declared dependencies and supports Drupal 9.2 through 11.

> **Critical warning — read before enabling.** Enabling BS Lib without the
> `bs_base` theme installed **breaks the entire Drush CLI for the site**, and this
> was verified from source. The module's Drush command constructor calls
> `ThemeHandler::getTheme('bs_base')`, which *throws* when the theme is not
> installed — and because Drush instantiates every command service at bootstrap,
> that one constructor takes down every Drush command on the site, even ones with no
> connection to it.

The failure signature is what makes this dangerous. In the verified case the website
kept returning **200** on the front page and login while `drush status` failed with
*"The theme bs_base does not exist."* A deployment check that just curls the site
sees a healthy site; the breakage only surfaces when someone runs a Drush command —
which on most projects is during a release. And it cannot be undone the easy way:
**`drush pm:uninstall bs_lib` cannot run either** (it is a Drush command, so it fails
too), and recovery required removing the module from `core.extension` with a direct
database edit.

`bs_lib.info.yml` declares no dependencies at all, and Drupal has no mechanism for a
module to require a *theme* at install time, so nothing stops `drush en bs_lib` on a
site without `bs_base`. The rule is simple: **install the `bs_base` theme first, or
do not install this module.**

This guide is written for a **human**. If you want terse, token‑cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module safely (with the `bs_base` theme in place first).

## Where it lives in the admin menu

BS Lib adds no admin pages, permissions, or settings form. It contributes a shared
Bootstrap component library to the `bs_base` theme family and exposes its
functionality through **Drush commands** that generate `bs_base`‑compatible child
themes — you work with it from the command line, not an admin screen.

## How to use it

1. **Install and enable the `bs_base` theme first** — this is a hard prerequisite,
   not a suggestion (see the warning above).
2. Install and enable BS Lib (see [Installation](installation/index.md)).
3. Use its Drush command to scaffold a new `bs_base`‑compatible child theme, then
   build on the shared Bootstrap components it provides.
4. After enabling any module with Drush integration, run `drush status` to confirm
   the CLI still works — if it fails with *"The theme bs_base does not exist"*, you
   enabled BS Lib without its theme; reinstall the theme (or remove the module from
   `core.extension`) to recover.
