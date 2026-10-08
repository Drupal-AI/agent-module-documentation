<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contrib **Workbench Moderation** module (`drupal/workbench_moderation: ^1.0`).
  This is a hard dependency, pulled in by Composer and enabled as a dependency.

> **Important:** this module targets the contrib **Workbench Moderation** system, which
> is *not* the same as core's **Content Moderation**. On a site that uses only core
> moderation there are no Workbench moderation states, so no bulk actions would be
> derived. Make sure Workbench Moderation is the moderation system in use.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/workbench_moderation_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/workbench_moderation_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en workbench_moderation_actions -y
```

**What enabling it does:** on install the module deletes core's `node_publish_action`
and `node_unpublish_action` (which misbehave under Workbench Moderation) and creates
one bulk action for every combination of moderated entity type and moderation state
that exists at that moment. There are no submodules and no configuration form.

Because the action list is built at install time, if you add moderation states later,
reinstall the module to regenerate the actions for the new states. Uninstalling the
module restores core's original Publish/Unpublish actions automatically.

## Verify it worked

Go to **Content** (`/admin/content`) and open the **Action** dropdown. Instead of
core's *Publish content* / *Unpublish content*, you should now see one **Set
&lt;Entity&gt; as &lt;State&gt;** entry per moderation state. Each moderatable row
should also show a **Set to &lt;state&gt;** operation link.
