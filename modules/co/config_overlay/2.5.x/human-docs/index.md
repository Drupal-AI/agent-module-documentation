# Config Overlay — manual setup guide

**Config Overlay** (`config_overlay`) changes what ends up in your configuration export.
Instead of exporting every configuration object your site has — including the hundreds of
files that modules and the install profile ship by default and that you never touch — it
manages your export as an **overlay** over that shipped default configuration. After you
install it and re‑export, the export directory keeps only the files that have actually been
*added or changed* relative to what modules provide out of the box.

The practical effect is dramatic. Exporting a standard Drupal install normally produces
close to 200 files that land in Git for every project even though most will never change;
with Config Overlay that drops to just over a dozen. As you customise the site the number
grows again, but it always reflects only *your* differences. There is a second benefit for
teams running several similar sites: put the common configuration in a shared module or
install profile, and each site's export shrinks back to only the config unique to that
site.

Config Overlay has **no configuration UI and no settings of its own** — installing it is
the setup. It plugs into the standard configuration workflow, so you keep using
`drush config:export` and `drush config:import` exactly as before; the module simply
changes *what* gets written. It affects export/import only, not runtime behaviour, and it
plays no access‑control role. It works on Drupal `^9.5 || ^10 || ^11`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and re‑export
   your configuration.

There is **no configuration page** for this module — it has no settings form. Everything
happens through the normal config export/import commands described below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Run a full configuration export — `drush config:export` (`drush cex`). From this point
   on, the export directory will contain only the configuration that differs from the
   shipped defaults of your installed modules and profile.
3. Commit the (now much smaller) export to Git as usual.
4. On other environments, `drush config:import` (`drush cim`) as normal — Config Overlay
   reconstructs the full active configuration by layering your overlay on top of the
   modules' defaults.

> **Fresh‑install note.** Using Config Overlay *during* a brand‑new site install from
> configuration may require a core patch (from the core issue "Dispatch config
> transformation event during site install from configuration"). If a site install does not
> pick up all configuration, running a configuration import immediately after installation
> restores anything that was missed. This only matters for installing a site from a config
> overlay — it does not affect the day‑to‑day export/import workflow on an already‑running
> site.

Config Overlay's test suite explicitly covers working alongside
[Config Ignore](https://www.drupal.org/project/config_ignore) and
[Config Split](https://www.drupal.org/project/config_split), so it fits comfortably next to
those tools.
