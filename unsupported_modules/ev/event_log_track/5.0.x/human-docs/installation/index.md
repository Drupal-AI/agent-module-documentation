<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 11.3 or 12.0** (`core_version_requirement: ^11.3 || ^12.0`).
- No third-party Composer packages or PHP libraries. Individual submodules may
  depend on the matching core or contrib module (for example the workflows
  submodule needs Content Moderation, the webform submodule needs Webform).

## Install with Composer

From the project root:

```bash
composer require drupal/events_log_track -W
```

> **Note the name.** The Composer package is `drupal/events_log_track` (plural
> "events"), but the module machine name you enable with Drush is
> `event_log_track` (singular).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/events_log_track -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en event_log_track -y
```

The base module gives you the report, the settings form, and the logging engine —
but it logs almost nothing until you enable at least one submodule.

## Submodules — enable one per thing you want to track

The base module ships a large family of submodules. Enable only the ones you need
with `drush en`:

| Submodule | Machine name | Tracks |
|-----------|--------------|--------|
| Node | `event_log_track_node` | Content (node) create/update/delete |
| User | `event_log_track_user` | User accounts, including role changes |
| Auth | `event_log_track_auth` | Login, logout, password resets, failed logins, 403s |
| Taxonomy | `event_log_track_taxonomy` | Vocabulary and term changes |
| Media | `event_log_track_media` | Media entity changes |
| File | `event_log_track_file` | File changes |
| Comment | `event_log_track_comment` | Comment changes |
| Block content | `event_log_track_block_content` | Custom block changes |
| Menu | `event_log_track_menu` | Menu and menu-link changes |
| Config | `event_log_track_config` | Configuration changes (with field-level diff) |
| Workflows | `event_log_track_workflows` | Content-moderation state transitions |
| Webform | `event_log_track_webform` | Webform submission actions |
| Group | `event_log_track_group` | Group changes |
| Group membership | `event_log_track_group_membership` | Group membership changes |
| Masquerade | `event_log_track_masquerade` | Masquerade start/stop |
| TFA | `event_log_track_tfa` | Two-factor-authentication logins |
| Clear cache | `event_log_track_clear_cache` | Cache-clear events |
| Syslog | `event_log_track_syslog` | Forwards every event to syslog |
| Stdout | `event_log_track_stdout` | Forwards every event to stdout/stderr |

For example, to audit content and user changes:

```bash
drush en event_log_track_node event_log_track_user -y
```

Each submodule requires the base module, which is already present once you have
installed it above.
