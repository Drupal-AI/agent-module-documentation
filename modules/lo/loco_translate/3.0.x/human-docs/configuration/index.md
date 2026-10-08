# Configuration

## Add your Loco API keys

Loco Translate authenticates with two keys from your Loco project:

- a **read-only key** (used for exports/pulls), and
- a **full-access key** (used for pushes that create translation keys).

The project's documented approach is to set these in your environment's
`settings.php`:

```php
// Loco Translate export (read-only) key.
$config['loco_translate.settings']['api']['readonly_key'] = 'YOUR-KEY-HERE';

// Loco Translate full-access key.
$config['loco_translate.settings']['api']['fullaccess_key'] = 'YOUR-KEY-HERE';
```

## Keep the keys out of committed code

Even though the keys live under `$config` in `settings.php`, **treat them as
secrets** — don't hard-code them into a file you commit, and don't let them into
exported configuration. Read them from the environment instead.

> **With DDEV**, store each key as an environment variable and reference it:
>
> ```bash
> ddev dotenv set .ddev/.env --loco-readonly-key=<value> --loco-fullaccess-key=<value>
> ddev restart
> ```
>
> Keep `.ddev/.env` out of version control. Then in `settings.php`:
>
> ```php
> $config['loco_translate.settings']['api']['readonly_key'] = getenv('LOCO_READONLY_KEY');
> $config['loco_translate.settings']['api']['fullaccess_key'] = getenv('LOCO_FULLACCESS_KEY');
> ```

Where you prefer a managed **Key** entity, store the value there and reference it,
so the secret never sits in plaintext config. Whichever method you choose, make
sure the Loco API is reached over **HTTPS**.

## The push/pull workflow

The module ships Drush commands to move translations between Drupal and Loco:

- **Push** — create new translation keys (assets) in Loco from a reference `.po`
  file in your Drupal or local environment:

  ```bash
  drush loco:push --language="fr" ./translations/fr.po
  ```

- **Pull** — fetch keys and translations from Loco into Drupal:

  ```bash
  drush loco:pull fr
  ```

The **dashboard** gives you an overview of translation progress on the Loco side.

## Known issue — download destination

If a pull fails with *"Download error. Could not move downloaded file from Loco to
destination translations://."*, set the translations path in `settings.php`,
adjusting the path to your environment:

```php
$config['locale.settings']['translation']['path'] = '/var/www/web/sites/default/files/translations';
```

## Data note

Loco Translate handles **interface strings**, which are typically not sensitive
content, but the API keys themselves are sensitive — protect them as described
above.
