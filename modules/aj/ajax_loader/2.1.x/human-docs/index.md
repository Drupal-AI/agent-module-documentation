# Ajax Loader — manual setup guide

**Ajax Loader** (`ajax_loader`) replaces Drupal's plain default AJAX throbber —
the little spinner shown while an AJAX request is in flight — with a polished,
configurable animated loader. It ships twelve ready-made SpinKit-style animations
(pulse, wave, chasing dots, folding cube, circle, and more), so you can pick a
loading indicator that fits your site's look with a single setting.

Once you choose a throbber on the settings form, the module attaches it site-wide
and hooks into Drupal's AJAX lifecycle to show and hide it automatically —
whenever a Views AJAX pager refreshes, an exposed filter reloads, an autocomplete
fires, a multi-step form submits, and so on. You can have it render as a
full-screen overlay for long operations (which also discourages impatient
double-clicks), suppress the core "please wait" message, choose whether it also
appears on admin pages, and control exactly where in the page it's injected using
a CSS selector.

For developers, the throbbers are a plugin type: you can add your own branded
loader by writing a `@Throbber` plugin with its own markup and CSS. The module
has no dependencies beyond Drupal core and adds no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — pick a throbber and tune how and
   where it appears.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Ajax loader**
(`/admin/config/user-interface/ajax-loader`).

## How to use it

1. Install and enable the module.
2. Open the settings form, pick one of the twelve throbbers, and save.
3. Clear caches (`drush cr`) — the chosen throbber's CSS is baked into the
   module's libraries, so a rebuild is needed for changes to show.

See [Configuration](configuration/index.md) for each option.
