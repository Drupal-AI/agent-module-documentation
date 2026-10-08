# Simple Terms and Menus — manual setup guide

**Simple Terms and Menus** (`simple_terms_and_menus`) tidies up Drupal's taxonomy
term and menu-link forms for sites with a simple structure. Out of the box those
forms carry a lot of options that a straightforward setup never touches, which
makes them feel bulky. This module trims the clutter, adds a few conveniences, and
opens the add and edit links inside a modal so editors can work without leaving the
page they're on.

It's a content-editing quality-of-life module rather than a feature that changes
what your site does. There's no configuration form — you enable it and the forms
are streamlined immediately. It provides one permission, **Use advanced menu
options**, which brings back the original, full forms for the roles that need them;
grant it to any role that still requires the complete term and menu forms.

The module has no dependencies beyond Drupal core and works on Drupal 8.9 through
11. It has no content or access-control role of its own beyond that single
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and grant the permission where needed.

## How to use it

There's nothing to configure. Once enabled, the taxonomy term and menu-link forms
are simplified for everyone, and add/edit links open in a modal. If some roles need
the full, unsimplified forms, go to **People → Permissions**
(`/admin/people/permissions`) and grant them **Use advanced menu options** — those
users then keep the original forms.
