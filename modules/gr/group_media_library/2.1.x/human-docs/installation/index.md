# Installation

## Requirements

Group Media Library needs core Media Library and the Group module:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Media Library** module (`media_library`).
- The **Group** module (`group`).
- The **Group Finder** module (`group_finder`) — used to work out which group the
  media library was opened from. Composer installs it as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_media_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Group Finder) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_media_library -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_media_library -y
```

Core Media Library, Group, and Group Finder are enabled as dependencies if they
are not already on.

## Submodules — enable only what you need

The base module is mostly plumbing; the behavior you want usually comes from one
or more of these submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Group Media** | `group_media_library_groupmedia` | Support for using the group media library with the Group Media (`groupmedia`) module. Requires the **Widget** submodule (or that you add the group media library state to your widget yourself). |
| **Media Tracker** | `group_media_library_media_tracker` | Instantly attaches media created in the media library to the corresponding group (found via the group finder). Requires Group Media. |
| **Widget** | `group_media_library_widget` | Makes the media library *field widget* aware of the group it was opened from. This is the one most sites want. |

Enable them individually with `drush en`, for example:

```bash
drush en group_media_library_widget -y
```

## Verify it worked

With the **Widget** submodule enabled, open the media library from a media field
inside a group context and confirm that it operates in that group's scope. If you
enabled **Media Tracker**, create a new media item through the library and confirm
it is attached to the corresponding group. Finally, check that group-scoped media
is only visible to the appropriate members through your Group / media access
configuration.
