# Layout Builder Restrictions — manual setup guide

**Layout Builder Restrictions** (`layout_builder_restrictions`) lets you control
what content editors are allowed to do inside Drupal's **Layout Builder** — which
**blocks** they may place, which **layouts** they may choose, and which
**inline-block types** they may create. Core Layout Builder exposes *every*
installed block and layout to anyone editing a layout, which overwhelms editors
and lets them drop in things that break your design. This module adds a governance
layer on top so you can keep landing-page building on-brand, consistent, and safe.

Restrictions are configured **per entity view mode** (for example the *Full
content* or *Teaser* display of a content type) and are saved as part of that
display's configuration, so they export and deploy between environments like any
other config. A small global admin page lets you enable, disable, and order the
available **restriction plugins**.

This guide is written for a **human** clicking through the admin UI. It walks you
from installing the module to setting global defaults and locking down the blocks
and layouts for a specific view mode. If you are looking for terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

![The Layout Builder Restrictions Configuration page listing the available restriction plugins](images/settings.png)

## Where it lives in the admin menu

The global settings sit under **Configuration → Content authoring → Layout Builder
Restrictions** (`/admin/config/content/layout-builder-restrictions`).

The actual block and layout restrictions live somewhere else: on **each content
type's *Manage display* screen**, inside the Layout Builder settings for a view
mode that has Layout Builder enabled. The [Configuration](configuration/index.md)
page walks through both places.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Layout Builder.
2. [Configuration](configuration/index.md) — set the global restriction-plugin
   defaults, then whitelist the blocks and layouts allowed for a view mode.
