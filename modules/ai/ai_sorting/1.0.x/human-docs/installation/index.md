# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`), enabled by default on standard sites.
- The **RL** reinforcement-learning module (`rl`), which supplies the learning
  model this sort plugin uses. Composer pulls it in as a dependency.

There are no additional third-party PHP library requirements. The current
release is a release candidate (`1.0.0-rc1`).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_sorting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the RL module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_sorting -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_sorting -y
```

Once enabled, the AI / reinforcement-learning sort becomes available as a sort
criterion in the **Views UI** (**Structure → Views**). Add it to a view to order
results by learned relevance. Remember that the model learns from user
interactions, so make sure that data collection fits your privacy policy.
