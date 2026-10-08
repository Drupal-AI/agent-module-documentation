# Configuration

Configuration is two parts: create one or more **profiles** (credentials +
region), then optionally tell specific AWS **services** which profile to use. Both
live at **Configuration → Web Services → Amazon Web Services**
(`/admin/config/services/aws`) and require the **Administer aws** permission
(`administer aws`), which you grant at **People → Permissions**.

## 1. Create an AWS profile

From the AWS overview page, add a profile. Its fields are:

- **Name / machine ID** — how you'll refer to this profile.
- **Default** — mark one profile as the default; it is used by any service that
  has no explicit override.
- **Region** — the AWS region, e.g. `us-east-1`.
- **Access key ID** and **Secret access key** — static credentials (optional; see
  the guidance below on avoiding these).
- **Role ARN** and **Role session name** — an IAM role to assume via STS. When a
  role ARN is set, the profile uses temporary credentials from that role.
- **Encryption profile** — an Encrypt module profile used to encrypt the stored
  secret access key at rest, or `_none` for no encryption.

## 2. Choose credentials safely

The module resolves credentials in this order, so pick the safest option your
environment allows:

1. **IAM role (recommended).** Set a **Role ARN** (and a session name). The site
   assumes the role via STS and uses short-lived temporary credentials, which are
   cached and refreshed automatically — no long-lived keys stored in Drupal.
2. **Environment / instance profile (also good).** Leave the access key, secret,
   and role ARN **blank**. The AWS SDK's default provider then supplies
   credentials from environment variables or an EC2/container instance profile.
   This keeps secrets out of Drupal entirely.
3. **Static access key + secret (least preferred).** If you must store a key and
   secret, set an **Encryption profile** first so the secret is encrypted at rest
   rather than saved as plaintext in config. Rotate these in the one profile
   without touching any consumer module.

Because AWS profiles are config entities, keys stored in them would travel in a
config export — another reason to prefer a role or the environment/instance
profile over static keys.

## 3. Assign profiles to services (optional)

The list of AWS **services** (S3, EC2, SQS, SNS, SES, DynamoDB, and the rest)
comes from the SDK itself. By default every service uses the **default** profile.
If a particular service should use a different profile — or a pinned API version —
add a **service override** from the same admin section, choosing the service, the
profile, and optionally the version.

## How other modules use it

Consumer code gets a ready client from the module's client factory, for example an
`S3Client` for the `s3` service. The factory resolves which profile to use
(explicit choice → per-service override → default), builds the SDK arguments from
that profile, and returns the client — so S3 filesystem modules, queue workers,
and custom integrations all share your central credentials. See the
[`agent/`](../agent/start.md) docs for the `aws.client_factory` service API.
