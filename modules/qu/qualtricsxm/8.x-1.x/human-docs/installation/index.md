# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- A **Qualtrics account** and an **API token** — the module cannot list or fetch
  surveys without one. You will also need your Qualtrics **base URL** (the API/data
  centre URL for your account).

There are no additional contrib‑module or PHP‑library dependencies for the base
module.

## Install with Composer

From the project root:

```bash
composer require drupal/qualtricsxm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qualtricsxm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qualtricsxm -y
```

## Submodules — enable only what you need

Both submodules require the base QualtricsXM module, which is already present once
you have installed it above.

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **QualtricsXM Embed** | `qualtricsxm_embed` | A `field_qualtricsxm_survey` field type with a drop‑down widget (pick a survey from your account) and an iframe formatter, so any fieldable entity can display a survey. |
| **QualtricsXM Insights** | `qualtricsxm_insights` | Insight entities with add/edit/delete admin forms for tracking survey insight metadata. |

For example, to add the survey field type:

```bash
drush en qualtricsxm_embed -y
```

## Verify it worked

Once enabled, head to [Configuration](../configuration/index.md) to enter your
Qualtrics API token and base URL. After that, open
**Configuration → Content authoring → QualtricsXM → Surveys**
(`/admin/config/content/qualtricsxm/surveys`) — if your token and base URL are
correct you should see the list of surveys pulled from your Qualtrics account. If
the list is empty or shows an error, re‑check the token and base URL on the
settings form.
