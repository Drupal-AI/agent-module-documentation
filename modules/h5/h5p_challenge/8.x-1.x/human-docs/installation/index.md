# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1** or newer (`php_requirement: 8.1`).
- The [H5P](https://www.drupal.org/project/h5p) module (`h5p:h5p`) enabled — this
  is a hard dependency, and H5P content is what challenges are built on.
- **Google reCAPTCHA** site and secret keys, since challenge creation is verified
  against reCAPTCHA.
- **Cron running hourly** — cron sends the "challenge ended" notifications and
  performs cleanup.
- *Optional:* the [Mail System](https://www.drupal.org/project/mailsystem) and
  [Mime Mail](https://www.drupal.org/project/mimemail) modules if you want
  attachment/richer emails; the REST submodule additionally needs core's **REST**
  module.

There are no third-party Composer library requirements beyond the above.

> **Note:** this module is **not covered by Drupal's security advisory policy**
> and is under active development. See the score-integrity note in the
> [main guide](../index.md) before using challenges for anything high-stakes.

## Install with Composer

From the project root:

```bash
composer require drupal/h5p_challenge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the H5P
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/h5p_challenge -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en h5p_challenge -y
```

## Submodules

- **`h5p_challenge_rest`** — an optional submodule that exposes read-only REST
  resources for challenge and points data (canonical URIs such as
  `api/h5p_challenge/challenge/{uuid}/results`, with pagination and from/until
  filtering). It requires core's **REST** module. Enable it only if you need to
  consume results from another application:

  ```bash
  drush en h5p_challenge_rest -y
  ```

## Verify it worked

1. Set your reCAPTCHA keys and other options — see
   [Configuration](../configuration/index.md).
2. Confirm cron is running hourly (`drush cron` to test manually).
3. On a piece of H5P content, start a challenge, and confirm the join code is
   generated and the creator receives an email.
4. Join with the code, play the content, and check the leaderboard at
   `/h5p_challenge/{challenge}/results`.
