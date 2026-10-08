# Configuration

Attribution's main configuration is the **license list** — the set of licenses
editors can choose from in Attribution fields and blocks. (Configuring the field
type, widgets, formatters, and blocks themselves is covered in the
[overview](../index.md#how-to-use-it).)

## Open the license list

1. Log in as a user with the **Administer attribution licenses**
   (`administer attribution_license`) permission.
2. Go to **Structure → Attribution Licenses**, or navigate directly to
   `/admin/structure/attribution-license`.

You'll see the licenses currently defined on the site. Nine install by default:
All Rights Reserved, CC0 1.0, and the CC‑BY 4.0 family (BY, BY‑NC, BY‑NC‑ND,
BY‑NC‑SA, BY‑ND, BY‑SA), plus GPL‑2.0‑or‑later.

## What a license record holds

Each license is a configuration entity with these fields:

- **Name** — the human‑readable label shown to editors (for example "Creative
  Commons Attribution 4.0 International").
- **SPDX identifier** — the standard identifier, e.g. `CC-BY-4.0`.
- **Link** — a URL to the license text.
- **OSI‑certified** — whether the license is OSI‑approved.
- **Deprecated** — whether SPDX marks the license as deprecated.

The machine id is derived from the identifier and is used as the config key, so
licenses export and import between environments like any other configuration.

## Add licenses

The collection page offers two ways to add licenses:

- **Import from SPDX** — opens a form listing all 400+ licenses from the bundled
  `composer/spdx-licenses` package. Tick the ones you want and save; each becomes a
  license record. Re‑importing a license you already have simply reports "already
  exists" rather than creating a duplicate.
- **Add a custom license** — a blank form where you enter the name, SPDX
  identifier, link, and the OSI/deprecated flags by hand, for a license not in the
  SPDX list.

You can **edit** or **delete** any license from its row on the collection page.

## Restricting licenses per field

You don't have to offer every license everywhere. When you add or edit an
**Attribution** field on a bundle, the field settings include a **licenses**
multi‑select: choose a subset and that field's widget will only offer those
licenses to editors. Leave it empty to offer all licenses. This lets you curate a
short, controlled list per content type (for example, only Creative Commons
licenses on a photo field).
