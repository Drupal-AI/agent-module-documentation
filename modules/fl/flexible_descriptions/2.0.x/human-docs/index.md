# Flexible descriptions — manual setup guide

**Flexible descriptions** (`flexible_descriptions`) gives you one central screen
for managing the *descriptions* — the help text that appears under a field on an
entity form — across all your content entity types and bundles. Instead of opening
each field's settings and editing its description one at a time, you manage them
all from a single admin form.

What makes this module distinctive is that it stores those descriptions as
**content**, not configuration. Each override lives in a `flexible_description`
entity keyed to an entity-type + bundle, so editing help text does **not** require
a configuration export/import and cannot be clobbered during a deployment. That
also means non-developers can safely maintain the wording: access is granted
per-bundle through dynamically generated permissions (for example, "manage
flexible descriptions in `article|node`"), so you can let a sub-editor look after
just one content type's help text.

The 2.0 release adds two things worth knowing about: **inline** create/edit of
descriptions powered by the HTMX library (edit help text without a full page
reload), and **translation** support, so multilingual sites can localise the help
text per language. There is also a YAML **import/export** mechanism for moving
descriptions between environments, and an optional **Flexible descriptions sync**
submodule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the sync submodule.
2. [Configuration](configuration/index.md) — the settings form, the management
   screen, and the per-bundle permissions.

## Where it lives in the admin menu

The module's settings form is registered as `entity.flexible_description.settings`
(under the **Administration** package). From there you reach the central
management screen where all field descriptions are edited. Per-bundle editing
access is controlled by permissions at **People → Permissions**.
