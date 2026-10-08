# Form Mode Control — manual setup guide

**Form Mode Control** (`form_mode_control`) lets you decide which entity **form
mode** — which version of the create or edit form — a given role gets for a given
bundle, and lets permitted users switch form modes on the fly by adding a
`?display=<form_mode>` query parameter to the add/edit URL.

Drupal core already lets you build alternate form modes for a bundle (extra
"Manage form display" tabs — for example a slimmed‑down "compact" node form next to
the full one), but core gives you no way to say *which role actually gets which
one*. Form Mode Control fills that gap. On one admin form you set a default form
mode per entity type, bundle, operation (Create vs Edit), and role; at form‑build
time the module swaps in the matching form display. When a user has several roles,
the role with the **highest weight** wins.

The module also generates a **permission for each activated form mode**, plus a
master **Use all form modes** permission. The interactive `?display=` switch is
only honoured when the user holds the matching permission (or the master one) — so
you control who can reach an alternate form by URL. The stored per‑role *defaults*,
on the other hand, always apply regardless of these permissions.

It builds entirely on core's Field UI form modes and form displays — it defines no
field type, widget, or entity of its own. It depends on core's **Field** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set per‑role defaults, use the
   `?display=` switch, and grant the form‑mode permissions.

## Where it lives in the admin menu

The module's configuration form sits at **Structure → Display modes → Form modes →
Configure form modes** (`/admin/structure/display-modes/form/config-form-modes`).
Its per‑form‑mode permissions appear on the standard **People → Permissions** page
(`/admin/people/permissions`) under a *Form Mode Control* section. It adds no Drush
commands.

## How to use it

At a high level, three pieces work together:

1. **Build the form modes in core first.** Create a form mode
   (`/admin/structure/display-modes/form/add`) and activate it on a bundle's
   **Manage form display** page. Form Mode Control only sees form displays that are
   *enabled* for a bundle.
2. **Set the defaults.** On the configuration form, choose, for each bundle and
   role, which form mode is used for Create and for Edit.
3. **Optionally allow URL switching.** Grant the relevant per‑form‑mode permission
   (or *Use all form modes*) to a role, then link users to
   `/node/add/article?display=compact` (or an edit URL) to open a specific form
   mode on demand.

Full step‑by‑step details are in [Configuration](configuration/index.md).
