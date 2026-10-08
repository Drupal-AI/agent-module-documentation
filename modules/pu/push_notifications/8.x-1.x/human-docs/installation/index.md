# Installation

> **Read this first.** This is an **alpha** release (`8.x-1.0-alpha2`) that
> **fatals on Drupal 11.4 and cannot be installed there.** A constraint validator
> in the module (`PushNotificationsTokenLanguageConstraintValidator::validate()`)
> keeps the old pre-Symfony-6 signature, which is incompatible with Symfony 7's
> `ChoiceValidator::validate(mixed $value, Constraint $constraint): void`. PHP
> rejects the override on class load, and enabling the module has been observed to
> break the site so thoroughly that `drush` would not run — recovery required
> removing the module from `core.extension` with a direct database edit. **Test on
> a disposable environment matching your exact Drupal/Symfony version before
> enabling this anywhere important.** If you are on Drupal 11.4+, do not enable it;
> consider a maintained alternative such as a module built on the current provider
> APIs (Apple's HTTP/2 token-based APNs and the current FCM API).

## Requirements

- **Drupal 9, 10, or 11** as declared (`core_version_requirement: ^9 || ^10 ||
  ^11`) — but see the fatal-on-11.4 warning above.
- The **Services** module (3.0) to register device tokens (the iOS "device token"
  and Android "registration id") over REST.
- Provider credentials for whichever service you use:
  - **APNS** — a staging and/or production certificate.
  - **GCM** — a GCM API key.
  - **C2DM** — a C2DM-enabled Google account.
- Optional: the **Rules**, **Views**, and **PrivateMSG** modules for the
  integrations described in [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/push_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/push_notifications -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Only after you have confirmed compatibility on a disposable environment:

```bash
drush en push_notifications -y
```

If enabling it breaks the site (a white screen and a broken `drush`), the module
likely hit the Symfony signature incompatibility described above; you will need to
remove it from the `core.extension` configuration to recover.

## Verify it worked

1. Confirm the site still loads and `drush status` runs after enabling — if not,
   see the warning above.
2. Open the module's settings under **Configuration** and confirm the form loads.
3. Register a test device token via the REST interface and confirm it is stored,
   then continue with [Configuration](../configuration/index.md).
