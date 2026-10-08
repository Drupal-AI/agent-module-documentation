# Login Destination — manual setup guide

**Login Destination** (`login_destination`) lets you control where users land after
they log in, register, use a one-time (password-reset) login link, or log out —
instead of leaving them on Drupal's default destination. You might send editors
straight to the content overview after login, drop newly registered users on a
welcome page, or return everyone to the front page on logout.

You configure this by creating **rules**. Each rule pairs one or more **triggers**
(Registration, Login, One-time login link, Logout) with a **destination**, plus
optional **conditions** on the user's roles, the page they came from, and the
current language. When a trigger fires, the module checks all enabled rules in
**weight order** and redirects to the destination of the **first one that matches**,
so ordering sets priority. Destinations can be an internal path, a node picked by
autocomplete, an external URL, `<front>`, or `<current>` (the page the user came
from), and they support user and global tokens like `[user:name]` that are replaced
at redirect time.

The module works once you add at least one rule — enabling it alone changes nothing.
It depends only on core's **Path Alias** (`path_alias`) module, stores its rules as
configuration entities (so they export and deploy cleanly), and has no submodules.
This is a **beta** release. A small settings form adds two advanced options for how
the module cooperates with Drupal's own `?destination=` parameter and one-time login
links.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and order rules, set
   destinations and conditions, and the two advanced settings.

## Where it lives in the admin menu

Everything is under **Configuration → People → Login destinations**
(`/admin/config/people/login-destination`): the list of rules with add / edit /
delete, and a **Settings** tab for the two advanced options.

## How to use it

Enable the module, then go to the Login destinations screen and **add a rule**.
Choose which triggers it applies to, set the destination, and (optionally) narrow it
with role, page, and language conditions. If you create several overlapping rules,
set their weights so the most specific one is evaluated first. See
[Configuration](configuration/index.md) for the field-by-field walkthrough.
