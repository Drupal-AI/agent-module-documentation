# Configuration

This module does its work through configuration it ships on install, plus a few
steps you complete by hand. There is no single "settings form" — instead you build
your section taxonomy, make the access‑control field visible to editors, and assign
editors to sections through Workbench Access.

## 1. Set up your Access Control taxonomy

After install you have a vocabulary called **Access Control** at **Structure →
Taxonomy → Access Control**. Add a term for each site section you want to control.
The vocabulary is **hierarchical**, and hierarchy matters for access: an editor
assigned to a parent term automatically gets access to all of its child terms.

For example:

```
- Adult social care and health
- Children, young people and families
  - Children and young people
  - Social care
  - Adoption
  - Fostering
  - Health and wellbeing
- Schools and learning
  - School Admissions
  - Early years and child care
  - Post-16 options
  - Adult learning
- Jobs and apprenticeships
- News
- Events
```

Here an editor tagged with *Children, young people and families* can also edit
*Social care*, *Adoption*, *Fostering*, and the other children under it; an editor
tagged only with *Fostering* cannot edit *Adoption* or *Social care*.

## 2. Make the access‑control field visible

The module adds the **Access Control** field to the Subsite Overview, Subsite
Page, Service Landing Page, and Service Page content types. Fields are not shown on
the edit form by default, so for each of those content types go to **Structure →
Content types → *(type)* → Manage form display** and make the **Access Control**
field visible, then save. Only then can editors tag content with a section.

If you want to control other content types too, add the same field to them
following the same pattern.

## 3. Assign editors to sections

Go to **Configuration → Workflow → Workbench Access**
(`/admin/config/workflow/workbench_access`). The module ships one scheme called
**Site Section** that uses the Access Control vocabulary. Click **Site Section**,
and beside each section you will see two links:

- **Editors** — manually add individual editors to that section.
- **Role** — add *all* editors with a given role to a section at once. For example,
  add everyone with a *News editor* role to the *News* section.

You can add more schemes ("scenarios") if a single Site Section scheme is not
enough, though most sites will not need to.

## The Devolved Editor role

Assign the bundled **Devolved Editor** role (under **People**) to editors who
should only work within their assigned sections — for instance external or partner
contributors. By default a devolved editor can create news, events, and service
pages, and edit existing subsite overview and service landing pages, but cannot
create new ones. Combine the role with a section assignment so the editor is scoped
both by what they may do and which sections they may touch.
