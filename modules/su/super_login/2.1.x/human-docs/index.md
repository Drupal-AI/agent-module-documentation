# Super Login — manual setup guide

**Super Login** (`super_login`) polishes Drupal's built-in **login**,
**registration**, and **password-reset** forms. Out of the box those forms are
functional but plain; Super Login lets you relabel fields and buttons, add
placeholder text, autofocus the username field, show a "Caps Lock is on"
warning, tidy up the page tabs, and generally give visitors a friendlier
sign-in experience — all from one settings form, without writing a custom theme.

Its headline feature is **Login Type**: you can let people sign in with their
**username or their email address**, with the **username only**, or with the
**email only**. This is handy for intranets and corporate sites where everyone
knows their email but not necessarily their Drupal username. Behind the scenes it
works by looking up the account by email and handing core the matching username,
so it plugs into Drupal's normal authentication rather than replacing it.

Everything Super Login does is a set of tweaks to the existing forms — it adds no
new pages, no permissions of its own, and no third-party dependencies. All of its
behaviour is controlled from a single settings page, and the settings are stored
in one exportable config object, so you can ship consistent login copy and
behaviour across a multisite or bundle it into a recipe.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the exact config keys and
Drush commands — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the Super Login settings form, field
   by field, including the Login Type options.

## Where it lives in the admin menu

Once enabled, Super Login's changes appear automatically on the login,
registration, and password-reset pages. Its settings form sits at
**Configuration → People → Super Login Settings**
(`/admin/config/people/super_login/settings`) and is available to any user with
the **Administer site configuration** permission.

## How to use it

Enable the module, then open **Configuration → People → Super Login Settings** to
adjust the login pages. Pick a **Login Type** (username-or-email, username-only,
or email-only), relabel fields and buttons to match your site's voice, and toggle
the extras you want — the caps-lock warning, placeholders, autofocus, and the
module's own stylesheet. See [Configuration](configuration/index.md) for a
walkthrough of every option.
