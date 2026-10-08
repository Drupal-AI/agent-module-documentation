# Image Styles Mapping — manual setup guide

**Image Styles Mapping** (`image_styles_mapping`) adds an admin **report** that
lists everywhere image styles and responsive image styles are used across your
site — both in entity view‑display image fields and in Views field handlers. It's
the report you open before deleting or refactoring an image style, so you can
confirm nothing still references it.

The report lives under **Reports** and has three tabs: an **all** view that
combines everything on one page, a **fields** view that scans every entity view
display for image and responsive‑image formatters, and a **views** view that
scans every View display for image fields. Each row records the entity type,
bundle, view mode, and field, plus which style is used, and links to the relevant
view‑mode or Views display edit page (when you have access). Rows are sortable by
column.

Access is gated by a dedicated permission (**access image styles mapping
report**), so you can give a site builder read‑only visibility without broader
admin rights. The report performs no writes — it's a pure auditing tool. The
"views" tab automatically disappears when the core Views module isn't enabled.
The module depends on core's **Field UI**, and the column that reports "which
style is used" is provided by an extensible plugin type, so other modules can add
their own style‑mapping columns.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form** — the module adds a report and a permission,
described in "How to use it" below.

## Where it lives in the admin menu

The report is at **Reports → Image Styles Mapping**
(`/admin/reports/image_styles_mapping_report`). Viewing it requires the **access
image styles mapping report** permission.

## How to use it

1. **Grant the permission.** At **People → Permissions**, give **access image
   styles mapping report** to the roles that should see the report (a
   site‑builder or admin role).
2. **Open the report** at `/admin/reports/image_styles_mapping_report`.
3. **Switch tabs** to focus your audit: **all** (combined), **fields** (view
   displays), or **views** (Views field handlers).
4. **Sort and drill in.** Sort by entity, bundle, view mode, or field, and click a
   row to jump to the field's view‑mode edit page or the Views display edit page.
5. **Audit before you change.** Before deleting or renaming an image style, open
   the report and confirm no field or view still references it.

> **Note:** The **views** tab appears only when the core **Views** module is
> enabled; without Views, the fields report is still available.
