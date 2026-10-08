# SDC CSS Relocator — manual setup guide

**SDC CSS Relocator** (`sdc_css_relocator`) is a small utility module that fixes a
CSS-ordering problem with Single Directory Components (SDC). It relocates each
component's stylesheet into the theme's CSS group so component CSS is grouped and
ordered with your theme's CSS rather than sitting in the default library group.

The problem it solves is a real Drupal core issue (see
[#3374901](https://www.drupal.org/i/3374901)): stylesheets added by Single Directory
Components can be output in the wrong order, which causes component styles to be
overridden unexpectedly — particularly noticeable once CSS aggregation is turned on.
This module finds the component libraries and reassigns them to the
`THEME_AGGREGATE` group, giving you the correct cascade and override behaviour and
cleaner aggregation.

It **works the moment you enable it** — there is no settings form and nothing to
configure. It changes only how stylesheets are grouped and aggregated, never your
content or anyone's access. This is an early release (`1.0.0-alpha2`), so test it on
a non-production copy first. It is a good fit for any SDC-based theme where component
CSS needs to sit in the theme group.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to use beyond enabling it. Once active, component stylesheets are
automatically relocated into the theme's CSS group. If you had CSS aggregation
enabled, rebuild the cache (`drush cr`) after enabling so the change is reflected in
the aggregated output.
