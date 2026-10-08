# Progressive Accessibility Widget — manual setup guide

**Progressive Accessibility Widget** (`progressive_accessibility_widget`) adds a
front-end **accessibility toolbar** to your site as a placeable Drupal block.
Visitors open it to adjust the page to their needs: change the font size, switch
on a dyslexia-friendly font, adjust letter spacing and line height, highlight
titles and links, turn on high-contrast or monochrome colour modes, and use
reading aids such as a reading guide ruler and an enlarged cursor.

Its headline feature is privacy: the toolbar is based on a maintained,
auditable fork of the Sienna accessibility widget, and **all assets are served
locally with no requests to third-party services**, which is what makes it
GDPR/DSGVO-friendly. It helps site owners work toward the European Accessibility
Act (EAA), the German BFSG, and WCAG 2.1. All the adjustments happen client-side
in the visitor's own browser.

The module itself is deliberately thin — it provides one block plugin and loads
the widget's JavaScript and CSS. One important consequence: the widget's
JavaScript library is **not bundled** with the module and must be installed
separately (see the installation guide). Until it is present, Drupal's status
report will flag it as missing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module *and* its external
   widget library, then enable it.

There is no central settings form. The block has a single optional setting (a
custom launcher icon), covered under "How to use it" below.

## Where it lives in the admin menu

Progressive Accessibility Widget adds no configuration page. You place and
configure it entirely from **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Make sure the external widget library is installed — see
   [Installation](installation/index.md). You can confirm it at **Reports →
   Status report**, which flags the widget's JavaScript file if it is missing.
2. Go to **Structure → Block layout**, choose a region, and click **Place block**.
3. Select **Progressive Accessibility Block** and place it. Because it is a normal
   block, you can use Drupal's visibility rules to show it only on certain pages
   or to certain roles.
4. *(Optional)* Set a custom launcher icon in the block's configuration. The
   **Widget icon** field accepts a Drupal-root-relative path, a public-files
   path, or a `public://` stream-wrapper URI; absolute local filesystem paths are
   rejected. Leave it empty to use the module's built-in default icon.
5. Save the block layout. The accessibility toolbar now appears on the pages you
   targeted, and visitors can open it to adjust the display.
