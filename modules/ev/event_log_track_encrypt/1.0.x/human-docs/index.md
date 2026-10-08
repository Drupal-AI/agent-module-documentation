# Event Log Track Encrypt — manual setup guide

**Event Log Track Encrypt** (`event_log_track_encrypt`) adds **encrypted logs** to the
[Events Log Track](https://www.drupal.org/project/events_log_track) (ELT) module. ELT
records create/update/delete activity across your site, and some of those log entries
can contain sensitive data — for example the description of a configuration change
that includes credentials. This module encrypts that sensitive part so it is
protected at rest in the database, without losing the log itself.

It uses **public-key cryptography**: the log data is encrypted with a *public* key
before it is written to the ELT log, and only whoever holds the matching *private*
key can decrypt it later. Only the **description** portion of an ELT log entry is
encrypted. Decryption is done through Drush commands the module provides — there is no
graphical decryption interface.

The module builds on Drupal's [Encrypt](https://www.drupal.org/project/encrypt) and
[Key](https://www.drupal.org/project/key) framework and requires Events Log Track,
Encrypt, and Key to be present.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it alongside Events Log Track, Encrypt, and Key.

This module has **no settings form of its own**. You configure it through the Key
module and the Events Log Track settings form, described in "Set it up" below.

## Where it lives in the admin menu

There is no dedicated admin page for this module. Configuration happens in two
existing places:

- **Configuration → System → Keys** (`/admin/config/system/keys`) — where you paste in
  your public key.
- **Configuration → System → Event log track** (`/admin/config/system/events-log-track`)
  — where you turn encryption on and choose which event types to encrypt.

## Set it up

After installing and enabling the module:

1. **Generate a public/private key pair.** See the module's README for the key
   generation details. Keep the private key safe and offline — it is the only thing
   that can decrypt your logs.
2. **Configure the public key.** Go to **Configuration → System → Keys**, edit the key
   named **Event log track public key**, confirm the warning, and paste your **public**
   key into the *Key value* field. Save. (Double-check you are pasting the *public*
   key, never the private one.)
3. **Enable encryption.** Go to **Configuration → System → Event log track**, find the
   **Encryption** section, tick **Enable encryption**, and select which event types to
   encrypt (for example `config`). Save the configuration.

From then on, the description of the selected event types is encrypted before it is
stored, and you decrypt entries later with the module's Drush commands.

> **Handling sensitive data.** These logs may contain personal or otherwise sensitive
> information, which is exactly why this module exists. Store the private key securely
> and outside version control — an env-backed key provider is a good fit — restrict who
> can read the ELT logs, and keep a retention policy in mind so encrypted (and
> unencrypted) log data does not accumulate longer than you need it.
