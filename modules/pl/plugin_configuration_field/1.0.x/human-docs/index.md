# Plugin Configuration Field — manual setup guide

**Plugin Configuration Field** (`plugin_configuration_field`) provides a custom
Drupal **field type** that lets an entity field hold a plugin selection *plus* that
plugin's per‑instance configuration. Instead of hard‑coding which plugin runs and
how it is set up, a site administrator can choose a plugin and configure it right
in the field settings — attaching configurable, plugin‑based behaviour to content
without writing custom code.

The field type was **extracted from Commerce Core** and adapted so the same
capability is available independently, without requiring Commerce. It is developed
and maintained by [Cambrico](https://cambrico.net). Because it is a field, it slots
into Drupal's normal field workflow: add it to a bundle, configure it on the field
settings, and each entity stores its own plugin choice and configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Field.

There is **no central configuration page** for this module — it has no site‑wide
settings form. Setup happens per field, described in "How to use it" below.

## Where it lives in the admin menu

Plugin Configuration Field adds no admin settings page of its own. You use it from
**Structure → Content types → *(your type)* → Manage fields**, where it appears as
a field type you can add.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage fields** and
   click **Add field**.
2. Choose the **Plugin Configuration Field** field type and give it a label.
3. In the field settings, select the plugin (and, where the plugin supports it,
   its configuration) that the field should store.
4. Save the field. Each entity of that type then holds a plugin selection together
   with its configuration, which your code can read to run the chosen plugin.
