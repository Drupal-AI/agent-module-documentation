# Configuration

There are two ways to give the module your OCI credentials: through the **admin UI**
(quick, convenient for local development) or through **`settings.php`** (recommended
for production, because the secret never touches the database). You can also
combine them — enter the non‑secret bucket details in the UI and keep the actual
keys in the environment.

## Open the settings page

1. Log in as a user with permission to administer the module.
2. Go to **Configuration → Media → OCI Object Storage File System**
   (`/admin/config/media/oci-osfs`).

## The settings

- **Credentials** — an **Access Key ID** and **Secret Access Key** (for the
  recommended S3‑compatible Customer Secret Keys method), or the fields for an OCI
  API key / instance‑principal setup. There is a checkbox, **"Use credentials from
  settings.php instead of form"** — tick it to read credentials from
  `settings.php`/the environment rather than storing them in the form.
- **Region**, **Namespace**, and **Bucket** — the OCI location and container your
  files live in.
- **Delivery method and cache settings** — how files are served (including
  presigned URLs) and the metadata cache TTL.
- The page gives **visual credential status feedback** so you can see at a glance
  whether the credentials it has are usable.

After saving, go to **Configuration → Media → … → Actions**
(`/admin/config/media/oci-osfs/actions`) and click **Validate Configuration** to
test the connection.

## Storing credentials securely (recommended)

The **Secret Access Key** (and any API‑key private material) is a credential.
**Never hard‑code it or commit it.** For production, keep it out of the database
entirely:

1. Store the secret as an environment variable. With DDEV, use the built‑in dotenv
   command so the value lives in `.ddev/.env` (kept out of version control), then
   restart so it's loaded into the web container:

   ```bash
   ddev dotenv set .ddev/.env --oci-secret-access-key=<value>
   ddev restart
   ```

   The flag `--oci-secret-access-key` becomes the variable
   `OCI_SECRET_ACCESS_KEY` inside the container. Confirm it arrived without
   printing it:

   ```bash
   ddev exec 'test -n "$OCI_SECRET_ACCESS_KEY"' && echo present
   ```

2. Reference it from `settings.php` (tick "Use credentials from settings.php" in
   the UI so the module reads from there), for example via `getenv()`. Where the
   module supports a [Key](https://www.drupal.org/project/key) entity, use the
   Key module's environment provider so the secret is referenced by name rather
   than pasted into a form.

3. Make sure your outbound firewall/egress rules allow the site to reach the OCI
   Object Storage endpoint for your region.

## Scope bucket permissions

On the OCI side, scope the bucket's access policy carefully. If you store
**private** files here, make sure the bucket (or the relevant prefix) is **not
world‑readable** — otherwise files you expect to be protected would be reachable by
anyone with the URL. Use presigned URLs for controlled public access rather than
opening the whole bucket.

## Optional: override public:// and private://

The module can optionally **replace the `public://` and `private://` stream
wrappers** so that existing file fields transparently store to OCI without code
changes. Enable this only when you're ready for all such files to live in the
cloud, and test on a copy first.

## Migrating existing files

Once configured and validated, use **Copy Local Files to OCI** on the Actions page
to batch‑migrate files already on local disk. It processes files in batches, skips
files that already exist in the bucket, lets you choose `public://`, `private://`,
or both, and shows real‑time progress.
