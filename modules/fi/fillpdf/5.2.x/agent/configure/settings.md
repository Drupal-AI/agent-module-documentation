# FillPDF global settings

Form `FillPdfSettingsForm` at **`/admin/config/media/fillpdf`** (route `fillpdf.settings`, permission
`administer pdfs`). Config object: **`fillpdf.settings`** (schema `fillpdf.settings`).

## Keys (with `config/install` defaults)

| Key | Default | Meaning |
|---|---|---|
| `backend` | *(none)* | Which PdfBackend to use: `fillpdf_service`, `local_server`, or `pdftk`. |
| `allowed_schemes` | `[private]` | Storage schemes allowed for **saving** generated PDFs. `public` is offered but labelled "discouraged / no access control". |
| `template_scheme` | `''` | Storage scheme for **uploaded templates** (`''` → system default scheme). |
| `remote_protocol` | `https` | FillPDF Service protocol (`https` recommended / `http`). |
| `remote_endpoint` | *(none)* | FillPDF Service host (no protocol). |
| `fillpdf_service_api_key` | *(none)* | FillPDF Service API key (admin-entered; not shipped). |
| `local_service_endpoint` | *(none)* | FillPDF LocalServer base URL, e.g. `http://127.0.0.1:8085`. |
| `pdftk_path` | `pdftk` | Path to the pdftk binary (used in shell command). |
| `shell_locale` | `en_US.UTF-8` | Locale used when escaping shell commands (Unix: chosen from `locale -a`). |

No secrets or keys are hardcoded/shipped — endpoints, API key, and passwords are all admin-entered.

## Backend choice

Three backends (radio, one active at a time). The chosen `backend` id is passed as the plugin id +
`fillpdf.settings` values as plugin config.

| Backend | id | How it fills |
|---|---|---|
| FillPDF Service | `fillpdf_service` | XML-RPC (`xmlrpc()`) to `remote_protocol://remote_endpoint` with `fillpdf_service_api_key`. Image filenames are anonymized (md5) before sending. |
| FillPDF LocalServer | `local_server` | Guzzle `POST` base64 JSON to `local_service_endpoint` `/api/v1/parse` and `/api/v1/merge`. Self-hosted (VPS/Docker). |
| pdftk | `pdftk` | Local `exec()`/`passthru()` of `pdftk` with an XFDF data file; args shell-escaped via `ShellManager`. Needs pdftk installed on the server. |

Validation (`validateForm()`): for `local_server` it pings the endpoint (`FillPdf::checkLocalServiceEndpoint`);
for `pdftk` it checks the path (`FillPdf::checkPdftkPath`); it also prepares (creates) the `fillpdf`
subdirectory in every allowed scheme and the template scheme.

## Storage scheme behavior (matters for access)

- **Template storage** (`template_scheme`) — where uploaded PDF templates live. `private` recommended;
  `public` gives no access control over the template file.
- **Allowed schemes** (`allowed_schemes`) — a generated PDF is only *saved* if the form's `scheme` is
  both an available write-visible stream wrapper **and** in `allowed_schemes`. Otherwise
  `HandlePdfController::handlePopulatedPdf()` logs a critical and falls back to a browser-only
  `download` (never silently writes to an unexpected scheme).

Set via Drush:

```bash
ddev drush config:set fillpdf.settings backend pdftk -y
ddev drush config:set fillpdf.settings pdftk_path /usr/bin/pdftk -y
ddev drush cr
```

## Notes

- `pdftk_path` and the endpoints are admin-only config; the pdftk command uses `escapeShellArg` on the
  template/XFDF paths and passwords, and the binary path comes only from this trusted setting.
- If a previously used `template_scheme` becomes unavailable, the form warns and lists the FillPDF forms
  that will not work until their templates are moved.
