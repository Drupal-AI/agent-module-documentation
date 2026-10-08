# Configuration

Big Menu has **one** setting and no per‑menu options. Its entire job is to replace
core's menu overview screen with a depth‑limited version, so most sites never need
to change anything.

## The menu screen it takes over

Big Menu does not add its own menu‑editing page. It reuses the existing screen at
**Structure → Menus → Edit menu** (`/admin/structure/menu/manage/{menu}`) and simply
renders it more cheaply:

- Only the top level (or as many levels as **Max depth** allows) loads at first.
- Every parent link that has children gets an **Edit child items** link. Clicking it
  reloads the same screen rooted at that branch, with a breadcrumb back to the top.
- Everything else — drag‑and‑drop reordering, weights, the enable/disable toggle,
  the operations menu, and **Add link** — works as usual, scoped to the branch you
  are viewing.

Disabling the module instantly restores core's full‑tree menu screen.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Big Menu**, or navigate directly to `/admin/config/bigmenu`.

## Max depth

The form has a single number field, **Max depth** ("The max depth to display on a
menu."):

- It controls **how many levels of the menu tree render at once** on the edit screen.
- The default is **1** — just the top level, with an *Edit child items* link on every
  parent. This is the shallowest, fastest option.
- Raise it to **2** or **3** if you want a little more context per screen (children,
  grandchildren) at the cost of loading more rows. The allowed range is **0–10**; a
  value of 0 behaves like 1.

Click **Save configuration**. The change takes effect the next time you open a menu
for editing.

## Set it from the command line

```bash
# read the current value
drush config:get bigmenu.settings max_depth

# show two levels at a time
drush config:set bigmenu.settings max_depth 2 -y
```
