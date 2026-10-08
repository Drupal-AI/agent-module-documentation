# Navigation — manual setup guide

**Navigation** (`navigation`) provides the "new administration navigation" for
Drupal — a left‑aligned, collapsible **vertical sidebar** for the admin UI,
designed to replace or augment the horizontal Toolbar. It gives administrators a
modern, space‑efficient way to move around the back end, with the admin menu laid
out down the side rather than across the top.

**Important — this feature has moved into Drupal core.** This contributed module
was the incubation ground for Drupal's Navigation initiative, and that work now
lives in core (from Drupal 10.3+, maturing through 11). The maintainers recommend
**not** using this contrib module on new sites, because the version here lags
behind the core implementation. If your Drupal version already ships the core
Navigation module, enable and use **that** instead of this contrib project. Treat
this guide as applying only to older setups where the contrib module is still the
way to get the sidebar.

The navigation is a presentation feature, not an access‑control one: it simply
reflects the admin links a user already has permission to see, so it changes how
the admin menu looks, not what anyone can reach. It depends on core **Block** and
**File** and provides its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and how this relates to core Navigation).

## Where it lives in the admin menu

The module's settings are provided by the `navigation.settings` configuration,
where you manage the navigation blocks and items that make up the sidebar. On
current Drupal, this same configuration is provided by the **core** Navigation
module — so if you are on a version of core that includes Navigation, configure it
there rather than through this contrib module.

## How to use it

Once enabled, the left sidebar replaces the top toolbar for administrators. You
customize which blocks and items appear in it through the navigation settings
described above. Because the sidebar only shows links the current user already has
access to, no additional access configuration is needed — grant the module's
permissions to the roles who should use and manage the navigation, then arrange
the sidebar to taste.
