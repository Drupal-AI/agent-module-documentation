# Configuration

Setting up COOKiES has four parts: **place the banner**, set the **base options**,
edit the **texts**, and define the **service groups and services** that describe
what you're gating.

## 1. Place the consent banner

The banner is the **COOKiES UI** block (`cookies_ui_block`). Add it through
**Structure → Block layout** in whichever region you want (it typically floats
regardless of region). This step matters for more than appearance: COOKiES only
knocks out (blocks) third-party scripts on pages where this block is actually
visible, so make sure it's placed everywhere it's needed.

You can also place a second block, **COOKiES Docs** (`cookies_docs_block`), to
render your cookie documentation, and add a footer menu link pointing at
`#editCookieSettings` so visitors can re-open the consent dialog at any time.

## 2. Base settings

Go to **Configuration → System → COOKiES**
(`/admin/config/system/cookies/config`), gated by the *Configure cookies config*
permission. Config object `cookies.config`. The key options:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Cookie name** | `cookiesjsr` | Name of the consent cookie. |
| **Cookie expires** | 365 | How long (days) the consent cookie lasts. |
| **Cookie domain** | *(empty)* | Domain the cookie is set on. |
| **Secure** | Off | Sets the cookie's Secure flag. |
| **SameSite** | `Lax` | The cookie's SameSite policy. |
| **Open settings hash** | `editCookieSettings` | The URL hash that re-opens the consent dialog. |
| **Show "Deny all"** | On | Shows a Deny-all button on the banner. |
| **Deny all on layer close** | Off | Treats closing the dialog as denying all. |
| **Settings as link** | Off | Renders the settings entry as a link. |
| **Group consent** | Off | Consent per whole group instead of per individual service. |
| **Cookie docs** | On | Enables the cookie documentation output. |
| **Load library from CDN** | On | Load `cookiesjsr` from a CDN; turn off to use the local copy at `/libraries/cookiesjsr`. |
| **Scroll limit** | 0 | Scroll distance that counts as implied consent (0 = off). |
| **Use default styles** | On | Loads the bundled CSS; turn off to fully restyle the banner yourself. |
| **Store consent for authenticated users** | Off | Persists consent decisions for logged-in users. |

All of these are config-translatable.

## 3. Banner and widget texts

At **Configuration → System → COOKiES → Texts**
(`/admin/config/system/cookies/texts`), gated by the *Configure cookies widget
texts* permission, you edit the wording shown on the banner and dialog. Because
the module is fully translatable, you can provide these per language.

## 4. Service groups and services

Consent is organised into **service groups** (the consent categories) and
**services** (individual data processors). Both are config entities managed under
the COOKiES admin area, gated by *Administer cookies services and service groups*.

### Service groups (categories)

Six groups ship out of the box: **functional** (the always-on essential
category), **performance**, **marketing**, **tracking**, **social**, and
**video**. Each has a label, weight, title, and details text. You can edit these
and add your own.

### Services (individual processors)

Create a **service** to represent one third-party tool you want to gate. The
service's machine id is the consent key that scripts are tagged with (for example
`analytics`). Key fields:

- **Label / id** — display name and machine name (the consent key).
- **Group** — which service group (category) it belongs to.
- **Info** — a rich-text cookie table shown in your GDPR documentation.
- **Consent required** — whether the service needs explicit consent.
- **Placeholder text / accept button label** — the message and button shown on the
  overlay that covers a blocked element (for example a blocked video).
- **GDPR documentation fields** — purpose, processor name, contact, and the
  processor's URL, privacy-policy URL, and cookie-policy URL.

Most of the time you don't build services by hand: enabling a `cookies_*` bridge
submodule (like `cookies_ga`) installs its service definition for you. Define a
service manually only for a tool that has no bridge.

## Permissions

| Permission | Grants |
|------------|--------|
| **Configure cookies config** | The base settings form and the COOKiES landing page. |
| **Configure cookies widget texts** | The banner/widget texts form. |
| **Administer cookies services and service groups** | Creating, editing, and deleting service and service-group entities. |

All three are administrative/trusted. The public-facing routes (the consent
callback, the service list, and the documentation page) require only *Access
content*.

## Deploying

Everything — base settings, texts, service groups, and services — is
configuration, so it exports and deploys between environments with `drush
config:export` / `config:import`. You can also set individual base options
directly, e.g. `drush cset cookies.config cookie_expires 180`.
