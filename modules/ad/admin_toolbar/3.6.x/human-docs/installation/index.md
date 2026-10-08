# Installation

## Requirements

Admin Toolbar is deliberately lightweight. It needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on Admin Toolbar.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_toolbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_toolbar -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_toolbar -y
```

That's all it takes. The drop‑down toolbar is active immediately for any user who
can see the admin toolbar — hover over a top‑level item and its submenu fans out.
There is no required configuration.

## Submodules — enable only what you need

Admin Toolbar ships three optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Extra Tools** | `admin_toolbar_tools` | One‑click action links under the Drupal icon — *Flush all caches* (and selective cache clears for CSS/JS, Views, Twig, menus, plugins, render cache), *Run cron*, plus quick "Add content" / "Add bundle" / manage‑fields shortcuts. This is what most people mean by "the admin toolbar with the flush‑cache button." |
| **Search** | `admin_toolbar_search` | A live search/filter box in the toolbar so you can type a keyword and jump straight to any admin link. Adds a `use admin toolbar search` permission and an Alt + a focus shortcut. |
| **Links Access Filter** | `admin_toolbar_links_access_filter` | Hides admin menu links the current user cannot access. **Deprecated** — Drupal core handles this from 10.3 onward, so do not enable it on new sites. |

For example, to add the popular Extra Tools action links:

```bash
drush en admin_toolbar_tools -y
```

Each submodule requires the base Admin Toolbar module, which is already present
once you have installed it above.

## Verify it worked

Log in as an administrator. The admin toolbar at the top of every page should now
expand into nested drop‑down menus on hover. If you enabled **Extra Tools**, click
the Drupal icon at the far left of the toolbar and you should see *Flush all
caches*, *Run cron*, and related action links.

Next, if you want to fine‑tune the toolbar's behavior, see
[Configuration](../configuration/index.md) — but remember it works well out of the
box with no changes.
