# Installation

## Requirements

Quick Node Clone runs on **Drupal 10 or 11** (`^10 || ^11`) and depends only on
core's **Node** module (`node`), which every content site already has enabled.
There are no other contrib or PHP-library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/quick_node_clone -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/quick_node_clone -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quick_node_clone -y
```

## Grant the Clone permission

Installing the module does **not** make the **Clone** action appear on its own.
Quick Node Clone defines a fine-grained permission **per content type**, and a
role only sees the Clone tab once it has the matching permission:

- **Clone _<type>_ content** — clone *any* node of that content type.
- **Clone own _<type>_ content** — clone only nodes the user authored, of that
  type.

There is also an **Administer Quick Node Clone Settings** permission that
controls who can reach the settings/exclusion forms described in
[Configuration](../configuration/index.md).

Grant these at **People → Permissions**
(`/admin/people/permissions`) to the roles that need them, and click **Save
permissions**.

## Verify it worked

Log in as an administrator and go to **Configuration → Quick Node Clone
Setting** (`/admin/config/quick-node-clone`). You should see the **Quick Node
Clone Setting** page with its **Node** and **Paragraph** tabs. Then open any
node whose content type you granted the clone permission for — a **Clone** tab
should now appear alongside **View** and **Edit**.

Next, review the [configuration](../configuration/index.md).
