# LocalGov KeyNav — manual setup guide

**LocalGov KeyNav** (`localgov_keynav`) lets people navigate a LocalGov Drupal site
with **keyboard shortcuts**: type a defined key sequence and you jump straight to a
common page, rather than hunting for it with the mouse. For editors and other power
users who move around the same set of admin and content pages all day, it can save a
lot of clicks.

The shortcuts are attached only to users who have permission to use them, and each of
those users can switch the feature off for themselves with a checkbox on their profile
— so it never gets in the way of anyone who does not want it. A set of default key
sequences ships with the module, and an administrator can add custom sequences on the
settings form. All navigation happens in the browser (client-side JavaScript); the
module makes no external calls.

This module is part of the **LocalGov Drupal** distribution, though it is not tied to
any council-specific content and works on any Drupal 10 or 11 site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — grant the permissions, add custom key
   sequences, and understand the per-user opt-out.

## Where it lives in the admin menu

Once enabled, KeyNav's settings form sits at **Configuration → User interface →
LocalGov KeyNav** (`/admin/config/user-interface/localgov-keynav`). Reaching it
requires the *Add LocalGov Keynav shortcuts* permission. Which users actually receive
the shortcuts is controlled separately, through the *Use LocalGov keynav* permission
on the **People → Permissions** page, and each user's own opt-out lives on their
profile edit form.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. On **People → Permissions**, grant *Use LocalGov keynav* to the roles that should
   receive shortcuts (see [Configuration](configuration/index.md)).
3. A user with that permission can then type one of the defined key sequences on any
   page to jump to the associated destination.
4. Any such user who prefers not to use shortcuts can tick the opt-out checkbox on
   their profile to disable KeyNav for themselves.
5. Administrators can add custom key-sequence patterns on the settings form.
