# Bootstrap UI — manual setup guide

**Bootstrap UI** (`bootstrap_ui`) integrates the Bootstrap CSS framework into
Drupal and gives you an **admin interface for configuring it**. Instead of editing
theme files to enable or customise Bootstrap components, variables, and plugins,
you do it from a settings form in the site's admin area.

This is a theming / front-end feature. It affects how the site *looks* — the
components and styling Bootstrap provides — but it does not change your content or
who can access it. It provides its own permission so you can control who is
allowed to change the Bootstrap configuration.

If you want Bootstrap on your site and would rather configure it through a UI than
by hand-editing SCSS or theme templates, this is the module for that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the Bootstrap settings form for
   components, variables, and plugins.

## Where it lives in the admin menu

Bootstrap UI adds a settings form under **Configuration** (the `bootstrap.settings`
route). Access is limited to users with the module's own permission. See
[Configuration](configuration/index.md).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Grant the module's permission to the role that should manage Bootstrap
   settings.
3. Open the settings form and enable or customise the Bootstrap components,
   variables, and plugins you want.
4. Save, then review the front end to confirm the styling is applied as expected.
