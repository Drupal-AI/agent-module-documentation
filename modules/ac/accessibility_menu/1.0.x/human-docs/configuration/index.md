# Configuration

There are two parts to setting up the widget: choose what it offers on the settings
form, and place it on the page as a block.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Accessibility menu**, or navigate directly
   to `/admin/config/development/accessibility-menu`.

The form lets you choose **which accommodations the widget offers** — the visual
controls presented to visitors, such as text resizing, contrast adjustment,
grayscale or inverted display, and a reset to defaults. Enable the ones you want to
present and save; the widget shows only the controls you have turned on.

The widget's labels are translatable: because the module declares an interface
translation project, its interface strings can be translated through drupal.org's
localisation server (with core's Interface Translation module installed).

## Place the widget

The toolbar appears where you place its block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want (the widget is designed to float,
   so any always-present region works).
3. Find and place the **Accessibility menu** block.
4. Configure the standard block settings (visibility conditions, etc.) and save.

Separate desktop and mobile styling ships with the module, so the widget adapts to
smaller screens on its own.

## A note on scope

This widget helps visitors who want larger text or more contrast and do not know
their browser settings. It does **not** deliver WCAG conformance on its own —
semantic markup, keyboard operability, focus management and the design's own
contrast are what is measured, and no overlay retrofits them. Position it as a
visitor convenience alongside genuine remediation.
