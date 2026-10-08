# Installation

## Requirements

SMTP Authentication Support needs **Drupal 9.5, 10, or 11** and one PHP library,
which Composer pulls in automatically:

- **PHPMailer** (`phpmailer/phpmailer`, `^6.1.7`) — the mail-transport library
  the module uses to talk to your SMTP server.

The module has **no other Drupal module dependencies**. Optionally, the
[Mailsystem](https://www.drupal.org/project/mailsystem) module lets you use SMTP
for only some of your site's mail rather than all of it.

## Install with Composer

From the project root:

```bash
composer require drupal/smtp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the PHPMailer
library as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/smtp -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smtp -y
```

Once enabled, the settings page appears under **Configuration → System → SMTP
Authentication Support** (`/admin/config/system/smtp`).

## Keep your SMTP password out of version control

!!! warning "Never hard-code or commit the SMTP password"
    Do **not** paste your SMTP password into a settings file that is checked into
    Git, and do not commit it anywhere in your repository. Store the value in an
    **environment variable** instead and reference it from your site's
    configuration.

    With DDEV, save the secret with the built-in dotenv command (this writes to
    `.ddev/.env`, which must stay out of version control), then restart so DDEV
    loads it into the web container:

    ```bash
    ddev dotenv set .ddev/.env --smtp-password='<your-password>'
    ddev restart
    ```

    The flag `--smtp-password` becomes the environment variable `SMTP_PASSWORD`
    inside the container. Reference that variable from `settings.php` (for
    example with `getenv('SMTP_PASSWORD')`) rather than typing the password into
    committed config. Note that the module's settings form does store the value
    in Drupal configuration, so treat any exported config that contains it with
    the same care and keep it out of your repository.

## Verify it worked

Log in as an administrator and go to `/admin/config/system/smtp`. You should see
the **SMTP Authentication Support** page with its **SMTP server settings**
section:

![The SMTP Authentication Support settings page after installation](../images/settings.png)

If the page loads, the module is installed correctly. Next, fill in your server
details and send a test email from the [Configuration](../configuration/index.md)
page.
