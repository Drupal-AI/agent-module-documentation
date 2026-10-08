# Show Email — manual setup guide

**Show Email** (`show_email`) lets you display a registered user's email address on
their profile page. Drupal core normally keeps the user `mail` field out of the
display entirely; this module makes it a proper, configurable display component and
adds a **Show email address** field formatter — optionally rendering the address as
a clickable `mailto:` link — so you can surface member or staff contact emails
through Drupal's normal field display pipeline rather than with custom code.

Because it works as a field formatter, you set it up on the user entity's **Manage
display** screen: enable the Email field and choose the **Show email address**
format. The formatter has three options — always **hide user 1's** email (the
super-admin, on by default), **hide the email for chosen roles**, and **enable the
mailto link**. It's view-mode aware, so you can show emails in a "Full" profile
view but not a "Compact" one, or in a members-directory view mode you created.

One important clarification about access: Show Email does **not** add any view
permission of its own. Whether a given visitor sees the address is still governed by
core — the profile and its `mail` field must be viewable by that visitor, and the
display component enabled. This module's hide-user-1 and hide-per-role settings only
*further suppress* the email on top of that. Note too that "hide per role" keys on
the **viewed account's** roles (whose emails are shown), not the viewer's (who may
see them) — to restrict by audience, combine it with core or contrib field/entity
access. It has no dependencies beyond core, no admin page and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enabling the Email display, the
   formatter's three settings, and who can see whose email.

## Where it lives in the admin menu

There is no settings page of its own. You configure it on the user entity's display
settings: **Configuration → People → Account settings → Manage display**
(`/admin/config/people/accounts/display`), and on any user view mode.
