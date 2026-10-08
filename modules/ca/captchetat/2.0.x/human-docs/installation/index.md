# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **CAPTCHA** module (`captcha`) — required for this 2.x release, which
  integrates CaptchEtat as a CAPTCHA challenge type.
- A **secret key** and a **client key** from **Piste Gouv**, plus any authorization
  your organization needs to use the service.

There are no additional PHP or third-party library requirements. Challenge
generation and verification depend on the external CaptchEtat service, so the site
must be able to reach it.

## Install with Composer

From the project root:

```bash
composer require drupal/captchetat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The CAPTCHA module is pulled in as a dependency if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/captchetat -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en captcha captchetat -y
```

## Verify it worked

Enter your CaptchEtat credentials on the settings form (see
[Configuration](../configuration/index.md)), then assign the CaptchEtat challenge to
a test form from the CAPTCHA administration pages. Load that form as an anonymous
user and confirm the CaptchEtat challenge appears and validates.
