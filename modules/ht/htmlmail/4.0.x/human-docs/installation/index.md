# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The contrib **Mail System** module (`drupal/mailsystem:^4.2`), which Composer
  pulls in and which HTML Mail depends on to route mail.
- **Optional but useful** third‑party pieces, each installed with Composer only if
  you want the feature:
  - `drupal/emogrifier` — inline CSS as a post‑filter for consistent webmail/mobile
    display.
  - `drupal/pathologic` — rewrite relative URLs to absolute as a post‑filter.
  - `drupal/echo` — render the body as a fully themed webpage using the selected
    theme.
  - `pear/mail_mime` — the PEAR `Mail_mime` class for MIME assembly with
    attachments.

## Install with Composer

From the project root:

```bash
composer require drupal/htmlmail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Mail System module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/htmlmail -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en htmlmail -y
```

On install, HTML Mail registers itself as the default mail formatter and sender in
Mail System, so outgoing mail begins flowing through the HTML mailer immediately.

## Route specific modules through HTML Mail

To send only certain modules' mail as HTML (and leave others plain), go to
**Configuration → System → Mail System** (`/admin/config/system/mailsystem`) and
set the formatter/sender per module there. This routing lives in the Mail System
module, not in HTML Mail.

## A note on permissions

HTML Mail adds a **Choose plaintext email** permission (`choose htmlmail_plaintext`).
Grant it to any role whose users should be able to opt out of HTML and receive
plaintext‑only mail via a checkbox on their account form.

This module has no submodules.
