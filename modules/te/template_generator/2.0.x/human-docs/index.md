# Template Generator — manual setup guide

**Template Generator** (`template_generator`) automatically scaffolds Twig template
files for your content entities, so themers get a solid starting‑point template —
with the right theme suggestion name and the available variables listed in a header
comment — rather than writing each one by hand from scratch.

The problem it solves is the tedious, error‑prone first step of theming: figuring
out the correct template filename for a given entity, bundle, and view mode, and
remembering which variables are available inside it. Template Generator does that
for you. You choose which entities to generate templates for, decide whether the
files should be organised by view mode or by bundle, and optionally ignore certain
view modes or bundles. It can even regenerate templates automatically every time you
change a display's settings.

By default the generated files are written to `your-current-theme/templates`, and
you can point it at a different theme in the module's configuration.

This module has a **settings page** and is a developer/theming productivity tool. It
**writes files into your theme**, so treat it as a scaffolding aid used in
development and review the generated templates before relying on them — it has no
content or access role. It has no module dependencies of its own and ships no
submodules. (The module was sponsored by GAYA.)

This guide is written for a **human** using the admin UI and working in a theme. If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose entities, organisation, target
   theme, and generate the templates.

## Where it lives in the admin menu

Once enabled, the module's settings form is registered at the
`template_generator.settings` route. Open it from the admin configuration area to
select entities and run generation — see [Configuration](configuration/index.md).
