# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12.0`).
- No third-party Composer or PHP library requirements. The submodules that track a
  particular subsystem (e.g. the webform tracker) naturally require the module for that
  subsystem to be present.

## Install with Composer

From the project root — note the project name uses the plural **events_log_track**:

```bash
composer require drupal/events_log_track -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/events_log_track -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module you enable is named **event_log_track** (singular):

```bash
drush en event_log_track -y
```

To also see the audit trail in the admin UI, enable the UI submodule:

```bash
drush en event_log_track_ui -y
```

## Submodules — enable only the areas you want to audit

Turn on a submodule for each subsystem you want tracked. Logging starts the moment a
submodule is enabled. All are named with the singular **event_log_track_** prefix:

| Area tracked | Machine name |
|---|---|
| Node CUD | `event_log_track_node` |
| User CUD | `event_log_track_user` |
| User authentication (login/logout/password) | `event_log_track_auth` |
| Authentication via TFA | `event_log_track_tfa` |
| Configuration changes | `event_log_track_config` |
| File CUD | `event_log_track_file` |
| Taxonomy (vocabularies and terms) | `event_log_track_taxonomy` |
| Media CUD | `event_log_track_media` |
| Menu and menu-item CUD | `event_log_track_menu` |
| Comment CUD | `event_log_track_comment` |
| Webform submissions | `event_log_track_webform` |
| Workflows CUD | `event_log_track_workflows` |
| Group CUD | `event_log_track_group` |
| Group membership | `event_log_track_group_membership` |
| Masquerade events | `event_log_track_masquerade` |
| Block content CUD | `event_log_track_block_content` |
| Cache clears | `event_log_track_clear_cache` |
| Output to syslog | `event_log_track_syslog` |
| Output to stdout | `event_log_track_stdout` |

For example, to audit node and configuration changes:

```bash
drush en event_log_track_node event_log_track_config -y
```

## Verify it worked

Perform a tracked action (for example, create or edit a node if you enabled the node
tracker), then visit **Reports → Events Log Track**
(`/admin/reports/events-track`) and confirm the entry appears. Then see
[Configuration](../configuration/index.md) to set retention and output options.
