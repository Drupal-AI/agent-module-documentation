# Disable Author — manual setup guide

**Disable Author** (`disable_author`) hides the **Authoring information** fieldset
on node add and edit forms for users in the roles you choose. That's the fieldset
where the author (the "Authored by" username) and the authored-on date are set —
Drupal shows it to anyone with permission to edit a node, and for many editor roles
it is just clutter they should never touch. This module removes it from the form for
those roles, leaving a cleaner editing screen.

You pick which roles lose the fieldset on the module's settings page. Whenever the
person editing a node has one of the selected roles, the Authoring information
section simply isn't rendered for them; everyone else sees it as usual. The module
touches nothing else on the form, and uninstalling it restores the default node
form.

One important limitation to be clear about: **this is a UI convenience, not an
access control.** It hides the widget, but it does not stop authorship from being
changed through other channels such as REST, JSON:API, other forms, or programmatic
edits. If you need to genuinely forbid a role from reassigning authorship, pair this
with proper Drupal permissions — don't rely on the hidden field alone.

It requires nothing but Drupal core and runs on Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choose which roles should not see the
   author fieldset.

## Where it lives in the admin menu

The settings form is at **Configuration → Disable Author → Settings**
(`/admin/config/disable_author/settings`) and requires the **Administer site
configuration** permission.
