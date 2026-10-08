<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
editics transforms Drupal content into Word/PDF documents via a PhpWord template engine and a remote CRI conversion server.

---

editics ("Editics process") is a document-generation stack: the main module wires up REST convert/editic services and a validator that talks to a remote CRI "flux" server, while the bundled `cri_php_word`, `cri_core_mapping` and `cri_demo` submodules turn mapped field data into Word documents using a PhpWord-based TemplateProcessor.

Configuration lives at `/admin/api/configuration` (`administer site configuration`) where production and "recette" (staging) server URLs plus a credential id/password are stored in `editics.api.settings`. `FluxValidateService::remote()` POSTs the JSON content to the configured URL with an HTTP Basic `Authorization` header built from those credentials. The core-mapping submodule reads YAML mapping documents and processes typed fields (text, date, image, table, numeric, percent, evaluate, etc.) into template placeholders.

This is a heavyweight integration meant for teams generating structured documents from Drupal data. Two code paths need a security eye: the remote validator disables TLS certificate verification while sending Basic-auth credentials, and the `cri_php_word` Evaluate element runs template content through `eval()` (see the security notes reported separately).

---
- Configure production and staging CRI server URLs and credentials.
- Store Basic-auth credential id/password for the flux API.
- Send Drupal content to the remote CRI server for validation.
- Convert mapped field data into a Word (.docx) document.
- Define field-to-placeholder mappings via YAML documents.
- Process text, date, numeric, percent and currency field types.
- Render checkbox lists and tables into a Word template.
- Embed images (base64) into generated documents.
- Switch between prod and recette environments per request.
- Log conversion and REST errors through the editics logger channel.
- Use the demo submodule to preview mapping output.
- Extend the type system with a custom mapping Type class.
- Return structured error arrays when credentials are missing.
- Generate documents from a JSON call payload.
- Apply inline text styles to evaluated template values.
- Wrap PhpWord TemplateProcessor for repeated placeholder blocks.
- Base64-encode a site logo into a document header.
- Build multi-model document sets from a single call.
- Localize the UI with the bundled French translation.
- Integrate document export into an editorial workflow.