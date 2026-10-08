# Configuration

For regular menus, Menu CSS Names needs **no configuration** — it adds the CSS
classes as soon as the module is enabled. Everything on this page is optional.

## Local tasks and actions

On Drupal 10/11 the module adds a small **admin settings** form whose job is to
control whether the same link-text-derived class names are also applied to
**local tasks and actions** — that is, the tabs (such as *View / Edit / Delete*)
and action links Drupal renders on admin and content pages. Turn this on if you
want to target those tabs and action links in your CSS the same way you target
menu items; leave it off if you only need classes on ordinary menus.

1. Log in as an administrator (the module provides its own administer permission —
   grant it under **People → Permissions** if you want a non-admin role to reach
   the form).
2. Open the Menu CSS Names settings form under **Configuration**.
3. Toggle the option for **local tasks and actions** to match whether you want
   classes added there.
4. Save the form.

## Keeping classes stable

Because each class is generated from the item's link text, changing a link's
label changes its class. If your stylesheet depends on a particular class, keep
the corresponding link text stable — or be ready to update the CSS when the label
changes.
