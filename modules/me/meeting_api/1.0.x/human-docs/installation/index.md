# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Datetime Range Timezone** module (`datetime_range_timezone`) — Meeting API
  depends on it so that each meeting carries an explicit timezone. Installing Meeting
  API with Composer pulls it in.

There are no PHP library requirements. Note this is an **alpha** release
(1.0.0‑alpha3), so treat the API as unsettled and test upgrades carefully.

## Install with Composer

From the project root:

```bash
composer require drupal/meeting_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install
`datetime_range_timezone` and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/meeting_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en meeting_api -y
```

## Submodules — enable what you need

Meeting API ships two submodules. Enable them individually:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Manual** | `meeting_api_manual` | A backend for meetings whose join URL is simply pasted in by hand — the simplest case, useful when you already have a meeting link from any platform. |
| **Scheduler** | `meeting_api_scheduler` | Support for automated meeting scheduling. |

For example, to enable manual meetings:

```bash
drush en meeting_api_manual -y
```

To integrate a real conferencing platform, install a **provider** module too — for
example **BigBlueButton** via `meeting_api_bbb` (a separate project), which supplies
a backend plugin for the framework.

## Verify it worked

After enabling, you should be able to manage **meeting types** under **Structure**
(with the `administer meeting_api_meeting types` permission) and create **meetings**
as content entities. If you enabled `meeting_api_manual`, creating a meeting should
let you paste in a join URL. See "How to use it" on the
[overview page](../index.md).
