# External Data Source — manual setup guide

**External Data Source** (`external_data_source`) provides a Drupal field type
whose allowed values come from an **external web service** instead of a
hard-coded list. Editors pick from live remote options — countries, French
regions, French zip codes, or anything you wire up — rendered as an
autocomplete, a select dropdown, or checkboxes/radios. When the remote data
changes, your field's options change with it, with no config edits in Drupal.

The remote data is supplied by pluggable **data sources**. Three ship with the
module: `countries`, `franceregions`, and `francezipcodes`, each of which calls a
fixed third-party API. The endpoints those built-in plugins call are
**hardcoded** — they cannot be pointed at an arbitrary host from the admin UI —
so to integrate a different service you write a small data-source plugin (see the
agent docs). Each field stores a single text value; three widgets let you choose
how editors pick it, and a formatter prints the stored value on the rendered
entity.

There is no global settings page. Everything is configured on the field itself —
you choose the data source and limits in the field's storage settings, and the
widget/formatter in the form and display settings. This guide covers that
field-level setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to write
your own data-source plugin — read the sibling [`agent/`](../agent/start.md)
docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — adding the field, choosing a data
   source, and picking a widget and formatter.

## Where it lives in the admin menu

There is no dedicated settings page. You add and configure an **External Data
Source Field** through the Field UI on any fieldable entity — for a content type,
under **Structure → Content types → (edit) → Manage fields**.
