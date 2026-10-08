# Link Field tweaks — manual setup guide

**Link Field tweaks** (`link_field_tweak`) is a small collection of usability
improvements for Drupal's core **Link field**. It does not add a new field type; it
polishes the editing and display of the link field you already use. Among other
things it can reorder the Title and URL inputs, add custom help text to each part,
make the URL required once a title is entered, rename the "Add another item"
button, enrich autocomplete labels, and render links with fixed anchor text.

The tweaks come in three flavors: **site-wide toggles** on a settings form that
apply to every link widget, **per-widget options** you set on an individual field's
form display, and two **field formatters** for display. You can combine site-wide
defaults with per-field overrides, and export everything as configuration for
deployment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The site-wide settings form sits at **Configuration → Content authoring → Link
field settings** (`/admin/config/content/link-field-tweak`) and requires the core
**Administer site configuration** permission. The per-widget options appear on a
field's **Manage form display** widget settings, and the formatters appear on
**Manage display**.

## How to use it

### Site-wide settings

Open **Configuration → Content authoring → Link field settings**
(`/admin/config/content/link-field-tweak`). Three toggles apply to every link
widget on the site:

- **Title before URL** — shows the Title input above the URL input, the way
  Drupal 7's Link module did.
- **"Add another link" label** — relabels the multi-value widget's "Add another
  item" button to "Add another link".
- **Require URL when a title is entered** — marks the URL required in the browser
  as soon as an editor fills in the Title.

When a site-wide toggle is on, the matching per-widget checkbox is hidden (the
global setting wins).

### Per-widget options (Manage form display)

Go to a content type's **Manage form display** and click the cog on a link field
that uses the standard link widget. Beyond the per-field equivalents of the
site-wide order and required toggles, you can:

- **Custom URL help text** — replace the default "Start typing…" help under the URL
  input with your own instruction.
- **Custom Title help text** — add help text under the Title input, which core
  normally leaves blank.
- **Extend autocomplete labels** — append the entity's id and bundle to
  autocomplete matches, so results that share a title are easier to tell apart.

### Display formatters (Manage display)

Go to **Manage display** and choose one of the two formatters this module adds for
link fields:

- **Link text** — always render a fixed anchor text (for example "Read more"),
  overriding whatever title is stored on the link. The fixed text is passed through
  Drupal's XSS filter for safety.
- **Link text replacing empty text** — use the fixed text **only when** the link has
  no title of its own, keeping real titles where present.

These are ideal for consistent call-to-action links whose visible wording you want
to control centrally.

### Deployment

The site-wide settings (`link_field_tweak.settings`), the per-widget options
(stored on the form display), and the formatter settings (stored on the view
display) are all configuration, so they export and deploy across environments like
any other Drupal config.
