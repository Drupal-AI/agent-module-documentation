# Field Group Settings — manual setup guide

**Field Group Settings** (`field_group_settings`) adds a new **"Settings"** field‑group
formatter to the [Field Group](https://www.drupal.org/project/field_group) module. It
tucks a group of form fields into a collapsible panel that's opened and closed by a
small floating **gear icon**, and it can restrict which user **roles** even see that
panel.

It's a tidy way to declutter a long edit form: put advanced, meta, SEO, scheduling, or
"rarely touched" fields into a Settings group so they stay out of the way behind the
gear until an editor wants them. Because you can scope the group to specific roles, you
can also give power users an "advanced options" area that regular authors never see.

The panel toggles purely client‑side (no page reload). Its role restriction is a real
render‑level `#access` check — a user whose roles aren't allowed simply doesn't get
those fields on the form at all. A companion permission, **Bypass field_group_settings
field visibility**, lets chosen roles always see every Settings group.

> **One caveat worth knowing.** The role restriction hides fields on the *form*; it is
> a UI convenience, **not** a field‑level access‑control mechanism. A role that can
> otherwise edit those fields (through another form mode, the API, or REST) is
> unaffected. Use core field access or a dedicated access module if you need a real
> security boundary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Field Group.
2. [Configuration](configuration/index.md) — add a Settings group on Manage form
   display, set which roles can view it, and the bypass permission.

## Where it lives in the admin menu

There is no module settings page. You configure everything through the **Field Group**
UI on an entity's **Manage form display** tab
(`/admin/structure/…/form-display`) — the same place you add tabs or accordions. The
one permission it adds, **Bypass field_group_settings field visibility**, is set on the
usual **People → Permissions** page.
