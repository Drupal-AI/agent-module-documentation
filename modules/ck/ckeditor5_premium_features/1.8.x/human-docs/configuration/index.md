# Configuration

Before any premium feature works, you enter your CKEditor credentials once on the
central settings form. From there, each feature is switched on per text format.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → CKEditor 5 Premium Features**, or navigate directly to
   `/admin/config/ckeditor5-premium-features/settings`.

The settings are stored in the `ckeditor5_premium_features.settings` config
object, so you can also deploy them between environments as configuration.

## License key

- **License key** — your CKEditor commercial license key. This is required for
  Revision History, Track changes, Comments (when used without real-time
  collaboration), and the Productivity Pack. The key is a long string (at least 48
  characters).

## Authorization type

This chooses how the module authenticates to CKEditor Cloud Services for the
cloud-backed features:

- **None** — no Cloud Services authorization. Fine for features that only need the
  license key.
- **Access key** *(recommended for production)* — authenticate with an
  **Environment ID** and an **Access key**, both taken from your CKEditor
  dashboard.
- **Development token** *(testing only)* — authenticate with a **Development token
  URL**. This skips full credential validation and should never be used in
  production. When you pick it you must also tick the acknowledgement that you
  understand the consequences.

Depending on the authorization type you choose, the relevant fields below apply:

- **Environment ID** — from the CKEditor dashboard; used with the Access key
  authorization.
- **Access key** — from the CKEditor dashboard; required with the Access key
  authorization.
- **Development token URL** — used only with the Development token authorization.
- **Organization ID** — your organization identifier from the CKEditor dashboard.
- **Web Socket URL** — the WebSocket endpoint used for real-time collaboration.

Note that **real-time collaboration** and **Import from Word** require the
authorization credentials to be filled in. **Export to Word/PDF** works without
them, but the credentials remove the watermark from exported documents.

## Other settings

- **DLL packages location** — the location of the CKEditor JavaScript bundles (DLL
  packages).
- **Alter node form CSS** — when enabled, lets the module adjust the default Drupal
  theme's CSS on the node form so that exported and collaborative documents render
  correctly.

## Save

Click **Save configuration**. Your credentials are stored and are now available to
every feature submodule.

## Turning a feature on for a text format

Entering credentials does not by itself put any button in the editor. For each
feature you want:

1. Make sure the feature's submodule is enabled (see
   [Installation](../installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a text format that uses CKEditor 5.
3. Drag the feature's button from the *Available buttons* row into the active
   toolbar, adjust any per-format plugin settings, and save.

The feature now appears whenever an editor uses that text format.

## Permissions

The module defines two permissions (at **People → Permissions**) that you grant to
the editor roles that use the cloud/export features:

- **`use ckeditor5 access token`** — grant to roles that use Cloud Services or
  on-premises server features such as real-time collaboration or export to
  Word/PDF. It controls access to the JWT token endpoint the editor calls.
- **`use ckeditor5 exporters endpoints`** — grant to roles that use the Word/PDF
  export plugins; it gates the exporter helper endpoints.

Individual feature submodules may define their own additional permissions.
