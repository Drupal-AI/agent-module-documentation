<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Prepopulate — agent index

Pre-populates a **Webform** from external data referenced by a **hash** — values stored server-side,
**not in the URL** (keeps PII out of links/logs). Per-session access limit (`MAX_HASH_ACCESS=5`),
`disable_hash_access_limit` setting, `bypass webform prepopulate hash access limit` permission. Depends
on `webform`, `webform_ui`. Version **2.x** (dev). Core `^9||^10||^11`.

The hash is a **capability** — anyone with it loads the stored values; keep the access limit on and
distribute links carefully.
