# Configuration

Acquia Web Governance needs two things set up before it is useful: a **connection to
your Acquia Web Governance account** (via an API key) and the **permissions** that
decide who may scan and who may change the connection.

## Open the settings form

1. Log in as a user with the **Administer Acquia Optimize** permission (see below).
2. Go to the module's settings form (`acquia_optimize.admin_settings`) under
   Drupal's configuration.

## Connect your account (the API key)

The settings form has a field for your **Acquia Web Governance API key**. Paste in
the key from your Acquia Web Governance account and save — this is what links the
Drupal site to the governance platform so scan results can flow back in.

The form **masks the key** on screen and keeps the stored value if you resubmit the
form without retyping it, so you will not accidentally blank it out. That masking is
a convenience, not a security boundary — see the warning below.

### Keep the key out of exported configuration

The API key is saved into `acquia_optimize.settings`, which means it travels with
any configuration export, into the repository and into database dumps. The module
does **not** support a Key entity. The safer pattern:

1. Put the key in an **environment variable** on your hosting (or in your local
   `.env`).
2. Reference it from `settings.php` with a config override, for example:

   ```php
   $config['acquia_optimize.settings']['api_key'] = getenv('ACQUIA_OPTIMIZE_API_KEY');
   ```

That way the live site has a working key while your exported configuration carries
nothing secret.

## Set the two permissions

At **People → Permissions** (`/admin/people/permissions`), assign the module's two
permissions to the right roles:

- **Scan Acquia Optimize** — lets a user trigger scans. This one is
  **access-restricted** for a reason: scans consume time and vendor quota, so grant
  it only to roles that should be spending that quota (editors who need on-demand
  page checks, for instance).
- **Administer Acquia Optimize** — lets a user reach the connection settings and the
  API key. Keep this to trusted administrators.

Separating the two means you can let editors run and read scans without also handing
them the credentials.

## Using it once connected

With the account connected and permissions set, the platform crawls the site and
findings appear in Drupal:

- **On the node edit form** — editors see the page's readability score and SEO
  issues while editing, before they publish.
- **Quick scan** — check a single page on demand rather than waiting for the next
  full crawl.
- **Dashboard / preview** — review site-wide governance status and preview how a
  page scores.
