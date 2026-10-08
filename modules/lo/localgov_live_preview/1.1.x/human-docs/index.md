# LocalGov Live Preview — manual setup guide

**LocalGov Live Preview** (`localgov_live_preview`) lets editors preview **microsite
design changes live** — opening a microsite's design form in an off-canvas settings
tray that slides out from the right, and reflecting each change on the page
immediately, before anything is saved. No one else sees the changes until the editor
presses save.

The base module by itself does very little: it only ships the shared theming for the
off-canvas tray, acting as a home for functionality that its submodules build on. The
actual feature lives in the **LocalGov Live Preview Microsites** submodule
(`localgov_live_preview_microsites`), which depends on the LocalGov Microsites group
platform and the microsites colour-picker fields. With it enabled, an **Edit Microsite
Design** tab appears on node pages (for authenticated users); clicking it opens the
microsite group's design form in the tray, where colour-picker and other design
changes preview live.

This is an experimental (beta) editing convenience, part of the **LocalGov Drupal**
distribution's microsites platform. It only makes sense on a LocalGov Microsites site
with the group stack installed. On the security side it does not widen access — the
live-preview route is a clone of the group edit form's route and inherits exactly that
form's access requirements (group update access), so only users who could already edit
the microsite can preview it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   the microsites submodule and its dependencies, and grant the permission.

There is **no settings form** for this module — its only configurable element is a
permission (*Use live preview*), described under "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page of its own (`configure` is `null`). You
control access through the *Use live preview* permission on **People → Permissions**
(`/admin/people/permissions`), and the feature itself appears as an **Edit Microsite
Design** local task (tab) on node pages — not in the admin menu.

## How to use it

1. On a LocalGov Microsites site, install and enable the base module, the
   **LocalGov Live Preview Microsites** submodule, and its dependencies (see
   [Installation](installation/index.md)).
2. On **People → Permissions**, grant the **Use live preview** permission to the roles
   that should be able to use it. Only users with this permission see the feature.
3. As a permitted user, view a microsite node and click the **Edit Microsite Design**
   tab. The group's design form opens in an off-canvas tray on the right.
4. Make design changes — for example with the colour picker — and watch them preview
   live on the page. Nothing is visible to other users until you click save.
