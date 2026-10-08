# Configuration

Amazon Cognito is configured in two places: the **AWS side** (your Cognito user
pool and app client) and the **Drupal side** (a settings block that tells Drupal
how to reach that pool). There is no admin settings form — the connection lives in
`settings.php`.

## 1. Create the user pool on AWS

In the AWS console, create a **Cognito user pool** using the **Email** sign-in
flow. Email is used as the unique identifier, and this choice **cannot be changed
after the pool is created**, so set it deliberately. Then create an **app client**
for Drupal and note down four values:

- the AWS **region** (for example `us-east-2`);
- the app client **access key** and **secret**;
- the **user pool ID** (for example `us-east-2_XXXXXXX`);
- the **app client ID**.

## 2. Add the connection block to settings.php

Add a `$settings['cognito']` array with those values:

```php
$settings['cognito'] = [
  'region' => 'us-east-2',
  'credentials' => [
    'key' => getenv('COGNITO_KEY'),
    'secret' => getenv('COGNITO_SECRET'),
  ],
  'user_pool_id' => 'us-east-2_XXXXXXX',
  'client_id' => getenv('COGNITO_CLIENT_ID'),
];
```

**Keep the secret out of version control.** Do not paste the raw access key,
secret, or client ID directly into a committed `settings.php`. Read them from
environment variables instead, as shown above.

> **Using DDEV?** Store each secret with DDEV's dotenv helper, for example
> `ddev dotenv set .ddev/.env --cognito-secret=<value>` (the flag becomes the
> `COGNITO_SECRET` environment variable), keep `.ddev/.env` out of version
> control, then `ddev restart` so the container picks it up. `getenv()` in
> `settings.php` then reads the value at runtime.

## 3. Account creation and role mapping

Because sign-in is delegated to Cognito, decide how Cognito identities become
Drupal accounts. Account linking follows the **External Authentication** model:
the first time a Cognito user authenticates, a local Drupal account is created (or
matched) for them.

Review this carefully — a permissive mapping can **over-grant access**. In
particular, do not automatically assign privileged roles to freshly created
accounts. Grant only the roles a newly federated user should have, and add
elevated roles deliberately afterwards.

## 4. Permissions and Drush

The module provides its own permissions on the standard **People → Permissions**
screen (`/admin/people/permissions`) and ships **Drush commands** for
Cognito-related operations — run `drush list --filter=cognito` to see what is
available in your installed version.

## Security checklist

- Serve the whole site (and the Cognito flows) over **HTTPS**.
- Store the client secret and AWS credentials as **environment-backed secrets**,
  never in exported configuration.
- Confirm Cognito tokens are being validated (signature, issuer, audience, and
  expiry) before they are trusted.
- Keep account creation and role mapping tight so federated users do not receive
  more access than intended.
