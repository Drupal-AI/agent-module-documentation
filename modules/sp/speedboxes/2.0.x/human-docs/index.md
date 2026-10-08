# Speedboxes — manual setup guide

**Speedboxes** (`speedboxes`) lets you tick or untick a whole run of checkboxes by
dragging across them, instead of clicking each one individually. You left-click
and drag the mouse over a group of checkboxes; a small toolbar appears, and you
can **check**, **uncheck**, or **invert** the selection in one gesture.

Drupal's permissions page is a famously dense checkbox grid — on a site with many
modules it can hold thousands of checkboxes, so setting up a role means a lot of
clicking. Speedboxes targets exactly that screen. When enabled it automatically
attaches its behaviour to two forms: the core **Permissions** page
(`/admin/people/permissions`) and, if the [Group](https://www.drupal.org/project/group)
module is installed, the **group permissions** form. There is nothing to configure
and no dependencies — it works the moment you enable it.

The drag interaction only changes the checkboxes in your browser. Nothing is
saved until you submit the form with its usual **Save permissions** button, so
it is good practice to glance over the resulting role before saving — the same
as with any manual edit to the permissions grid.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. Once enabled, go to **People → Permissions**
(`/admin/people/permissions`), left-click and drag across the boxes you want to
change, and use the small toolbar that appears to check, uncheck or invert them.
Then save the form as usual to apply the change.
