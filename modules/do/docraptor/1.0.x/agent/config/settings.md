<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — credential, document type and Prince options

## Install & enable

```bash
composer require drupal/docraptor   # pulls docraptor/docraptor and drupal/key
drush en docraptor -y               # key is enabled as a dependency
```

Requires the **Key** module (`drupal/key ^1.19`) and the Composer library
**`docraptor/docraptor ^3.0 || ^4.0`** (the DocRaptor PHP SDK — a library, not a module).

## Settings route, permission, menu link

- Route **`docraptor.settings`** (`docraptor.routing.yml`) → path
  **`/admin/config/system/docraptor`**, form `Drupal\docraptor\Form\DocraptorSettingsForm`,
  requirement `_permission: 'administer docraptor settings'`.
- Permission **`administer docraptor settings`** (`docraptor.permissions.yml`).
- Menu link **`docraptor.settings`** (`docraptor.links.menu.yml`) under
  `system.admin_config_services`, weight 10.
- `docraptor.info.yml` sets `configure: docraptor.settings`, so the module page's *Configure* link
  points here.

## The credential (API key via Key)

DocRaptor authenticates by sending the account **API key as the HTTP basic-auth username**. This
module never stores that secret in its own config. On the settings form the **"Username"** field is
a `key_select` element (`username_key`), so you choose a **Key entity**; the config object only
stores the Key's **id**. At runtime `DocraptorManager::__construct()` resolves it with
`keyRepository->getKey($username_key)->getKeyValue()` and passes it to the SDK.

Create the Key first (e.g. an env-provider Key holding `DOCRAPTOR_API_KEY`), then select it in the
"Username" field. Configure a Key before any code instantiates `docraptor.manager` — the
constructor has no null guard and will error if `username_key` is unset.

## Config object `docraptor.settings`

Form fields (`DocraptorSettingsForm::buildForm()` / `submitForm()`) and their form defaults:

| Key | Form element | Default | Meaning |
|---|---|---|---|
| `username_key` | `key_select` (required) | `''` | Id of the **Key** holding the DocRaptor API key (used as the API username). |
| `enable_test` | checkbox | `FALSE` | DocRaptor **test mode** — free, watermarked, non-billed docs (`Doc::setTest`). |
| `document_type` | textfield | `pdf` | Output type passed to `Doc::setDocumentType`. |
| `pdf_profile` | textfield | `PDF/UA-1` | Prince `pdf_profile` (e.g. accessibility / PDF/A profile). |
| `color_conversion` | textfield | `sRGB` | Prince `color_conversion`. |
| `enable_pdf_forms` | checkbox | `TRUE` | Prince `pdf_forms` — keep interactive form fields. |
| `enable_icc_profile` | checkbox | `TRUE` | Prince `icc_profile` — embed ICC colour profile. |

Config **schema** (`config/schema/docraptor.schema.yml`, `type: config_object`): `enable_test`
(boolean), `document_type` (string), `username_key` (string), `pdf_profile` (string),
`color_conversion` (string), `enable_pdf_forms` (boolean), `enable_icc_profile` (boolean). No
`config/install` file ships, so the object is created on first save of the form.

### Example exported config

```yaml
# docraptor.settings
enable_test: false
document_type: pdf
username_key: docraptor_api_key   # id of a Key entity
pdf_profile: 'PDF/UA-1'
color_conversion: sRGB
enable_pdf_forms: true
enable_icc_profile: true
```

Note the form's `document_type`/`pdf_profile`/`color_conversion` defaults are only applied by
`buildForm()` display fallbacks; they are written to config on save.
