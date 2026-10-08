# Extra Field Configuration — manual setup guide

**Extra Field Configuration** (`extra_field_configuration`) adds a configuration
layer on top of the [Extra Field](https://www.drupal.org/project/extra_field)
module. Extra Field lets developers create "pseudo-fields" — fields that render
computed or plugin-generated output on an entity display without being real stored
fields. On its own, Extra Field expects the placement of those pseudo-fields to be
declared in the plugin's code (its annotation). This module lets site builders
place and manage them **through configuration instead**, from an admin screen.

It also unlocks something the plain Extra Field module can't do easily: using the
**same extra-field plugin more than once** on an entity, as multiple named
instances, without having to define a separate plugin in code for each. You create
each instance from a plugin, give it a machine name, and manage which entity
displays it attaches to — all from the UI.

This is a site-builder / developer tool for controlling *content display*. Extra
fields render plugin output into the display; the module has no access-control
role and stores no user content of its own. It depends on core's **Field** module
and the contrib **Extra Field** module, and it ships an optional examples
submodule with sample plugins to learn from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the examples submodule.

This module has no separate settings form — its work happens on the **Manage extra
fields** admin screen described under "How to use it" below, so there is no
dedicated Configuration page.

## Where it lives in the admin menu

You manage extra-field instances at **Structure → Extra fields**
(`/admin/structure/extra-field`). That's where you create instances from Extra
Field plugins and control their entity assignments.

## How to use it

1. Install and enable this module (and Extra Field), plus optionally the examples
   submodule so you have some plugins to try (see
   [Installation](installation/index.md)).
2. Go to **Structure → Extra fields** (`/admin/structure/extra-field`).
3. **Create an extra-field instance** from an available Extra Field plugin, giving
   it a machine name. You can create several instances from the same plugin if you
   need the field more than once.
4. Assign the instance to the entity type(s)/displays where it should appear.
5. The instance then shows up like any other field on the relevant **Manage
   display** screens, and its generated machine name is what you use to print it in
   a template.

> **For developers:** to make an Extra Field plugin configurable this way, its
> annotation needs the `deriver` property pointing at Extra Field Configuration's
> deriver, and it's recommended to omit the `bundles` property so the field isn't
> managed in two different ways at once. The plugin class itself and its file
> location stay exactly as they were, and Extra Field Plus plugins work too.
