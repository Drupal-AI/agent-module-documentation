# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3||^11`).
- The **Consumers** module (`consumers`) — required.
- The **Verification** module (`verification`) — required; Magic Code registers a
  verification provider on top of it.
- A working **outbound mail** setup, since codes are delivered by email. Configure
  your mailer (and prefer a TLS‑secured transport) before relying on the login
  flow.

Composer resolves the Consumers and Verification dependencies for you.

## Install with Composer

From the project root:

```bash
composer require drupal/magic_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Consumers and Verification.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/magic_code -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en magic_code -y
```

## Submodules — enable the flow you need

Magic Code ships two submodules that turn the code engine into usable flows:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Magic Code Email Login** | `magic_code_email_login` | Passwordless login: a user receives a magic code by email and uses it to sign in. |
| **Magic Code Verify Form** | `magic_code_verify_form` | A code‑entry form for verifying a user or a sensitive action. |

Enable whichever you need, for example:

```bash
drush en magic_code_email_login -y
```

## Verify it worked

After enabling the base module and a submodule, the corresponding flow becomes
available (for example the passwordless email‑login path from
`magic_code_email_login`). Send yourself a test code and confirm it arrives by
email and lets you complete the flow. Then review the code lifetime and flood
settings on the [Configuration](../configuration/index.md) page.
