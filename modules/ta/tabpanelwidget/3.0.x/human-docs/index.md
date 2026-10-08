# Tab Panel Widget — manual setup guide

**Tab Panel Widget** (`tabpanelwidget`) makes the **TabPanelWidget JavaScript
library** available in Drupal for building tabs and accordions. It grew out of a
government organization's need for tabs that are *responsive* — they collapse
gracefully into accordions at narrower screen widths — while also meeting
**accessibility** requirements. If you need tabbed content that is keyboard- and
screen-reader-friendly, that accessibility focus is the main reason to reach for
this over hand-rolled tab markup.

The base module makes the library available and provides a PHP class for setting
options, generating the markup, and attaching the library. Two optional submodules
plug it into other systems:

- **TabPanelWidget Quick Tabs** (`tabpanelwidget_quicktabs`) — provides a
  *TabRenderer* plugin so Quick Tabs can render using this library.
- **TabPanelWidget Views** (`tabpanelwidget_views`) — provides a Views *style
  plugin*, letting you display a View as tab panels.

Because accessible tabs are the whole point of choosing a library like this, it is
worth confirming the ARIA roles and keyboard behaviour meet your specific
requirements once it is in place.

One important compatibility note: this release supports **version 1.x of the
TabPanelWidget library only** (the maintainer hopes to add 3.x support in a future
release), so install the 1.x library as described in the installation guide.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, add
   the TabPanelWidget 1.x library, and enable the base module and the submodules
   you need.

## How to use it

- **From code / a theme:** use the class the base module provides to set options,
  generate the tab or accordion markup, and attach the library.
- **With Views:** enable **TabPanelWidget Views** and pick the TabPanelWidget style
  on your View's display.
- **With Quick Tabs:** enable **TabPanelWidget Quick Tabs** and choose its
  renderer for your Quick Tabs instance.
