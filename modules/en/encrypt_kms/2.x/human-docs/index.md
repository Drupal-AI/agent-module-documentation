# Encrypt: AWS KMS — manual setup guide

**Encrypt: AWS KMS** (`encrypt_kms`) adds **AWS Key Management Service** as an
encryption method for the [Encrypt](https://www.drupal.org/project/encrypt)
module. Instead of holding an encryption key on your own server, your site
delegates encrypt/decrypt operations to AWS KMS, so the key material never leaves
AWS. It depends on the **Encrypt** and **Key** modules and uses the AWS SDK for
PHP.

Why this matters: because the key stays in KMS, a database or filesystem
compromise on its own does not expose it — the site only ever holds
KMS‑encrypted data and needs valid AWS credentials to decrypt. That makes it a
robust way to encrypt data at rest with managed keys. The flip side is that all
of the security now rests on **two things you must lock down**: the AWS/IAM
credentials the site uses to call KMS, and the KMS key policy. Keep the
credentials out of plain configuration, scope the IAM user to the specific KMS
key and only the encrypt/decrypt actions, and make the key policy
least‑privilege.

This module has **no admin form of its own**. You configure it entirely through
the Encrypt and Key modules' own pages — you register a KMS key as a Key entity,
create an Encryption Profile that uses the "Amazon KMS" method, and provide your
AWS credentials. The AWS credentials can be supplied through Drupal
configuration, through `settings.php`, or picked up from the AWS environment
(IAM instance profile, environment variables, or `~/.aws/credentials`). See
[Installation](installation/index.md) for the requirements and
["How to use it"](#how-to-use-it) below for the setup flow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   AWS SDK / Encrypt / Key dependencies, and enable it.

There is **no dedicated configuration page** for this module — you set it up on
the Encrypt module's Key and Encryption Profile forms, described below.

## Where it lives in the admin menu

Everything is configured under the **Key** and **Encrypt** admin sections:

- **Configuration → System → Keys** (`/admin/config/system/keys`) — where you add
  the KMS key and, later, a KMS data key.
- **Configuration → System → Encryption profiles**
  (`/admin/config/system/encryption/profiles`) — where you create the profile
  that uses the Amazon KMS method.

## How to use it

The steps below follow the module's own getting-started guide. You need an AWS
account with a KMS key already provisioned and an IAM user allowed to encrypt and
decrypt with that key.

1. Make sure your account has the **Administer encrypt** permission.
2. **Add a Key** at *Configuration → System → Keys*: choose the **KMS Key** type
   and enter the **ARN** of your KMS key. The ARN is only an identifier, so it is
   fine to store it in the *Configuration* storage provider.
3. **Add an Encryption Profile** at *Configuration → System → Encryption
   profiles*: choose the **Amazon KMS** encryption method and the key you just
   created.
4. Supply your **AWS IAM credentials**. You can enter them on the Encrypt KMS
   settings, set them in `settings.php`
   (`$config['encrypt_kms.settings']['aws_key']` and `['aws_secret']`), or leave
   them unset so the AWS SDK falls back to an IAM instance profile, environment
   variables, or `~/.aws/credentials`.

At this point you can encrypt data with this profile. **For PII/PHI data, do the
extra envelope-encryption step:** install [Real
AES](https://www.drupal.org/project/real_aes), add a **KMS Data Key** (key type
"KMS Data Key", provider "AWS KMS", pointing at the profile above), then create a
second Encryption Profile using the **Authenticated AES** method with that data
key. This generates an AES key, encrypts it via KMS, and thereafter only the
encrypted key is ever sent to AWS — no PII leaves your site.

> **Secret handling.** Treat the AWS key and secret as secrets. Never commit them
> to version control. With DDEV, store them as environment variables
> (`ddev dotenv set .ddev/.env --aws-access-key-id=… --aws-secret-access-key=…`,
> then `ddev restart`) and reference them from `settings.php` via `getenv()`, or
> use the Key module's configuration-override capability. Scope the IAM user
> tightly to the one KMS key and only the encrypt/decrypt actions.
