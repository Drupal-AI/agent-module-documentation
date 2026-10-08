# Account Field Split — manual setup guide

**Account Field Split** (`account_field_split`) breaks apart the single, bundled **"User name
and password"** block on Drupal's account form so you can arrange each piece independently.
Out of the box, the username, email, password, roles, status and other identity fields are
locked together in one draggable row on the user **Manage form display** screen — you can't
put email above username, hide the "Current password" confirmation, or drop individual pieces
into a field group. This module fixes exactly that.

Once enabled, it splits that bundled element into **seven separate fields** on the user form
display — Username, E‑mail address, Password, Current password, Roles, Status, and "Notify
user about new account" — each with its own weight and its own visible/hidden setting. From
then on you rearrange, hide, or group them using the **standard Manage form display UI**,
just like any real field. It plays nicely with the Field Group module and lets you interleave
the account fields with custom profile fields (picture, bio, timezone, and so on).

The module has **no settings form, no permissions, no config of its own, and no Drush
commands** — all your changes are saved into Drupal's normal user form‑display configuration,
so they export and deploy like any other config. It has no dependencies beyond Drupal core. It
works the moment you enable it (it sets its own weight so its adjustments run after other
modules), and it cooperates with the *Simple Password Reset* module by leaving the anonymous
password‑reset flow alone.

This guide is written for a **human** rearranging the account form in the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

Account Field Split adds **no page of its own**. You do all your work on the core user form
display at **Configuration → People → Account settings → Manage form display**
(`/admin/config/people/accounts/form-display`). Before enabling, that screen shows one bundled
*User name and password* row; after enabling, it shows the seven separate fields instead.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → People → Account settings → Manage form display**
   (`/admin/config/people/accounts/form-display`).
3. You'll now see seven independent rows in place of the old bundled element:
   **Username**, **E‑mail address**, **Password**, **Current password**, **Roles**,
   **Status**, and **Notify user about new account**.
4. Rearrange them by dragging, exactly as you would other fields — for example drag
   **E‑mail address** above **Username** for an email‑first registration form.
5. To hide a field, drag it into the **Disabled** region at the bottom (for instance, hide
   **Current password** or **Status**). To reveal it again, drag it back up.
6. If the **Field Group** module is installed, you can drop these fields into groups (e.g. put
   Roles and Status into an "Admin" group), and you can interleave them with real user fields
   like the user picture or a bio.
7. Click **Save**.

Your arrangement is stored in the standard user form‑display configuration, so it exports with
config sync and can be version‑controlled and deployed. To restore Drupal's original bundled
behavior, simply uninstall the module.
