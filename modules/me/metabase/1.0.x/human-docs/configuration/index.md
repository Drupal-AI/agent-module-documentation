# Configuration

Setting up Metabase Integration has two parts: telling Drupal how to reach your
Metabase server (done in `settings.php`), then placing a dashboard block and
choosing which dashboard it shows.

## 1. Add the connection settings

The module reads its server URL and signing secret from Drupal settings rather than
from a form, which keeps the secret out of exported configuration. Add these two
values to your `settings.php`:

```php
$settings['metabase.site_url'] = 'https://metabase.example.com';
$settings['metabase.secret_key'] = 'your-secret-key';
```

- **`metabase.site_url`** — the base URL of your Metabase instance.
- **`metabase.secret_key`** — the embedding secret key from Metabase. This is a
  **secret**: it signs the embed tokens, so anyone holding it can forge dashboard
  access. Do not commit it to Git.

### Keep the secret out of version control

Prefer supplying the secret through an environment variable rather than writing the
literal value into `settings.php`. With DDEV:

```bash
ddev dotenv set .ddev/.env --metabase-secret-key=<value>
ddev restart
```

Then in `settings.php`:

```php
$settings['metabase.secret_key'] = getenv('METABASE_SECRET_KEY');
```

Never commit `.ddev/.env`. Serve the site over HTTPS so the embed is not exposed in
transit.

## 2. Place a Metabase Dashboard block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Choose a region and click **Place block**, then add a **Metabase Dashboard**
   block.
3. Configure the block with the dashboard's settings (for example the dashboard ID
   and any parameters), and set the usual block visibility/role restrictions.
4. Save the block.

Because the embed is signed with your secret key, keep blocks pointed at dashboards
that are appropriate for the audience of the region — and use the block's role
visibility settings to gate sensitive reporting to the right users.

## Save

Once the settings are in place and the block is saved, load a page in that region
and the Metabase dashboard should render inline.
