# Configuration

Configuring ConvertKit has three parts: grant the permission, store your API
credentials (safely), and then wire ConvertKit into a block or Webform.

## 1. Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant **administer
convertkit configuration** to the roles that should manage the integration
(typically administrators only, since it exposes API credentials).

## 2. Get your ConvertKit credentials

In ConvertKit's developer portal, create an app and note three values:

- the **API Key** (used by the module as `client_id`)
- the **API Secret** (used as `client_secret`)
- at least one **Tag ID** (`tag_ids`) — the tag applied when a visitor subscribes.

## 3. Store the credentials safely (recommended: settings.php + env var)

API keys are secrets — never hard‑code them in configuration you commit. The module
looks for its credentials in `settings.php` under `$settings['convertkit_esp']`,
which is the recommended place. Keep the actual values in an environment variable
and read them from there.

With DDEV, set the variable without committing it, then restart:

```bash
ddev dotenv set .ddev/.env --convertkit-api-key=YOUR_KEY \
  --convertkit-api-secret=YOUR_SECRET --convertkit-tag-id=YOUR_TAG_ID
ddev restart
```

(The flag `--convertkit-api-key` becomes the variable `CONVERTKIT_API_KEY`, and so
on. Keep `.ddev/.env` out of version control.)

Then, in `settings.php`, read those variables into the array the module expects:

```php
$settings['convertkit_esp'] = [
  'client_id' => getenv('CONVERTKIT_API_KEY'),
  'client_secret' => getenv('CONVERTKIT_API_SECRET'),
  'tag_ids' => getenv('CONVERTKIT_TAG_ID'),
];
```

> **Prefer this over the admin form.** You *can* type the same values into the
> settings form at **Configuration → Web services → ConvertKit**
> (`/admin/config/services/convertkit`) and click **Save**, in which case they are
> stored in the database. Keeping them in `settings.php` from an environment
> variable avoids committing secrets and keeps them out of exported configuration.

## 4. The settings form, field by field

At **Configuration → Web services → ConvertKit**
(`/admin/config/services/convertkit`):

- **API Key** — your ConvertKit API key (`client_id`). Leave blank if you set it in
  `settings.php`.
- **Secret key** — your ConvertKit API secret (`client_secret`). Leave blank if set
  in `settings.php`.
- **Tag ID(s)** — one or more ConvertKit tag IDs (`tag_ids`) applied on
  subscription.

Click **Save configuration**.

> **Leave debug logging off.** The module's optional debug logging references an
> undefined `Logger` class, so enabling it can trigger a fatal error. Do not turn
> it on unless that has been resolved.

## 5. Connect ConvertKit to your site

Once credentials are in place:

- **Blocks** — at **Structure → Block layout**, place the **ConvertKit Subscription
  Signup Form** block (or the multi‑form block) and configure its options.
- **Webform handler** — at **Structure → Webforms** (`/admin/structure/webform`),
  edit a Webform, open the **Emails / Handlers** tab, **Add handler**, and choose
  **Convertkit**. Fill in the form. You need at least one tag ID in your ConvertKit
  account, at least one tag ID configured here, and a tag‑ID field in the Webform.
- **Field** — add the ConvertKit field to a content type to let authors select a
  form per node.

## Egress caveat

This module makes outbound HTTPS calls to `https://api.convertkit.com/`, sending
the API key/secret with each request. Make sure your environment permits that
outbound connection, and be aware that subscriber email addresses submitted through
forms are transmitted to ConvertKit — a third‑party service not affiliated with or
funded by this project.
