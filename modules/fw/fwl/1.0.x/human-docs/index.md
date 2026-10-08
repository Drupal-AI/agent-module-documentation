# Field Widget Layout — manual setup guide

**Field Widget Layout** (`fwl`) lets you lay out entity edit forms into flexible
columns. Out of the box a Drupal edit form stacks every field in a single tall
column; FWL adds a **width (%)** and an optional **maximum width (px)** setting to
each widget, so you can place related fields side by side — First name next to
Last name, a from/to date pair on one row, address parts in a tidy grid — and
turn a long, scroll‑heavy form into something compact and easy to scan.

You configure the widths per field on the entity's **Manage form display**
screen, exactly where you already set widget order and settings. FWL implements a
widget third‑party settings form to add the two inputs, applies the widths on the
real edit form with a small CSS/JS library, and shows the chosen values in each
widget's settings summary. A global settings form controls module‑wide behaviour.

Because the widths are stored as third‑party settings on the form display
configuration, they travel with your configuration export/import like any other
display setting — no per‑environment fiddling. FWL is a pure editing‑experience
enhancement: it adds no entities, no permissions of its own, and no runtime data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per‑field width settings on
   Manage form display and the global settings form.

## Where it lives in the admin menu

Two places:

- **Per field:** **Structure → Content types (or any entity bundle) →
  *(bundle)* → Manage form display**, where each widget gains Width % and
  Max‑width px settings.
- **Module‑wide:** a global settings form at **`/admin/config/fwl`**, gated by the
  **Administer site configuration** permission.
