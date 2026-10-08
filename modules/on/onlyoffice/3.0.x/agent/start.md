<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ONLYOFFICE Connector — agent index

Lets users **edit Media office files (docx/xlsx/pptx) in the browser via ONLYOFFICE Docs (Document Server)**,
saving via a callback. `onlyoffice_form` submodule. Config at `onlyoffice.settings_form`; provides
permissions. Version **3.0.0**. Core `^11`.

**Security (correct):** the save callback `/onlyoffice-callback/{key}` (public) is protected by an **HMAC
`{key}`** (keyed with `hash_salt`+`private_key`, unforgeable) AND, when the **JWT secret is set**
(`doc_server_jwt`), the controller **verifies the document-server JWT** (body/`Authorization`, `Firebase\JWT`;
rejects missing). **Caveat: SET THE JWT SECRET** — blank **disables** callback verification. HTTPS; keep the
secret confidential. Editing gated by media permissions.
