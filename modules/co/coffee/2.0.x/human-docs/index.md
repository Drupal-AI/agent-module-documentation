# Coffee — manual setup guide

**Coffee** (`coffee`) is a keyboard-driven admin navigator for Drupal. Press a
shortcut — for example **Alt + D** — and a quick-search box pops open; start
typing the name of an admin page ("people", "add article", "modules") and press
**Enter** to jump straight there. Think of it as Spotlight or Alfred for your
Drupal admin: instead of clicking down through nested toolbar menus, you search
and go.

Coffee builds its list of destinations from the site's menus, so anything reachable
through the admin menu can be reached in a couple of keystrokes. It is purely a
navigation aid — it never changes any content — and it is especially useful on
large sites with deep, nested admin menus. A toolbar link is also provided as an
alternative way to open the search box.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to configuring which
menus it searches and using the search box day to day. If you are looking for
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Coffee configuration page](images/settings.png)

## Where it lives in the admin menu

Coffee's settings live under **Configuration → User interface → Coffee**
(`/admin/config/user-interface/coffee`). That single page lets you choose which
menus Coffee searches and how many results it shows. Using the search box itself
requires no admin page at all — you trigger it with a keyboard shortcut from
anywhere in the admin interface.

## Contents

1. [Installation](installation/index.md) — install Coffee with Composer, enable it,
   and grant the permission needed to use it.
2. [Configuration and usage](configuration/index.md) — choose which menus are
   searched, cap the number of results, and learn how to open and use the search
   box.
