# Configuration

Next.js Tag Revalidator does not add a standalone settings page. Instead, it adds a
**revalidator plugin** that you attach to a **Next.js site** entity (provided by
the Next.js module). Configuration is therefore done on that site entity.

## Attach the revalidator to a Next.js site

1. Log in as an administrator.
2. Go to **Configuration → Web Services → Next.js sites**.
3. Click **Edit** on the Next.js site you want to keep in sync.
4. Click **Add revalidator** and select **Next.js Cache Tag**.
5. Choose which cache tags to revalidate:
   - **Individual entity tags** — e.g. `node:123`.
   - **Entity list tags** — e.g. `node_list:article` or `taxonomy_list:categories`.
   - **Custom additional tags** — any extra tags you define.
   The form shows context‑aware examples based on your content types to help you
   pick the right ones.
6. **Save** the Next.js site.

Once saved, whenever tracked content changes in Drupal, the module sends a separate
revalidation request per cache tag to your Next.js site's revalidation endpoint.

## Tag your Next.js pages

For revalidation to have any effect, your Next.js pages/components must be fetched
with the matching cache tags, for example:

```js
// Individual entity
await fetch(`${drupalUrl}/jsonapi/node/article/${id}`, { next: { tags: [`node:${id}`] } });

// Entity list
await fetch(`${drupalUrl}/jsonapi/node/article`, { next: { tags: ['node_list:article'] } });
```

## The shared secret and where it lives

The Next.js site's revalidation endpoint is protected by a **shared secret**
(the revalidate secret configured on the Next.js site entity and matched by your
Next.js app's environment). This module calls that endpoint using the site's
configured base URL and secret — it does not manage the secret separately.

Treat that secret as sensitive: **never** commit it to version control or paste it
into exported configuration. Store it in an environment variable and reference it
through Drupal (and set the same value in your Next.js app's environment).

1. **Store the value in a DDEV environment variable** (do not commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --next-revalidate-secret=<value>
   ddev restart
   ```

   The flag `--next-revalidate-secret` becomes the variable
   `NEXT_REVALIDATE_SECRET`.

2. **Confirm it is present in the container without printing it:**

   ```bash
   ddev exec 'test -n "$NEXT_REVALIDATE_SECRET"'   # exit status 0 means set
   ```

3. **Expose it to Drupal** — where the Next.js site configuration accepts a Key
   reference, install the Key module
   (`ddev composer require drupal/key && ddev drush en key -y`) and create a Key
   with the built‑in environment provider:

   ```bash
   ddev drush key:save next_revalidate_secret --label='Next.js revalidate secret' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"NEXT_REVALIDATE_SECRET","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   Otherwise reference the variable from settings.php via
   `getenv('NEXT_REVALIDATE_SECRET')`.

## Egress note

This module makes **outbound HTTPS requests** to your Next.js application's
revalidation webhook (one per cache tag). Ensure your environment allows outbound
HTTPS to your Next.js host, and always serve that endpoint over HTTPS so the shared
secret is not sent in the clear.
