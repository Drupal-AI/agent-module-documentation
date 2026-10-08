# Configuration Entity View — manual setup guide

**Configuration Entity View** (`config_views`) lets you build Views that list
**configuration entities** — roles, menus, image styles, content types, text
formats, vocabularies, even Views themselves — the same way you'd normally build
a View of nodes or users. Once you have such a View, those lists can be filtered,
sorted, paged, exported, and reused like any other View, instead of being locked
inside core's fixed admin listing pages.

Under the hood it registers a Views "base table" for every configuration-entity
type that has a list builder, and it reads each type's configuration *schema* to
expose the useful properties (labels, descriptions, booleans, integers, strings)
as Views fields, filters, and sorts. It also adds an **Operations** column so your
list can show the edit/delete links. Because config entities don't live in normal
database tables, it swaps in a special Views query engine that runs Drupal's
Entity Query API behind the scenes — you don't have to think about that; it's
selected automatically when you build a View on one of these tables.

The module ships around 14 ready-made Views that can *replace* core's admin list
pages (Content types, Menus, Image styles, Taxonomy, and more). Several are turned
on by default and take over those pages; others ship disabled so you can opt in
when you want a customizable listing. It also provides an entity-reference
selection method, so a reference field can draw its allowed values from a
config-entity View.

There is no settings form, no permission, and no Drush command of its own — you
use it by building Views and by enabling the shipped ones.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Configuration Entity View has **no configuration page of its own**. You work with
it at **Structure → Views** (`/admin/structure/views`): the **Add view** wizard
gains a **Configuration** group in its "Show" dropdown, and the shipped default
Views appear in the Views list where you can enable or edit them.

## How to use it

### Build a View of configuration entities

1. Go to **Structure → Views → Add view** (`/admin/structure/views/add`).
2. Under **View settings → Show**, notice the dropdown is now grouped into
   **Content** and **Configuration**. Pick the config entity you want to list —
   for example *User role*, *Content type*, or *Image style*.
3. Choose a display (page or block), add the fields, filters, and sorts you want
   (including the **Operations** field for edit/delete links), and save.

The available fields depend on how richly each configuration type describes
itself in its schema — for a content type you'll get its label, description, and
boolean/number settings, plus operations.

### Enable a ready-made listing View

The module installs about 14 Views. Some are enabled by default and take over the
matching core admin page (for example the **Content types** View replaces
`admin/structure/types`); others ship disabled so you can opt in. To turn one on,
go to **Structure → Views**, find the View (such as *User roles*, *Text formats*,
or *View modes*), and enable it — or from the command line:

```bash
drush views:enable user_roles
```

Once enabled, that customizable View takes over the corresponding admin listing,
so you can add exposed filters, extra columns, or a pager to it.

### Reference config entities from a field

If you have an entity-reference field that targets a configuration entity type,
you can set its reference method to **"Views: Filter by a Configuration View"** in
the field's settings, then point it at one of your config-entity Views. That lets
you curate exactly which roles, formats, or content types the field offers.
