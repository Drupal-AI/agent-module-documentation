# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Views Data Export** module (`views_data_export`) — required, so you can
  export the analysed feedback.
- An **OpenAI account and API secret key** — the module calls OpenAI's Chat
  Completions API, which requires a paid OpenAI subscription.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feedback_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Views Data Export
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feedback_ai -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feedback_ai -y
```

Drupal enables the Views Data Export dependency automatically if it isn't already
on.

## A note on the API key

The OpenAI API key is a credential. You enter it on the module's settings form
after enabling the module, and it is saved to Drupal configuration
(`feedback_openai.settings`). Treat it like any other secret: grant the module's
admin permission only to trusted roles, and take care when exporting or sharing
site configuration.

## Next steps

Once enabled, connect the module to OpenAI — see
[Configuration](../configuration/index.md).

## Verify it worked

After enabling, confirm the module's settings form is reachable under
**Configuration**, and that (once your key is in place) a test feedback submission
is scored with a sentiment value.
