# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Social Auth** module (`drupal/social_auth`, `^4.1`) and, through it, the
  Social API framework. Composer pulls these in as dependencies.
- The **`league/oauth2-linkedin`** OAuth2 provider library (`^5.0`) — installed
  automatically by Composer.
- A **LinkedIn app** you can create in the LinkedIn Developer portal (a LinkedIn
  Company Page is required to create one).

## Install with Composer

Install with Composer so the required PHP library and the Social Auth dependency
come along:

```bash
composer require drupal/social_auth_linkedin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`drupal/social_auth` and `league/oauth2-linkedin` and update any shared
dependencies as needed. Installing this module by copying files alone will not
work — the `league/oauth2-linkedin` library must be present via Composer.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/social_auth_linkedin -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_linkedin -y
```

This also enables Social Auth if it wasn't already on. Next, set up your LinkedIn
app and enter the credentials — continue to
[Configuration](../configuration/index.md).

## Keep the client secret out of version control

Your LinkedIn **Client Secret** is sensitive. Rather than committing it in
exported configuration, store it in an environment variable and override the
config per environment. With DDEV you can save it into the container's dotenv
file:

```bash
ddev dotenv set .ddev/.env --linkedin-client-secret='<your-client-secret>'
ddev restart
```

Then reference it from `settings.php` (see the Configuration page for the exact
override lines). Never hard-code or commit the secret.
