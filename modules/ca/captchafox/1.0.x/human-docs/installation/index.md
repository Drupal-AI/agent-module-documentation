# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **CAPTCHA** module (`captcha`) — required; this module extends it.
- A **CaptchaFox account**, so you can obtain a **site key** and a **secret key**.

There are no additional PHP or third-party library requirements. Note that the
server-side verification step makes an outbound HTTPS request to
`https://api.captchafox.com/siteverify`, so the site must be able to reach that host.

## Install with Composer

From the project root:

```bash
composer require drupal/captchafox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The CAPTCHA module is pulled in as a dependency if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/captchafox -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en captcha captchafox -y
```

## Verify it worked

Create a CaptchaFox account and get your site and secret keys, enter them on the
CaptchaFox settings tab (see [Configuration](../configuration/index.md)), then assign
the CaptchaFox challenge to a test form from the CAPTCHA administration page. Load
that form as an anonymous user and confirm the CaptchaFox challenge appears and that
a successful challenge lets the form submit.
