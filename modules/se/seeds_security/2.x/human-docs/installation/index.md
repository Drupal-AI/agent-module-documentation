# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Contrib modules** it depends on and enables: Username Enumeration Prevention
  (`username_enumeration_prevention`), CAPTCHA (`captcha`), reCAPTCHA
  (`recaptcha`), Activities (`activities`), Password Policy (`password_policy`),
  Remove HTTP Headers (`remove_http_headers`), Security Kit (`seckit`), Session
  Limit (`session_limit`), Restrict IP (`restrict_ip`), and Email TFA
  (`email_tfa`). Composer installs these for you.

There are no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_security -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the bundled
security modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seeds_security -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_security -y
```

Enabling Seeds Security also enables all of the bundled security modules listed
above.

## Verify it worked

Check **Extend** (`/admin/modules`) to confirm the security modules are enabled.
Then, crucially, work through each one's own configuration — Seeds Security has no
settings page of its own, and several of the bundled modules (reCAPTCHA, Restrict
IP, Password Policy, Email TFA) do nothing until you configure them. Test each
control before relying on it in production.
