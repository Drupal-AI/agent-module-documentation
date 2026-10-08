# Simple Password Reveal — manual setup guide

**Simple Password Reveal** (`simple_password_reveal`) adds a small show/hide toggle
to password fields on the **user login** and **user edit** forms, so people can see
what they are typing and avoid mistyped passwords. Its distinctive choice — stated
plainly in the module's own description — is that **passwords are shown in plain
text by default**, and the toggle is there to *conceal* them when you want to.

The reasoning the author gives is that clicking to reveal a password every single
time is friction, and most of the time — alone at your own machine — you would
rather just see it; the only moments you want it hidden are in public or during a
presentation. So the module flips the usual default: the field renders in plaintext,
and a single checkbox lets you mask it.

It keeps things deliberately simple. It focuses only on the login and user edit
pages, and it adds **one checkbox per form** rather than one per field — so on the
user edit page, where there are three password fields (current, new, and confirm),
you get a single toggle that governs all of them. It does not cover custom forms,
AJAX-loaded forms, or Drupal 7. The module has no dependencies, no submodules, and
no settings form; it works purely by altering those forms once enabled.

This guide is written for a **human**. If you want terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

### Please weigh the default before you deploy this

Because passwords are shown by default, anyone who can see the screen sees the
password as it is typed — a colleague nearby in an office, someone at a shared or
kiosk machine, or a viewer of a screen-share or a recording. That is **increased
shoulder-surfing exposure**, and for many sites masked-by-default is the safer
choice. If you use this module, consider whether it belongs only on low-risk forms,
and be mindful of where your users log in. It is a front-end usability enhancement
only; it has no server-side or access-control behaviour and does not change how
passwords are stored or validated.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

There is nothing to configure. Once the module is enabled, visit the user login
page or a user edit page: the password field(s) will display in plain text, and a
checkbox on the form lets anyone conceal the password when they need privacy.
