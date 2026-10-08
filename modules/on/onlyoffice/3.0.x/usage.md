<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The ONLYOFFICE module enables users to edit files in the Media module from Drupal using ONLYOFFICE Docs (Document Server).

---

ONLYOFFICE Connector integrates ONLYOFFICE Docs (Document Server) with Drupal — letting users edit
office documents (docx, xlsx, pptx) stored as Drupal Media directly in the browser via the ONLYOFFICE editor,
with edits saved back through a callback. It ships an `onlyoffice_form` submodule, is configured at
`onlyoffice.settings_form`, provides its own permissions, in the ONLYOFFICE package.

Use it for in-browser collaborative document editing of media files. Security-critical handling is done
correctly: the editor's save **callback** (`/onlyoffice-callback/{key}`, public) is protected two ways —
the `{key}` is an **HMAC keyed with the site's `hash_salt` + `private_key`** (unforgeable link), and, when
the **JWT secret is configured** (`doc_server_jwt`), the callback controller **verifies the JWT** from the
document server (from the body `token` or `Authorization` header, using `Firebase\JWT`) and rejects a
missing token. **Important deployment caveat: set the JWT secret** — the settings note "leave blank to
disable", and leaving it blank **disables callback JWT verification** (the document server should also require
JWT); a configured secret is essential so forged/unauthenticated save-callbacks are rejected. Also run the
document server over **HTTPS** and keep the secret confidential. It has no other access-control role (editing
is gated by the media permissions). Configure the Document Server URL and JWT secret.

---

- Edit Media office files via ONLYOFFICE.
- Edit docx/xlsx/pptx in the browser.
- Save edits via a callback.
- Ship an onlyoffice_form submodule.
- Configure at onlyoffice.settings_form.
- Provide its own permissions.
- Sign the callback {key} with HMAC (hash_salt+private_key).
- Verify the document-server JWT when the secret is set.
- SET THE JWT SECRET (blank disables verification).
- Reject missing/forged callback tokens.
- Run the document server over HTTPS.
- Keep the JWT secret confidential.
- Gate editing by media permissions.
- Configure the Document Server URL.
- Handle collaborative editing.
- Verify save callbacks.
- Configure the JWT secret.
- Edit documents securely.
- Handle document editing.
- Configure ONLYOFFICE.
