# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Configurable Anonymizer** module (`configurable_anonymizer`) — this add-on
  extends it.
- The **OIDC** module (`oidc`) — provides the OpenID Connect realms this module
  filters on.
- **Drush**, since the underlying anonymization is run through a Drush command.

There are no third‑party PHP library requirements. This is the 1.0.0 release and is
not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/configurable_anonymizer_oidc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Configurable
Anonymizer and OIDC dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/configurable_anonymizer_oidc -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure Configurable Anonymizer and OIDC are enabled first, then:

```bash
drush en configurable_anonymizer_oidc -y
```

## Verify it worked

Select an OIDC realm to exclude from anonymization, then run the anonymizer
(`drush anonymizer:run`) on a **copied** database and confirm that users in the
excluded realm keep their data while other configured PII is anonymized. Remember that
excluding a realm retains real personal data, so only do so where it is intended and
compliant — and never run the anonymizer against production.
