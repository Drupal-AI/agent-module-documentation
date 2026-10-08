# Extension Reference — manual setup guide

**Extension Reference** (`extension_reference`) provides a **field type that
references installed extensions** — modules, themes, or installation profiles. Add
the field to a content entity and editors can pick an extension from a select box;
the entity then stores that extension's machine name. It's a small building block
for modelling relationships to the code that makes up your site — think a "custom
theme switcher", an extension catalog/shop, or associating commerce products with
installation profiles.

The field currently lists all extensions in a simple select widget (the project
notes that option filtering may be added later). It depends on core **Field** and
**Options**, sits in the Field package, stores an extension machine name as its
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

Extension Reference adds no admin configuration page. You use it from the **Field
UI** — for example **Structure → Content types → *(type)* → Manage fields** — when
adding or configuring a field.

## How to use it

1. Go to the **Manage fields** page of the entity/bundle you want to extend (for a
   content type, `/admin/structure/types/manage/<type>/fields`).
2. Click **Add field** and choose the **Extension** field type provided by this
   module.
3. Save the field settings. On the entity's edit form, editors will see a select
   box listing the available extensions; the chosen extension's machine name is
   stored as the field value.

> **Related:** a similar project, **Extension Reference Field**
> (`extension_reference_field`), offers the same idea; pick whichever fits your
> site.
