# Pseudo Link — manual setup guide

**Pseudo Link** (`pseudo_link`) adds customizable, display‑only "pseudo" links to
specific entities and bundles. Rather than being a stored, editor‑filled link field,
a pseudo link is a computed display element that renders on an entity's display
according to your configuration — a reusable, consistent link you can add across the
site without editing templates or writing custom code.

For each entity type and bundle you enable, you can define the **link text**, apply
**CSS classes** to the link and to a **wrapper** element, and choose whether the link
**opens in a new tab**. Because the setup is configuration rather than a template
change, site builders get consistent link behaviour and styling everywhere the pseudo
link appears.

This is a content‑presentation feature that renders links from configuration; the link
is not a stored field value on each entity. It requires no additional modules — just a
theme that renders entity views normally.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable and configure pseudo links per
   entity and bundle, then place the field on the display.

## Where it lives in the admin menu

Pseudo link configurations are managed at **Configuration → Pseudo Link**
(`/admin/pseudo-link-configurations`), where you enable and configure links per entity
and bundle. The pseudo field itself is then placed on each bundle's **Manage display**.
See [Configuration](configuration/index.md).
