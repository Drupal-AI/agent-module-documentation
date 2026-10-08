# Key AWS S3 — manual setup guide

**Key AWS S3** (`key_aws_s3`) extends the
[Key](https://www.drupal.org/project/key) module with a key type built
specifically for **Amazon S3 credentials**. It captures the two values S3 access
needs — the **access key ID** and the **secret access key** — in a single managed
Key entity, so S3 filesystem, storage, or DAM modules can pull their credentials
from Key rather than from `settings.php` or hard‑coded config.

Concretely, it adds an **`amazon_s3_key`** multivalue key type with two required
fields (`aws_access_key_id` and `aws_secret_access_key`) and an **`aws_s3`** key
input that renders those fields with autocomplete switched off. Both fields are
required, so the key can't be saved half‑filled. The module makes **no AWS calls of
its own** and adds no routes — credentials are stored and read purely through the
Key module's storage, and access is gated by Key's **administer keys** permission.

Because it stores an S3 secret, treat the key as sensitive: keep it out of code and
plain config, and restrict who can manage keys. It supports Drupal 8.9 through 10
and depends on the Key module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it with
   the Key module.
2. [Configuration](configuration/index.md) — create an Amazon S3 key and keep the
   secret safe.

## Where it lives in the admin menu

Key AWS S3 has no page of its own. You create and manage S3 keys from the Key
module's **Manage keys** page at **Configuration → System → Keys**
(`/admin/config/system/keys`), which is the `entity.key.collection` route.

## How to reference the key in a form

Other modules select an S3 key with Key's `key_select` element, filtered to this
key type:

```php
$form['aws_s3_auth'] = [
  '#type' => 'key_select',
  '#title' => $this->t('AWS S3 Auth'),
  '#key_filters' => ['type' => 'amazon_s3_key'],
];
```
