# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11**
  (`core_version_requirement: ^10.2||^11`).
- Core's **User** module (always present).
- A working **outbound mail** setup — links are sent with the site's default mail
  system. Prefer a TLS‑secured transport (see the recommended companions below).

The module is **standalone**: it has no third‑party libraries, no JavaScript
requirement, and no contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/magic_login_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/magic_login_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en magic_login_link -y
```

That is all — the module requires **no configuration**. The *"Login with Magic
Link"* option is added to the login form immediately.

## Recommended companions

- **Symfony Mailer** — ensures links are delivered reliably over SMTP or an email
  API (SendGrid, Mailgun, etc.), and over TLS. You can customise the email look
  and feel using standard Drupal mail templates or a mailer module.
- **Flood Control** — the module already throttles requests (50/hour per IP,
  5/hour per user), but Flood Control provides a UI to manage login‑attempt limits
  globally.

## Verify it worked

Go to `/user/login`. You should see a **"Login with Magic Link"** section on the
form. Enter an email or username, click the button, and confirm a one‑time login
link arrives by email and signs you in. If no email arrives, check the site's mail
configuration (and consider Symfony Mailer for reliable delivery).
