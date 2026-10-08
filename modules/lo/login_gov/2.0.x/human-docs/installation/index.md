# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **OpenID Connect** module, **version 3.0 or later** (`openid_connect >= 3.0`).
  The required patch is included from the `3.0.0-alpha3` release onward, so no
  manual patching of OpenID Connect is needed.
- **Asymmetric Keys** module, version 1.2.0 or later (`key_asymmetric >= 1.2.0`) —
  this provides the private/public key handling that Login.gov's private‑key JWT
  authentication depends on. It in turn works with the **Key** module for storing
  key material.
- A **Login.gov sandbox account** to develop against. See Login.gov's "Getting
  Started" documentation.

## Install with Composer

Installing the module with Composer pulls in its dependencies. From the project
root:

```bash
composer require drupal/login_gov -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_gov -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en login_gov openid_connect key_asymmetric -y
```

(If the **Key** module isn't already enabled, enable it too — it is what stores the
signing key securely: `drush en key -y`.)

## Verify it worked

Go to **Configuration → People → OpenID Connect**
(`/admin/config/services/openid-connect`). Login.gov should be available as a
client type you can enable and configure. Full setup — generating the signing key,
registering it with Login.gov, and entering the client details — is covered in
[Configuration](../configuration/index.md).
