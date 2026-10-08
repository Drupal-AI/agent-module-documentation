# Firebase PHP — manual setup guide

**Firebase PHP** (`firebase_php`) integrates the **Firebase Admin SDK for PHP**
(the `kreait/firebase-php` library) and exposes it to Drupal as a service. It adds
no end-user features on its own — instead it gives other modules and custom code a
ready-configured Firebase client they can inject to use Firebase capabilities:
Cloud Messaging (push notifications), Authentication, Firestore, and the Realtime
Database. It is, in short, a foundation you build on.

This is a **developer-only** module. Enabling it does nothing visible until you (or
another module) write code that uses the service. Major versions of the module
track major versions of `kreait/firebase-php` — the `8.0.x` branch here targets
version 8 of that library.

The one thing every site using it must handle carefully is the **Firebase
service-account credential**. This is a highly privileged key: the Admin SDK
bypasses Firebase's own security rules, so anything holding this credential has
broad access to your Firebase project. Store it as a secret, never commit it, and
restrict which code can use the service (see [Installation](installation/index.md)
for how to handle the credential safely with DDEV and the Key module).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (which brings in the
   `kreait/firebase-php` library) with Composer, enable it, and provide the
   Firebase service-account credential securely.

Firebase PHP is a library wrapper for developers — this guide does not include a
separate configuration walkthrough beyond supplying the credential, which is
covered in Installation.

## How to use it

Because this module only exposes a service, using it means writing code: inject the
Firebase service into your own module or custom code and call the SDK to send
messages, verify auth, or read/write Firestore. A common companion is the **Push
Notifications Registration Tokens** module for storing device tokens. The Firebase
project's own configuration and the credential's scope determine what the SDK can
actually do.
