# Configuration

Selectify has both a global settings form and per-surface controls. The settings
form sets site-wide defaults and styling; the four integration types below are how
you actually apply the enhanced widgets where you want them. Each integration works
independently, so you can enhance as much or as little of the site as you like.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → Selectify** (config route `selectify.settings_form`).

## Global options on the settings form

The settings form is where the site-wide look and behaviour are set, including:

- **Color themes** — seven professional accent colors, with independent control
  for the admin and front-end interfaces.
- **Light and dark modes** — color themes optimized for each, with automatic theme
  detection.
- **Radio and checkbox styling** — turn plain radios and checkboxes into toggle
  switches or styled traditional controls, with circle or square shapes and three
  size variants. This styling applies globally across the site.
- **Path-based disabling** — for both selects and radios/checkboxes, you can switch
  Selectify off on a specific page or set of pages using path patterns, so you can
  exempt areas where you want the native control.

## The four places you turn Selectify on

### 1. Field widgets

On an entity's **Manage form display**, choose a Selectify widget for a
`list_string`, `list_integer`, `list_float`, or `entity_reference` field. Five
widgets are available — regular dropdown, taggable dropdown, searchable dropdown,
checkbox dropdown, and dual-list selector — with control over selection limits and
behaviour per field.

### 2. Views exposed filters

Selectify can enhance exposed select filters in Views, with three modes:

- **Disable completely** — turn Selectify off for all Views filters.
- **Apply site-wide** — one global widget for every exposed select filter.
- **Per-view configuration** — a granular accordion interface listing every
  display that has exposed filters, so you can set widgets display by display.

### 3. Form API select elements

Selectify can enhance plain Form API select elements with per-form configuration.
Forms with eligible select elements are **discovered automatically** as their pages
are visited, then listed in a table (by Form ID and when they were last seen) where
you pick a widget per form.

### 4. Webform elements

With the **Selectify for Webform** submodule enabled, Webform submission forms can
use the Selectify widgets on their select elements — enhanced the same way as the
rest of the site.

## For themers and developers

Themers can customize the components via CSS variables and theme classes;
developers can adjust behaviour per form or element through Selectify's alter hooks
and JavaScript API. Those are documented for an agent audience in the sibling
[`agent/`](../agent/start.md) docs.

## Save

Click **Save configuration** on the settings form to store the global options.
Per-field, per-view, per-form, and Webform choices are saved on their respective
screens.
