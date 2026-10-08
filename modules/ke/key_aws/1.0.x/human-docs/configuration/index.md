# Configuration

You configure Key AWS entirely through the **Key** module's own key‑management page.
There is no separate Key AWS settings form.

## Create an AWS key (file provider — preferred)

1. Log in as a user with the **administer keys** permission (an administrator by
   default).
2. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
   **Add key**.
3. Give the key an **internal name** you'll recognise later (for example
   `aws_creds_key`).
4. For **Key type**, select **AWS**.
5. For **Key provider**, select **AWS Credentials**.
6. Specify the **path to your AWS credentials file** — the standard INI file the AWS
   CLI uses.
7. **Save** the key.

## Create an AWS key (config provider)

If you can't use a credentials file, use the configuration provider instead:

1. Add a new key as above, with **Key type** = **AWS**.
2. For **Key provider**, select **AWS Configuration**.
3. Enter the **access key** and **secret key** directly.
4. Save.

For S3 specifically, enable the **Key AWS S3** submodule and choose **Key type** =
**AWS S3** with **Key provider** = **AWS Configuration**.

## Keep the secret out of harm's way

AWS credentials grant real access to your cloud account, so how you store them
matters:

- **Prefer the file provider**, and keep the credentials file **outside the web
  root** so it can never be served over HTTP.
- **Avoid putting long‑lived secrets in exported configuration.** The AWS
  Configuration provider stores the keys in Drupal config — anyone who can export
  configuration can read them. Where possible, source the values from the
  environment (for example a DDEV `.ddev/.env` variable referenced from
  `settings.php`) rather than committing them.
- **Restrict `administer keys`** to trusted administrators only — that permission is
  what gates access to every key on the site.
- **Rotate credentials** centrally through the Key module when needed, and scope the
  AWS IAM user/role to the least privilege the integration requires.
