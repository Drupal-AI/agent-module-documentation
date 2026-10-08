# Simple Environment Indicator — manual setup guide

**Simple Environment Indicator** (`simplei`) shows a small, colored environment
label — such as *Local*, *DEV*, *Staging*, or *Production* — in Drupal's admin
Toolbar or in the core Navigation top bar. It is a lightweight way to make sure
editors and developers always know which environment they are looking at, so
nobody accidentally edits production thinking they are on a test site.

What makes it "simple" is that it is configured entirely from a **single line in
`settings.php`** — there is no database configuration, no settings form, and no
permissions to manage. You give it a short string describing the color and label
you want, and the module works out the foreground color, background color, and
environment label from it. Because the configuration lives in `settings.php`, it
naturally travels with each environment: your production settings show a red
"Production" badge, your staging settings a distinct color, and so on.

The label adapts to how your site presents admin navigation. On sites using
Drupal's core Navigation module it appears in the top bar; on classic sites it is
injected into the Toolbar. It works nicely alongside the Gin admin theme, and it
can optionally show an indicator to anonymous visitors too — handy for making
non‑production tiers obvious to everyone.

Simple Environment Indicator requires **Drupal 10.1, 11, or 12** and has no
dependencies beyond core. It is deliberately tiny — a lightweight alternative to
the heavier Environment Indicator module.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the `settings.php` options, with all
   the color and label formats and the anonymous‑visitor option.

## Where it lives in the admin menu

Simple Environment Indicator has no admin page. It is configured only in
`settings.php` (or `settings.local.php`), and the indicator itself appears in the
Toolbar or Navigation top bar for users who can see them.

## How to use it

Add a line like `$settings['simple_environment_indicator'] = '@production';` to
the `settings.php` of each environment, choosing a color and label to match. The
badge appears immediately for users who can access the toolbar or navigation. See
[Configuration](configuration/index.md) for every format you can use.
