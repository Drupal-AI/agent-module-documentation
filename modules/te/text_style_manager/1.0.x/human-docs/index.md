# Text Style Manager — manual setup guide

**Text Style Manager** (`text_style_manager`) lets you customise the text styling
of different sections of your site — the header, the footer and the main body —
from the Drupal admin, and injects the resulting CSS for you. The idea is that a
site builder can adjust typography (fonts, sizes, colours, weights) per region
without opening the theme's stylesheets or writing CSS by hand.

You configure the styles on a settings page, and the module generates and applies
the corresponding CSS to the matching sections of the site. It depends on core's
**Block** module and provides its own permission for managing the styles. It runs
on Drupal 10 and 11. Note that the project is currently listed as seeking a new
maintainer and is in maintenance-fixes-only status.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the text styles for the header,
   footer and body sections.

## Where it lives in the admin menu

The settings live at **Configuration → User interface → Text Style Settings**
(`/admin/config/user-interface/text-style-settings`). That is where you choose
the typography for each site section.
