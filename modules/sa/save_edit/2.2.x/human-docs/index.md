# Save & Edit — manual setup guide

**Save & Edit** (`save_edit`) adds an extra **"Save & Edit"** button to node add and
edit forms. Unlike the standard Save button — which sends the author off to the
published page or a redirect — Save & Edit saves the node and drops the editor right
back on the same edit form. That makes it much smoother to work through a long piece
of content in several passes, saving as you go without losing your place.

The button is opt‑in per content type, so you can enable it on the types where it
helps (say, Articles) and leave it off elsewhere. You can rename it (many teams call
it "Apply"), position it among the form's action buttons, and — if you use the Gin
admin theme — promote it to a primary action instead of tucking it into the "More
actions" menu.

Beyond the button itself, Save & Edit can support a draft‑first workflow by
**auto‑unpublishing** nodes when they are saved this way — either every time or only
on first creation. It can also tidy up the node form's action bar by hiding or
relabeling the core **Save**, **Preview**, and **Delete** buttons, so editors see only
the actions you want them to use.

Two permissions control it: one for who gets the button, and one for who can change
its settings. This guide is written for a **human** clicking through the admin UI. If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the permissions.
2. [Configuration](configuration/index.md) — enable it per content type, set the
   button text and position, auto‑unpublish options, and the default‑button toggles.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Save & Edit → Settings**
(`/admin/config/save_edit/settings`). The two permissions are at **People →
Permissions**.

## How to use it

1. Enable the module and grant the **Use save and edit** permission to authoring
   roles.
2. On the settings form, tick the content types that should get the button.
3. Edit a node of one of those types — you will see the **Save & Edit** button in the
   form actions. Click it to save and stay on the edit form.

See [Configuration](configuration/index.md) for all the options.

> **Drupal version:** this is the **2.2.x** branch, for Drupal 10 and 11. On Drupal
> 11.2 or Drupal 12, use the project's 3.x branch instead.
