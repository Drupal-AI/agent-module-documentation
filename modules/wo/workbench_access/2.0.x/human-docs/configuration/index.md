# Configuration

Setting up Workbench Access has three parts: create an **access scheme** (which
turns a vocabulary or menu into editorial sections), make sure your content has a
field that files it under a section, and **assign editors** to sections along with
the normal edit permission they need. This page walks through each.

## Step 1 — create an access scheme

1. Log in as a user with the **Administer workbench access** permission.
2. Go to **Configuration → Workflow → Workbench Access**
   (`/admin/config/workflow/workbench_access`) and click **Add access scheme**.
3. Give the scheme a **Label** and a **Plural label** (shown when picking
   sections).
4. Choose the **scheme type** — the hierarchy your sections come from:
   - **Taxonomy** — the terms of one or more vocabularies become the sections. Pick
     this if your editorial structure is (or can be) a vocabulary such as
     *Department* or *Editorial section*.
   - **Menu** — the items of one or more menus become the sections. Pick this if you
     want sections to mirror the site's navigation tree.
5. Configure the scheme's settings for the type you chose:
   - For a **Taxonomy** scheme: select which **vocabularies** provide the sections,
     and map which **field** on each content bundle holds the section reference.
   - For a **Menu** scheme: select which **menus** provide the sections, and which
     **node bundles** participate.
6. Save. You can create several schemes on one site (for example one taxonomy
   scheme and one menu scheme).

## Step 2 — make sure content can be filed under a section

For a taxonomy scheme, the content types you want to control need a term-reference
field pointing at the section vocabulary — this is the field you mapped in the
scheme settings. Editors then choose a section on that field when creating or
editing content. For a menu scheme, the node's menu placement determines its
section. Once this is in place, each piece of content belongs to a section (or to
none).

## Step 3 — assign editors to sections

Assign users or roles to the sections they should be able to edit. You can do this
per role or per individual user from the Workbench Access admin area and the
section management screens. Remember two rules:

- A role must have the **Use workbench access** permission before its members can
  be assigned to sections.
- Editors assigned to a **parent** section automatically gain access to all
  sections beneath it.

## Step 4 — grant the normal edit permission

This is the step people most often miss. Workbench Access only *denies* access to
users outside a section — it never grants edit rights by itself. Each editor still
needs a standard content permission such as **Article: Edit any content** at
**People → Permissions**. Section membership then narrows that permission down to
the editor's own sections.

## The module's permissions

At **People → Permissions**, Workbench Access adds:

- **Administer workbench access** — configure the module and its access schemes.
- **Assign workbench access** — assign users and roles to **all** sections.
- **Assign selected workbench access** — assign users/roles only within sections
  the assigner already belongs to.
- **Batch update workbench access** — batch-assign content to a section from the
  content overview page.
- **Bypass workbench access** — access to **every** section (super-editor). Grant
  sparingly.
- **Use workbench access** — marks a role's members as assignable to sections
  (required before assigning them).
- **View workbench access information** — see the editorial-section status shown on
  each content page.

## The "deny on empty" setting

The settings form (at `/admin/config/workflow/workbench_access/settings`) has one
notable option, **Deny on empty**. When turned on, content that has **not** been
assigned to any section is denied to non-bypass editors. Leave it off (the default)
if unassigned content should remain editable by anyone with the normal permission.

## Extending it

The two section sources (taxonomy and menu) are plugins, and a developer can add a
new one — for example basing sections on domains or an org chart — by writing an
*AccessControlHierarchy* plugin. See the sibling [`agent/`](../agent/start.md) docs
for how.
