<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gengo Translator (tmgmt_mygengo) — agent index

TMGMT translator plugin for **Gengo** (ex-myGengo) crowd human translation. Version **8.x-1.0**. Core `^9.3 || ^10`. Depends on tmgmt.

`GengoConnector` (core http_client, api_sig signing, keys in translator settings) submits/polls jobs. Inbound route **`/tmgmt_mygengo_callback` is `_access: 'TRUE'` (anonymous)** → `MyGengoController::callback`, which **does NOT verify Gengo's signature** and writes POSTed translated text onto the local job via `MyGengoTranslator::saveTranslation`. **Unverified-webhook / content-injection finding — see security report.**
