# Configuration

Most of what makes Analyze useful comes from the **submodules** (and any custom
plugins) you enable — each one contributes information to the Analyze tab. The
base module provides a settings form for the tab itself.

## Open the settings form

1. Log in as a user with permission to administer the module.
2. Go to the Analyze settings form (route `analyze.analyze_settings`) in the
   admin configuration area.

## What it does

The settings form controls the Analyze tab and how its plugins are presented. In
practice your setup work is:

1. **Enable the plugins you want** by turning on the relevant submodules (see
   [Installation](../installation/index.md)) — for example page views, basic
   content info, or Google Analytics.
2. **Grant access.** The Analyze tab is meant for editors and administrators;
   give the appropriate roles the module's permission so the right people see it.
3. **View the tab.** Open an entity that supports it (such as an article) and
   look at its **Analyze** tab to see the information the enabled plugins provide.

## Notes for plugin authors

If you build your own Analyze plugin, remember the design intentions of the
module: the tab is for **information, not controls**, and a plugin that fetches
external data (analytics, for instance) does so on an admin page load — so build
in **caching and a failure path** rather than assuming the data is always
available. The `analyze_plugin_example` submodule documents the API.
