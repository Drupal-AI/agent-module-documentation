# File encrypt — manual setup guide

**File encrypt** (`file_encrypt`) stores uploaded files **encrypted on disk** and
decrypts them automatically as they are served to users who are allowed to have
them. Drupal's private filesystem controls *who may download* a file, but it does
nothing about what the bytes look like at rest — anyone with filesystem access (a
backup, a snapshot, a shared host, a misconfigured sync, a stolen disk) can read
them directly. For most content that is fine; for medical records, identity
documents, signed contracts, or anything you have promised to encrypt at rest, it
is not. File encrypt closes that gap.

It works through a custom `encrypt://` stream wrapper: files written there are
encrypted on the way in and decrypted on the way out. Key management is delegated
to the **Encrypt** and **Key** modules, so the encryption key comes from a Key
entity and can live in an environment variable or a KMS rather than in the
database. You turn encryption on per field, by choosing "Encrypted files" as a
field's upload destination — existing fields and content types don't need to
change shape.

Three things are worth understanding up front. **This version is an alpha**
(`2.0.0-alpha1`) for a component whose failure mode is *unreadable files*, so test
it thoroughly before trusting production data to it. **Key loss is data loss** —
there is no recovery path, so plan key backup and rotation *before* your first
upload. And **encryption is not access control**: it protects the bytes at rest,
but who may request a file is still decided by Drupal's normal file-access
(`hook_file_download()`) machinery, exactly as with private files. Encouragingly,
the module's download controllers extend core's own, so access is delegated
through the same chain and the image-style controller keeps core's path-traversal
and derivative-token guards rather than reimplementing them.

It requires the **Encrypt** module and core **File**, and targets Drupal 10.3 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Encrypt/Key
   dependencies with Composer, and enable them.
2. [Configuration](configuration/index.md) — set the encrypted-file path, create a
   key and an encryption profile, and turn on encryption per field.
