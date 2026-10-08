# Bootstrap UI Kit — manual setup guide

**Bootstrap UI Kit** (`bootstrap_ui_kit`) supplies a set of branded interface
components — cards, alerts, badges, button groups, and the like — that take their
styling from **your site's own theme** rather than shipping Bootstrap's default
look. The recurring problem it solves is that Bootstrap components look like
Bootstrap: a carefully themed site still shows the framework wherever a component
is used unmodified, which is most places, because overriding each one by hand is
work nobody budgets for.

By inheriting the theme's colours, spacing, and typography, the kit makes those
components look like *the site* by default, so the framework becomes an
implementation detail instead of a visual signature. It is configured from its own
settings form.

Two things are worth knowing about what "inheriting from your theme" needs to
work. First, your theme has to expose its values as something inheritable — CSS
custom properties or Bootstrap's own SCSS variables; a theme that hard-codes
colours in compiled CSS has nothing for the kit to inherit from. Second,
components carry accessibility behaviour, not just appearance — an alert needs a
role, a badge needs contrast at its size, a button group needs keyboard
navigation. A component library gets those right (or wrong) once for the whole
site, so it is worth checking the markup, not only the styling.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the UI Kit settings form.

## Where it lives in the admin menu

The kit adds its own settings form under **Configuration** (the
`bootstrap_ui_kit.settings` route). See [Configuration](configuration/index.md).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure your theme exposes its design values as CSS custom properties or
   Bootstrap SCSS variables, so the kit has something to inherit.
3. Open the kit's settings form and adjust the options it offers.
4. Use the kit's components in your content and templates, then check that they
   pick up the theme's colours, spacing, and typography — and that their markup is
   accessible.
