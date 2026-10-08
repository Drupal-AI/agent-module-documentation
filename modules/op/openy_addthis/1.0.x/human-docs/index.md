# Open Y AddThis — manual setup guide

**Open Y AddThis** (`openy_addthis`) provides a configurable block — the "Open Y
AddThis Block" — that renders social-sharing icons and links using the third-party
**AddThis** service, so visitors can share the current page to Facebook, X/Twitter,
LinkedIn, and other networks from one widget. It ships as part of the **Open Y**
(YMCA Website Services) distribution but works as a standalone contrib module: it
has no module dependencies beyond Drupal core and defines no permissions of its
own.

> **Important — AddThis has been discontinued.** The AddThis service was
> deprecated by its owner on 31 May 2023 and no longer functions. This module is
> marked **unsupported/obsolete** on drupal.org. Do not choose it for a new site.
> The maintainers recommend
> [AddToAny Share Buttons](https://www.drupal.org/project/addtoany) instead. This
> guide is provided mainly to help teams **recognise, configure, or cleanly
> retire** an existing installation.

Because the block embeds the external AddThis widget, it carries AddThis's
third-party privacy and tracking characteristics — the visitor's browser would load
a script from AddThis and share page context with it. On a privacy-sensitive or
EU-facing site that belongs in your privacy notice and behind consent, though the
point is largely moot now that the service itself is gone.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (importantly) how to uninstall it cleanly.

The module does have a small settings form (route `openy_addthis.settings`, at
`/admin/openy/settings/openy-addthis`, gated by the *administer site configuration*
permission) that stores its options in the `openy_addthis.settings` config object.
Given that the underlying AddThis service is discontinued, there is little reason
to tune it, so this guide folds setup into the sections below rather than a full
configuration walkthrough.

## Where it lives in the admin menu

- **Structure → Block layout** (`/admin/structure/block`) — place the **Open Y
  AddThis Block** in a region, optionally restricted to certain content types or
  paths using core block visibility conditions.
- **Settings form:** `/admin/openy/settings/openy-addthis` (permission: *administer
  site configuration*) — the share options and appearance.
- **Prepare-uninstall form:** `/admin/modules/uninstall/openy-addthis` (permission:
  *administer modules*) — used to remove placed block instances before uninstalling.

## How to use it (and how to retire it)

To place the widget on an existing site, add the **Open Y AddThis Block** through
Block layout and use block visibility conditions to control where it appears.

To retire it, note that the module registers an **uninstall validator** that
blocks uninstall while any share-block instances still exist. Remove those
instances first — the bundled **prepare-uninstall form** at
`/admin/modules/uninstall/openy-addthis` cleans them up — then uninstall the module
(see [Installation](installation/index.md)). When migrating off AddThis, replace it
with [AddToAny Share Buttons](https://www.drupal.org/project/addtoany).
