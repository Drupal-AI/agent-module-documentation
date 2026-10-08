# Configuration

Configuring Peytz Mail has two parts: **connecting to your Peytz Mail account** on
the settings form, and then **placing the newsletter signup block** where visitors
can use it.

## 1. Connect your Peytz Mail account

1. Log in as a user with permission to administer the module.
2. Go to **Configuration → Peytz Mail → Settings**
   (`/admin/config/peytz_mail/settings`).
3. Fill in the fields:
   - **Service URL protocol** — the protocol used to reach your Peytz Mail
     account. In most cases the **default** is correct.
   - **Service URL** — the path to your Peytz Mail account.
   - **Peytz Mail API key** — the API key from your Peytz Mail account, used to
     authenticate requests to the Peytz Mail API.
4. Click **Save**.

## 2. Place the newsletter signup block

Once the connection is configured, a **Peytz Mail signup block** becomes
available:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place the Peytz Mail signup block in the region where you want the signup form
   to appear.
3. In the block's configuration, choose which **newsletter list(s)** visitors may
   subscribe to.
4. Save the block and load a page to confirm the signup form renders and works.

> **Extending the form:** other modules can add extra fields to the signup form
> through a hook the module provides, if you need to collect more than the default
> fields.

## Keep the API key secret

The Peytz Mail API key is a **credential**. Although you enter it on the settings
form, treat the value as a secret and avoid committing it in exported
configuration:

1. Store the key in an environment variable — with DDEV, for example
   `ddev dotenv set .ddev/.env --peytz-mail-api-key=<value>` (keep `.ddev/.env`
   out of version control), then `ddev restart`.
2. Reference it from `settings.php` as a configuration override, for example:

   ```php
   $config['peytz_mail.settings']['api_key'] = getenv('PEYTZ_MAIL_API_KEY');
   ```

   (Adjust the config key to match the module's actual setting name.) This keeps
   the live key out of version control while still supplying it to the module.
