<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, install artifacts & enabling encryption

## Install / enable

```bash
composer require drupal/event_log_track_encrypt
drush en event_log_track_encrypt -y
```

Pulls in and enables `event_log_track`, `encrypt`, `key` (declared in `.info.yml` `dependencies`
and `composer.json` `require`: `drupal/events_log_track:^4.0@beta`, `drupal/encrypt:^3.1`,
`drupal/key:^1.17`). Requires the PHP **OpenSSL** extension. No update hooks; there is **no
configure route** in `.info.yml` (`configure` is null) — the module has no settings form of its
own and injects its UI into ELT's form instead.

## Config object: `event_log_track.encrypt.settings`

Defined in `config/install/event_log_track.encrypt.settings.yml`, schema in
`config/schema/event_log_track_encrypt.schema.yml` (type `config_object`).

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `enable_encrypt` | boolean | `false` | Master toggle shown in the ELT form. |
| `event_types_to_encrypt` | mapping of 13 booleans | all `false` | Per-type flags: `authentication`, `authorization`, `cache_clear`, `comment`, `config`, `file`, `group`, `media`, `menu`, `node`, `taxonomy`, `user`, `workflows`. |

The list of encryptable types is hardcoded in
`_event_log_track_encrypt_event_types_support_encryption()` (`event_log_track_encrypt.module`).

Note: the encrypt-on-write hook (`hook_event_log_track_alter`) keys purely off
`event_types_to_encrypt[$type]`; a type is encrypted whenever its own checkbox is set.

## Where you configure it (UI)

`hook_form_events_track_form_alter()` adds an **Encryption** fieldset to the ELT settings form at
`/admin/config/system/events-log-track` (route/permission owned by the ELT module, not this one):
an *Enable encryption* checkbox plus a *Event types to encrypt* checkbox list (visible when enable
is checked). The `_event_log_track_encrypt_form` submit handler writes the values back into
`event_log_track.encrypt.settings`.

## Shipped install config (Encrypt + Key)

`config/install/` provides the plumbing so encryption works out of the box once you supply a key:

- **Encrypt profile** `encrypt.profile.event_log_track_encryption`
  (`encrypt.profile.event_log_track_encryption.yml`):
  `encryption_method: openssl_public_encrypt`, `encryption_key: event_log_track_public_key`,
  empty `encryption_method_configuration`. This is the profile
  `hook_event_log_track_alter` loads by id.
- **Key entity** `key.key.event_log_track_public_key`
  (`key.key.event_log_track_public_key.yml`): label *Event log track public key*,
  `key_type: public_pem`, `key_type_settings.key_size: 2048`, `key_provider: config`,
  `key_provider_settings.key_value: "!changeMe!"`, input `textarea_field`.

## Post-install steps

1. Generate an RSA key pair offline with the `openssl` CLI (README shows a 2048-bit RSA private
   key protected with AES256, plus its public key). Keep the **private** key and passphrase
   safe and off the server.
2. At `/admin/config/system/keys` edit **Event log track public key** and paste your **public**
   key over the `!changeMe!` placeholder. (Only the public key goes here.)
3. At `/admin/config/system/events-log-track` tick **Enable encryption** and select the event
   types to encrypt (e.g. `config`). Save.

From then on, matching entries store their `description` as
`@@crypt@@<ciphertext>@@endcrypt@@`. Decrypt later with the Drush commands
([drush/decrypt-commands.md](../drush/decrypt-commands.md)).
