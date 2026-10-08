# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`) — enabled on a standard Drupal install, and
  pulled in automatically as a dependency.
- No third‑party Composer packages or PHP libraries.
- A working **Discourse** instance you administer, from which you can create an API
  key (and, for the SSO features, configure connect/SSO).

> **Note on security coverage:** this module is *not* covered by the Drupal
> Security Team's advisory policy. That does not mean it is unsafe, but it does mean
> you take on responsibility for reviewing updates yourself — worth knowing before
> deploying it on a sensitive site.

## Install with Composer

From the project root:

```bash
composer require drupal/discourse_comments_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/discourse_comments_plus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en discourse_comments_plus -y
```

## Verify it worked

After enabling, open the settings form at
`/admin/config/discourse_comments/discourse_comments_settings` and confirm it
loads. Once you have entered your Discourse API credentials (see
[Configuration](../configuration/index.md)), publish a node with the "Publish to
Discourse" option and confirm a matching topic appears on your Discourse instance.
