# Alerts Kit — manual setup guide

**Alerts Kit** (`alerts`) ships ready-made configuration for authoring and
displaying dismissible alert banners. Instead of a settings form, it installs the
building blocks for you: an **alert** content type, an **alert_severity**
taxonomy for severity levels (each with a color), and an **alerts** view that
lists published alerts newest-first. You then create alerts as ordinary nodes.

On install it also seeds three severity terms — **Emergency** (red), **Warning**
(orange) and **Notice** (green) — and colors banners per severity: at render time
the module injects a small `<style>` block built from each severity term's color
field, so a banner takes its background color from its severity. Those colors
come from admin-managed color fields (validated as hex), not from visitor input.

An optional submodule, **`alerts_olivero`**, adds banner styling for the Olivero
theme plus the JavaScript that records dismissed banners in the browser's
`localStorage`, so a dismissed banner stays hidden across pages and visits. There
are no custom routes, permissions or services — access is governed by the normal
node and taxonomy permissions.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (including its contrib dependencies) and enable it, plus the optional Olivero
   submodule.

## How to use it

Enabling the module imports all the configuration in one step. From there:

- **Create an alert** by adding an **alert** node with a title, body, and a
  severity. The `add_content_by_bundle` dependency gives you a bundle-scoped
  "add" link for alerts.
- **Choose severity** — Emergency, Warning or Notice — or add your own by
  creating new **alert_severity** taxonomy terms. Each term's color field sets
  that severity's banner background, kept consistent site-wide.
- **Display alerts** through the provided **alerts** view. Place the view's block
  near the top of the site so banners appear there; alerts sort newest-first out
  of the box.
- **Let visitors dismiss banners** by enabling the **`alerts_olivero`** submodule
  (on Olivero), which adds the styling and the localStorage dismissal so a
  dismissed banner stays hidden.
- **Extend or restyle** as needed: add fields to the alert bundle, reorder
  severities by term weight, or mirror the Olivero submodule's CSS in a custom
  theme. Editors need the standard node permissions for the alert bundle to
  author alerts.
