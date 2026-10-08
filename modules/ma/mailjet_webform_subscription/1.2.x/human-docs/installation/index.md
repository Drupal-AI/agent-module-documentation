# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Webform** module (`webform`) — the element is added inside webforms.
- The **Mailjet API** module (`mailjet_api`) — it provides the Mailjet
  credentials and the API wrapper this module uses to talk to Mailjet.
- A **Mailjet account** with an API key and secret, and at least one contact
  list to subscribe people to.

Both required modules are installed automatically by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/mailjet_webform_subscription -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and
Mailjet API and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mailjet_webform_subscription -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailjet_webform_subscription -y
```

This also enables Webform and Mailjet API if they aren't already on.

## Configure the Mailjet credentials first

This module has no settings form of its own — it reads your Mailjet key and
secret from the **Mailjet API** module. Set those first at
**Configuration → System → Mailjet → API** (`/admin/config/system/mailjet/api`)
before you build a subscription form.

## Verify it worked

Open any webform's **Build** tab (**Structure → Webforms → *(form)* → Build**)
and add an element. You should see a **Mailjet Subscription** element type in the
list. Add it (plus an Email element), point it at a contact list, save, and
submit the form as a test visitor — you should receive a confirmation email, and
clicking its link should add the address to your Mailjet list.
