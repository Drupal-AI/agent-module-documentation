# Extra Paragraph Types (EPT): Core — manual setup guide

**Extra Paragraph Types (EPT): Core** (`ept_core`) is the shared foundation for the
EPT family of Paragraph modules. It is a **toolkit**, not a ready-to-use paragraph
type on its own — you won't see a new "block" to place after installing it.
Instead, it provides the pieces every `ept_*` paragraph module builds on: a reusable
**EPT Settings** design-options field, a few shared paragraph fields, and the
machinery that turns those design options into real styling on the page.

The heart of it is the **EPT Settings** field. When an EPT paragraph type includes
this field, editors get per-paragraph design controls without touching code:
margins, borders and padding (arranged as nested "boxes"), border color, style and
radius, a background color or background media/image, an edge-to-edge full-width
toggle, and a container width. At render time, EPT Core's CSS and JS generators
convert each paragraph's choices into scoped styling — including effects like
parallax and video backgrounds, using the JavaScript libraries it bundles.

EPT Core also ships site-wide **global settings** — your brand colors, responsive
breakpoints (mobile/tablet/desktop), and a set of named container widths — that all
EPT paragraphs share, so layouts stay consistent across the site. And it provides
three shared field storages (`field_ept_settings`, `field_ept_text`,
`field_ept_title`) that individual EPT modules reuse, which keeps each of those
modules small.

Because it's a base layer, you normally install EPT Core alongside one or more
`ept_*` paragraph modules (or scaffold your own with its **Starterkit** submodule).
On its own, its job is to be the dependency everything else stands on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its many
   dependencies with Composer and enable it.

## Where it lives in the admin menu

Its global settings form is at **Configuration → Content authoring → EPT Core**
(`/admin/config/content/ept-core`), gated by the core **Administer site
configuration** permission (the module defines none of its own). The per-paragraph
design options appear on the paragraph editing form of any EPT paragraph type that
includes the EPT Settings field.

## How to use it

EPT Core is a base module, so "using" it means one of two things:

**1. Install EPT paragraph types on top of it.** Add one or more `ept_*` modules
(for example an accordion, slider, or call-to-action paragraph). Each one depends on
EPT Core, creates its own paragraph type, and includes the EPT Settings field so
editors get the design controls automatically. This is the common path for site
builders.

**2. Add EPT design options to your own paragraph type.** If you already have a
custom paragraph type, you can attach EPT Core's shared **EPT Settings** field
(`field_ept_settings`) to it and set its widget to the EPT Settings widget on the
paragraph's *Manage form display*. There are two widgets to choose from — a **full**
one with the complete boxes/colors/background UI, and a **simple** one for lighter
paragraph types.

### Setting the global defaults

Go to **Configuration → Content authoring → EPT Core**
(`/admin/config/content/ept-core`) to set the site-wide defaults that EPT paragraphs
share:

- **Brand colors** — primary and secondary colors plus their button-text colors, and
  a default background color. These are entered as HEX values (validated on save).
- **Responsive breakpoints** — the pixel widths for **mobile** (default 640),
  **tablet** (1020), and **desktop** (1320) that EPT's generated CSS uses to switch
  layouts.
- **Named container widths** — a ladder of widths from xxSmall through xxLarge
  (for example 480, 640, 768, 960, 1100, 1320, 1600 px) that editors pick from when
  choosing a paragraph's container width.

Click **Save configuration**. These values feed the CSS generator, so changing them
updates the look of every EPT paragraph that relies on the defaults. Because they're
configuration, you can export them and deploy them across environments.

### The Starterkit submodule

For developers who want to build a brand-new EPT paragraph module, the bundled
**EPT Core Starterkit** (`ept_core_starterkit`) submodule adds a Drush generator that
scaffolds one for you. That developer workflow is described in the
[`agent/`](../agent/start.md) docs.
