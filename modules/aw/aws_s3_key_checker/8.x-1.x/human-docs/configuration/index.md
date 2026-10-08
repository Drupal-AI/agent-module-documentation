# Configuration

Both screens require the core **Administer site configuration** permission, so only
administrators can use the tool.

## Step 1 — Supply AWS credentials (securely)

The module deliberately does **not** store AWS keys in Drupal configuration. You
have two options:

- **IAM instance role (preferred on AWS).** Tick **Use IAM credentials** on the
  settings form and the module uses the role attached to the instance — no keys to
  manage at all.
- **Keys in `settings.php`.** Add them to your site's `settings.php`:

  ```php
  $settings['aws_s3_key_checker.access_key'] = getenv('AWS_ACCESS_KEY_ID');
  $settings['aws_s3_key_checker.secret_key'] = getenv('AWS_SECRET_ACCESS_KEY');
  ```

  Reading from `getenv()` keeps the actual secret in an environment variable rather
  than in a committed file. With DDEV you can set those variables with
  `ddev dotenv set .ddev/.env --aws-access-key-id=<value>` (and the secret key),
  then `ddev restart`; keep `.ddev/.env` out of version control.

The settings form's submit handler will error out if neither IAM nor `settings.php`
credentials are available.

## Step 2 — Register buckets

Open the **settings** form at `/admin/config/aws/s3/key-checker`:

- **Use IAM credentials** — the checkbox described above.
- **Buckets** — a newline‑separated list of bucket names. These are stored in the
  `aws_s3_key_checker.settings` config object (only the bucket names — no
  credentials).

## Step 3 — Run a check

Open the **check** form at `/admin/config/aws/s3/key-checker/check`:

1. Choose one of your configured buckets.
2. Paste the list of object keys to test, with an optional common **prefix** (a
   path prepended to every key) and/or **suffix** (for example a file extension).
3. Submit. The module issues an S3 `headObject` request for each key — a read‑only
   existence check, no downloads — and reports which keys are **present** and which
   are **missing**.
