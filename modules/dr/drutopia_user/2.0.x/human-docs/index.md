# Drutopia User — manual setup guide

**Drutopia User** (`drutopia_user`) is a small, configuration‑only "base
feature" from the [Drutopia](https://www.drupal.org/project/drutopia)
distribution. It ships a consistent, ready‑made presentation for user accounts:
a default *view* display for the public profile, a default *form* display for the
registration/edit form, and an extra **compact** view mode handy for teasers and
listings. Enable it and your user entity picks up that standard layout.

The module contains **no PHP logic** — no routes, services, permissions, blocks,
or controllers. It is purely exported display configuration in `config/install`,
layered onto Drupal's stock user entity. Because of that it exposes nothing to
anonymous visitors on its own; it simply gives new Drutopia sites a uniform
account experience out of the box. It depends only on core modules: **Field**,
**File**, **Image**, **Path**, and **User**.

There is nothing you *must* configure. Once enabled, any further tuning happens
through the ordinary **Manage display** and **Manage form display** screens for
the user entity — reorder fields, show or hide an avatar, or switch on the
compact view mode where a terse profile is wanted. It is typically installed
alongside other Drutopia features (for example `drutopia_core`,
`drutopia_people`, `drutopia_site`, `drutopia_social`) as part of a base install.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the feature with Composer and
   enable it.

There is **no configuration page** for this module. Setup is limited to enabling
it; adjustments are made through the standard user‑entity display screens
described below.

## How to use it

After enabling, review the presentation it applied:

- **Structure → Account settings → Manage display**
  (`/admin/config/people/accounts/display`) — the fields shown on the public
  profile, plus the **compact** view mode for terse contexts.
- **Structure → Account settings → Manage form display**
  (`/admin/config/people/accounts/form-display`) — the field order on the
  registration/edit form.

Any changes you make here become site‑specific overrides. If you ever want to
reset to the shipped layout, reinstall the module.
