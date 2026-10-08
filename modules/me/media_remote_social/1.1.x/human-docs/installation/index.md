# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`).
- The **Key** module (`key`) — used to store the Facebook/Instagram oEmbed access
  token securely. Composer pulls this in automatically with the command below.
- A valid Facebook/Instagram **oEmbed access token** from the provider(s) you want
  to embed.

## Install with Composer

From the project root:

```bash
composer require drupal/media_remote_social -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Key module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_remote_social -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_remote_social -y
```

Drupal will enable **Media** and **Key** at the same time if they are not already
on.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media`) and confirm a
**Remote social** media type is listed. Then store your access token as a Key at
**Configuration → System → Keys** and finish the setup described in
[How to use it](../index.md#how-to-use-it). Once the token key is in place, adding a
Facebook or Instagram post URL as a Remote social media item should produce a
working embed.
