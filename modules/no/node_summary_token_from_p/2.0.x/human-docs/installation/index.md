# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`) — enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_summary_token_from_p -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_summary_token_from_p -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_summary_token_from_p -y
```

That's all it takes. There is no configuration.

## Verify it worked

Find (or create) a node that has **no body field** — for example a content type built
entirely from Paragraphs or custom fields. Then check that `[node:summary]` resolves
for it: the quickest way is to set a **Metatag** description pattern to
`[node:summary]` and view the page source for that node, or use any other place a
token is rendered. Where core would have produced an empty summary, you should now see
the first few sentences drawn from the node's paragraph content.
