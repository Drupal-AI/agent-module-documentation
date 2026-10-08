# ECA Breadcrumbs — manual setup guide

**ECA Breadcrumbs** (`eca_breadcrumbs`) lets you customize your site's breadcrumb
trail **without writing code**, by driving it from the **ECA (Event‑Condition‑Action)**
module. It adds a "Build breadcrumb" event that fires whenever Drupal assembles a
breadcrumb, plus two actions — **Add breadcrumb item** (append a single item) and
**Set breadcrumb items** (replace the whole trail) — that you wire up in a visual ECA
model. Titles and URLs accept any Drupal **token**, and route parameters (nodes,
users, taxonomy terms) are automatically available as tokens, so you can build trails
that reflect your taxonomy hierarchy, content type, user role, or any business logic
ECA can express.

It depends on the **ECA** module, the **Token** module, and core **System**. There is
nothing to configure after installing: the module registers its breadcrumb builder
service and makes the event and actions available in ECA automatically. Its breadcrumb
builder runs at a high priority (100), so it can override most default breadcrumb
builders — but if your ECA model sets no items, the normal builders still handle the
page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

ECA Breadcrumbs has no settings page of its own. All the work happens in the ECA model
builder at **Administration → ECA → Models** (`/admin/eca`), where its event and
actions appear once the module is enabled.

## How to use it

1. Go to **Administration → ECA → Models** (`/admin/eca`) and click **Add model**.
   Give it a meaningful name such as "Custom Breadcrumbs".
2. Add an **event** and choose **Breadcrumb: Build breadcrumb**.
3. (Optional) Add **conditions** to target specific pages — for example *Node is of
   type*, *Route name matches*, *Entity has field*, or *User has role*.
4. Add an action to create a token for the entity loaded from the route parameters, if
   you want to reference its fields.
5. Add a breadcrumb **action**:
   - **Breadcrumb: add item** — enter a **Title** (tokens allowed, e.g. `[node:title]`)
     and a **URL** (tokens allowed; leave empty for the current page).
   - **Breadcrumb: set items** — enter one item per line in the format `Title|URL`
     (leave the URL empty to make an item non‑clickable). URLs may be internal paths
     (`/products`), external URLs, or route names.
6. **Save** the model and **clear the cache**, then test on your site. Remember to
   clear cache again after any later change to an ECA model.
