# Telephone — manual setup guide

**Telephone** (`telephone`) provides a proper phone-number field: a `telephone`
field type, a widget for entering numbers, and a formatter that renders the
stored number as a clickable `tel:` link — the behaviour that lets a visitor tap
a number on their phone to dial it.

This is not a new project so much as a rescue of an old one. Telephone used to
ship inside Drupal core, but core stopped including it after Drupal 11.3. This
contrib project is that same module, continued as a standalone download for
Drupal 11.4 and later. Crucially, the machine name, the field type id, the
widget id, and the formatter id are all unchanged from the core version — so a
site upgrading past 11.3 simply requires this project and everything keeps
working: existing fields, display settings, and exported configuration all
carry over untouched.

On Drupal 11.3 and earlier you do **not** need this project — the identical
module is still part of core. Only install it on Drupal 11.4+ where core no
longer provides it.

The field also slots neatly into Drupal's *Add field* UI, appearing in the
correct field-type category with its own icon, and it ships a config schema for
its field settings. There is no settings form, no permissions, and no Drush
commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Go to the entity you want to add a phone number to — a content type, user
   account, or any fieldable entity — and open **Manage fields → Add field**.
2. Choose the **Telephone** field type (it appears in the field-type list with
   its own icon), give it a label, and save.
3. On **Manage form display**, the *Telephone number* widget is used
   automatically for entry.
4. On **Manage display**, set the field's format to **Telephone link** if you
   want the number rendered as a tappable `tel:` link (you can supply link
   title text in the format settings), or leave it as plain text.

Existing telephone fields from before a Drupal 11.4 upgrade need no changes —
because the ids match core's, they continue working the moment this project is
installed.
