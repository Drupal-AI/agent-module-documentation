# Extra Field Settings (efs) — manual setup guide

**Extra Field Settings** (`efs`) is a **developer framework** for building "extra
fields" — pseudo-fields that appear and behave like real fields on an entity's
displays (they are configurable and themeable) but **store no data**. It lets
developers declare computed or display-only fields as **plugins**, each with its own
settings, rather than wiring them up by hand.

Its distinguishing feature is flexibility: unlike some similar tools, an efs plugin
can be placed on both the **view display** and the **form display** of any entity
type through the Field UI, and each plugin has its own instance that can be
configured differently per display — even per entity type, where the plugin's
implementation allows it.

This is aimed at module developers and site programmers; there is no user interface
or settings form of its own. Because a plugin renders whatever its code produces,
output safety is the plugin author's responsibility (escape and authorise as usual).
efs itself has no content or access-control role. It has no dependencies beyond
Drupal core and targets Drupal 10 and 11.

**Important compatibility note:** do **not** run efs alongside the
[Extra Field](https://www.drupal.org/project/extra_field) module — the maintainers
warn that using both together can cause unexpected behaviour. (Extra Field is
similar but only supports view displays; efs supports both view and form displays.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no central settings
form. You use it by implementing extra-field plugins in your own module; each
plugin instance is then configured on the entity's **Manage display** / **Manage
form display**.

## Where it lives in the admin menu

Extra Field Settings adds no admin page. The extra fields you build with it appear
on **Structure → Content types → (type) → Manage display** and **Manage form
display** (and the equivalents for other entity types), where each instance carries
its own settings.

## How to use it

1. Install and enable Extra Field Settings (see Installation), and make sure the
   **Extra Field** module is *not* also enabled.
2. In your own module, implement an extra-field **plugin** using the plugin type efs
   defines, adding any per-instance settings your plugin needs. Escape and authorise
   the plugin's output.
3. Place the plugin on the target entity's **Manage display** or **Manage form
   display**, configure its instance settings, and save.
