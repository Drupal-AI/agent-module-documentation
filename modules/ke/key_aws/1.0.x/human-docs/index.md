# Key AWS — manual setup guide

**Key AWS** (`key_aws`) extends the [Key](https://www.drupal.org/project/key)
module so you can store **AWS authentication credentials** — your access key ID and
secret — as a managed Key entity instead of hard‑coding them in `settings.php` or
scattering them through code. Other AWS‑integrating modules (or your own custom
code) then retrieve those credentials through the standard Key repository.

It adds an **`aws` key type** and two ways to supply the credentials:

- **AWS Credentials** (`aws_file`) — the preferred method. You point it at the path
  of a standard AWS credentials INI file (the same format the AWS CLI uses), ideally
  stored **outside the web root**. This extends core Key's file provider.
- **AWS Configuration** (`aws_config`) — stores the access and secret keys directly
  in Drupal configuration. Simpler, but the values live in config, so use it only
  where that trade‑off is acceptable.

The module also provides an `AWSKeyRepository` service so AWS SDK code can fetch the
credentials programmatically. Access to the credentials is governed entirely by the
Key module's **administer keys** permission — Key AWS adds no routes or screens of
its own; you manage everything from Key's own **Keys** page. A bundled submodule,
**Key AWS S3**, adds an S3‑specific multivalue key type. It supports Drupal 8.9
through 10 and depends on the Key module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it with
   the Key module.
2. [Configuration](configuration/index.md) — create an AWS key and choose a
   provider, with an emphasis on keeping the secret safe.

## Where it lives in the admin menu

Key AWS has no page of its own. You manage AWS keys from the Key module's **Manage
keys** page at **Configuration → System → Keys**
(`/admin/config/system/keys`), which is the `entity.key.collection` route.

## How to retrieve the credentials in code

Inject or fetch the repository service and read the credentials:

```php
$repo = \Drupal::service('key_aws.repository');
$repo->setKey('aws_creds_key');       // the internal name of your Key
$credentials = $repo->getCredentials();
$accessKey = $repo->getAccessKey();
$secretKey = $repo->getSecretKey();
```
