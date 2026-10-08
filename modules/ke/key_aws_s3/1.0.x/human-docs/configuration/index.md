# Configuration

You configure Key AWS S3 entirely through the **Key** module's own key‑management
page. There is no separate settings form.

## Create an Amazon S3 key

1. Log in as a user with the **administer keys** permission (an administrator by
   default).
2. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
   **Add key**.
3. Give the key an **internal name** you'll recognise later.
4. For **Key type**, select **AWS S3**.
5. For **Key provider**, select **AWS Configuration**.
6. Enter both credential fields — the **access key** and the **secret key**. Both
   are required, so the key won't save unless both are filled in. (The fields render
   with autocomplete disabled to keep the secret from being remembered by the
   browser.)
7. **Save** the key.

Other modules that need S3 access can then select this key through a filtered
`key_select` element, so the credentials are shared from one place.

## Keep the secret safe

The S3 secret grants access to your bucket, so store it carefully:

- **Restrict `administer keys`** to trusted administrators only — that permission
  gates access to every key on the site.
- **Avoid committing secrets.** Where your workflow supports it, source secret
  values from the environment (for example a DDEV `.ddev/.env` variable) rather than
  typing a permanent secret into config that gets exported. Anyone who can export
  configuration can read a secret stored there.
- **Scope the IAM user/role** behind the credentials to the least privilege the
  integration needs (for example a single bucket), and **rotate** the credentials
  centrally through the Key module when required.
