# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- The **CAPTCHA** module (`captcha`) — strongly recommended and, for any real
  protection, **required**. Captcha Keypad does not declare CAPTCHA as a hard
  dependency (it has a standalone fallback mode), but that fallback is insecure, so
  you should always install and enable the CAPTCHA module alongside it.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/captcha_keypad -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Install the CAPTCHA module at the same time if it is not
already present:

```bash
composer require drupal/captcha -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/captcha_keypad -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable both modules together so the keypad runs in its secure, CAPTCHA-driven mode:

```bash
drush en captcha captcha_keypad -y
```

## Verify it worked

Log in as an administrator, open the CAPTCHA module's administration pages, and
assign the **Captcha Keypad** challenge type to a test form (for example the user
registration form). Load that form as an anonymous user and confirm the keypad
appears and that clicking the shown code passes. Keep the code size at a normal
value — never 99 — and never run the module without the CAPTCHA module enabled.
