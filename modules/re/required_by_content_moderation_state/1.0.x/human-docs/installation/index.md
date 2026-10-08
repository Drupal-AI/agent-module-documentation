# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Content Moderation** module, with a workflow applied to the content you
  want to govern.
- The contributed **Required API** module (`required_api`) — Composer pulls it in
  automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/required_by_content_moderation_state -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Required API
dependency and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/required_by_content_moderation_state -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en required_by_content_moderation_state -y
```

Enabling this module also enables **Required API** and core **Content
Moderation** if they are not already on.

## Verify it worked

Edit any field on a content type that has a moderation workflow (**Structure →
Content types → *(your type)* → Manage fields → Edit**). Under **Choose a required
strategy** you should now see the **Required by Content Moderation state** option,
with a list of moderation states to pick from. See the "How to use it" section of
the [overview](../index.md) for the full walkthrough.
