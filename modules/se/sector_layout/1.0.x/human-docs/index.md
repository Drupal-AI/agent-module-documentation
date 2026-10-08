# Sector Layout — manual setup guide

**Sector Layout** (`sector_layout`) provides a ready-made set of **Layout
Builder** layouts and configuration for the **Sector** distribution, so
Sector-based sites get a consistent set of layout options out of the box instead
of relying only on core's handful of default layouts.

The problem it solves is layout consistency across a Sector site: rather than each
site builder hand-rolling column arrangements, the module ships the standard Sector
layouts as configuration, ready to choose whenever you add a section in Layout
Builder. It is a site-building / layout feature and has no content or
access-control role.

The module works as soon as it is enabled — there is no settings form to fill in.
Once on, its layouts simply appear in the Layout Builder section chooser. It
depends on core's **Layout Builder** module and supports Drupal 10 and 11. (Its
package is marked experimental in Sector's own listing, so treat it as
distribution infrastructure.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

With Sector Layout enabled, open a layout in **Layout Builder**, add a section,
and the Sector layouts appear as options in the layout chooser alongside core's
defaults. Pick one and build your section as usual. There is nothing else to
configure.
