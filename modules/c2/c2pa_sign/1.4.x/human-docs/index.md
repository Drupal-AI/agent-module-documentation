# C2PA Sign — manual setup guide

**C2PA Sign** (`c2pa_sign`) attaches **C2PA content-provenance metadata** to
compatible media assets when they are uploaded and published. C2PA (Content
Provenance and Authenticity) is an open standard for recording where a piece of
media came from and how it was edited: the module signs a manifest and embeds it
in the asset, so that downstream consumers can verify the asset genuinely
originated from your site and has not been tampered with.

This is a security- and authenticity-*positive* feature — it helps prove your
media is real. The one thing you must get right is the **signing key**. C2PA
signing relies on a private key and certificate that assert the content came from
you; if that key leaks, someone else can forge provenance in your name. So it must
be stored securely — in a proper key store, an HSM, or an environment variable —
never committed to the codebase or exported configuration, and rotated per your
security policy.

C2PA Sign has no access-control role of its own and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — point the module at your signing
   certificate and key, and handle that key safely.

## Where it lives in the admin menu

Once enabled, C2PA Sign signs compatible media automatically as it is uploaded and
published. Its signing certificate and key are set up in the module's
configuration — see [Configuration](configuration/index.md) — where the emphasis
is on supplying the key securely rather than pasting it into stored config.
