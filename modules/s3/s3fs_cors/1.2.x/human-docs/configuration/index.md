# Configuration

Setting up direct uploads has two parts: the **CORS admin form** (which also
configures your bucket at AWS) and switching the **field widgets** to the direct‑upload
variants.

## Prerequisite

S3 File System (`s3fs`) must already be configured and working — bucket, region, and
credentials. This module reuses all of that and only adds the CORS‑specific settings.

## The CORS Upload admin form

1. Log in as a user with the **administer s3fs CORS** permission.
2. Go to **Configuration → Media → S3 File System → CORS Upload**, or navigate
   directly to `/admin/config/media/s3fs/cors`.

The form has four settings:

- **Allowed origin** — the origin(s) the browser is permitted to upload from. You can
  list several separated by commas or spaces, and you may use a single `*` wildcard
  (for example `*.example.com` to cover all your subdomains). Leaving this empty
  removes the bucket's CORS configuration entirely (see the AWS note below).
- **Use HTTPS** — whether the direct‑upload POST endpoint uses `https` or `http`. Use
  HTTPS in production.
- **Access type (ACL)** — whether uploaded objects are **public‑read** (anyone with
  the URL can fetch the file) or **private**. Choose **private** for anything
  sensitive; public‑read makes the object publicly downloadable.
- **STS policy resource** — the AWS resource ARN used when the module has to fall back
  to short‑lived STS federation credentials (that is, when no static access keys are
  available to sign the upload). Leave it blank if you use static keys.

> **This form changes your S3 bucket directly.** When you save with an origin set,
> the module calls AWS to write CORS rules on the bucket that allow POST uploads from
> your origin(s). If you clear the origin and save, it removes the bucket's CORS
> configuration. So saving here is not just a local Drupal setting — it mutates the
> real bucket at AWS. The credentials that do this come from your `s3fs` configuration.

Click **Save configuration**.

## Put the direct‑upload widget on your fields

The admin form enables the feature; you still have to tell individual fields to use
it.

1. Go to the entity's **Manage form display** (for example
   *Structure → Content types → Article → Manage form display*).
2. Find your **file** or **image** field and change its **Widget** to the S3 CORS
   variant:
   - **S3 CORS file widget** for file fields.
   - **S3 CORS image widget** for image fields.
3. Open the widget's settings (the gear icon) to set the **maximum file size** the
   widget enforces before upload, alongside the field's normal allowed extensions.
4. **Save** the form display.

Both widgets support multi‑value fields and work inside inline/nested entity forms.

## How the upload location is decided

You don't set the S3 path here — it's derived from the field's **upload destination**.
An `s3://…` destination maps straight onto the bucket; `public://` and `private://`
destinations map to the public and private folders you configured in `s3fs`, and any
`s3fs` root‑folder prefix is prepended. If a file with the same name already exists,
the object key is deduplicated (renamed) automatically.

## ACL and credentials recap

- Uploaded objects receive the **Access type (ACL)** you chose above. Prefer
  **private** unless the files are genuinely meant to be world‑readable by URL.
- Signing the upload uses the credentials from your `s3fs` settings (or the default
  AWS provider chain). When no static keys or session token are available, the module
  requests a short‑lived STS federation session scoped to the **STS policy resource**
  you set.
