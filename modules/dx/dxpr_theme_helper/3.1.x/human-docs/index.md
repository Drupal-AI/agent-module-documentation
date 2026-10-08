# DXPR Theme Helper — manual setup guide

**DXPR Theme Helper** (`dxpr_theme_helper`) is a companion module for **DXPR Theme**.
It bundles several loosely related helpers that make DXPR Theme easier to build with:
a full-screen search block, a user-registration block, a set of per-node page-layout
fields, a suite of `dxt:*` Drush commands for reading and writing DXPR Theme
settings, and AI-powered color-palette and font generators.

The two **blocks** cover common front-end needs: a toggleable full-screen search
overlay (backed by either Core Search or Search API) and a user-registration form
block that shows only to anonymous visitors when registration is open. The five
optional **node fields** let editors override the layout of a single page —
switching it between full-width and boxed, narrowing the main content column, hiding
specific theme regions, or setting a custom body/page-title background image.

The headline feature is the **`dxt:*` Drush command suite**. It lets you read, set,
list, export, import, and reset DXPR Theme's settings from the command line (with
schema validation and automatic CSS rebuilds), manage the color palette, set a
node's layout fields, scaffold a subtheme, and install AI-assistant skill files. The
**AI generators** (`dxt:generate:palette` and `dxt:generate:fonts`) turn a
natural-language prompt like "Modern tech startup" into a validated color palette or
font pairing — these require the optional `drupal/ai` module configured with a chat
provider.

The module has no admin settings page of its own — its routes reuse core's
*administer themes* permission, and the DXPR Theme settings it drives live on the
theme, not here. Configuration is done through the blocks, the node fields, and the
Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional `drupal/ai` requirement for the AI generators.
2. [Configuration](configuration/index.md) — the two blocks, the per-node
   page-layout fields, the `dxt:*` Drush command suite, and the AI generators.

## Where it lives in the admin menu

DXPR Theme Helper has no dedicated settings page. You reach its pieces through the
usual admin areas:

- **Blocks** — place them from **Structure → Block layout**
  (`/admin/structure/block`).
- **Per-node fields** — attach them to a content type under **Manage fields**, then
  set them when editing a node.
- **Drush commands** — run from the command line (`drush dxt:*`).
- **AI generators** — invoked via Drush or from the DXPR Theme settings UI.

## How to use it

- Place the **DXPR Theme Full Screen Search** block and point it at Core Search or a
  Search API view.
- Place the **User registration form** block in a region for anonymous visitors.
- Attach the `field_dth_*` page-layout fields to the content types where editors
  should control per-page layout.
- Use `drush dxt:config:*` to read and change DXPR Theme settings as code, ideal for
  CI and deployment.
- Generate a palette or font pairing from a prompt with `drush dxt:generate:palette`
  / `dxt:generate:fonts` once `drupal/ai` is configured.

See [Configuration](configuration/index.md) for the details of each.
