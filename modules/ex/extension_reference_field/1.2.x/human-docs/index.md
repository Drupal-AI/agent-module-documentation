# Extension Reference Field — manual setup guide

**Extension Reference Field** (`extension_reference_field`) defines a **field type
for referencing Drupal extensions** — modules, themes, and installation profiles.
Add the field to a content type (or any fieldable entity) and it lets content or
configuration point at a specific extension by its machine name. That's useful
whenever you need to record which extension something relates to: documentation
that describes a module, a catalog of extensions, or config that needs to remember
an association.

All extension types are supported. When you add the field you choose which
**extension type** it references (module, theme, or profile) from a dropdown. The
module sits in the Field types package, stores an extension identifier as its
value, and has no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module. You use it by adding a field to an
entity, as described in "How to use it" below.

## Where it lives in the admin menu

Extension Reference Field adds no admin configuration page. You use it from the
**Field UI** — for example **Structure → Content types → *(type)* → Manage
fields** — when adding or configuring a field.

## How to use it

1. Go to the **Manage fields** page of the content type you want to extend
   (`/admin/structure/types/manage/<content-type>/fields`).
2. Click **Add field** and choose **Extension** from the list of field types.
3. In the field settings, choose the **Extension type** you want to reference
   (module, theme, or profile) from the dropdown.
4. Save the field settings. Editors can now select an extension of that type on the
   entity's edit form, and the entity stores its machine name.

> **Related:** a similar project, **Extension Reference** (`extension_reference`),
> offers the same idea; pick whichever fits your site.
