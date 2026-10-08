# Responsive Preview — manual setup guide

**Responsive Preview** (`responsive_preview`) adds a toolbar control that reloads
the current page inside a resizable iframe sized to a common device — phone,
tablet, or desktop — so you can check how a page's layout behaves at different
screen widths without resizing your browser or leaving the site.

Click the toolbar tab, pick a device, and the page reappears scaled to that
device's width, height, pixel density (dppx), and orientation, with the admin
chrome (toolbar, navigation, contextual links) stripped away for a clean,
distraction‑free view. It works on ordinary pages and on node add/edit forms —
for an unsaved draft it hooks into the node form's **Preview** button over AJAX,
so you can check work in progress before publishing.

Devices are simple config entities. Four ship by default (Phone, Tablet
Portrait, Tablet Landscape, Desktop) and you can edit them, disable the ones you
never use, reorder them, or add your own presets matching real device
dimensions. The module also provides a "Responsive preview controls" block for
placing the control outside the toolbar, and an optional submodule that surfaces
the icons in Drupal's newer core Navigation top bar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permissions.
2. [Configuration](configuration/index.md) — manage the device list and add your
   own device presets, plus the two permissions.

## Where it lives in the admin menu

The device list is at **Configuration → User interface → Responsive preview**
(`/admin/config/user-interface/responsive-preview`). The preview control itself
appears as a tab in the admin **Toolbar** once you have the right permission.

## How to use it

With the *access responsive preview* permission, look for the Responsive Preview
tab in the toolbar (or place the "Responsive preview controls" block in a
region). Click it, choose a device, and the current page reloads inside a scaled
iframe. Switch devices to compare widths, or preview a draft node straight from
its edit form's Preview action.
