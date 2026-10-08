# Configuration

Before Skribble Integration can send anything for signing, you need to give it
your Skribble account details and decide how documents are delivered.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Skribble**, or navigate directly to
   `/admin/config/services/skribble`.

## The settings

- **User** — your Skribble API username. Together with the API key, the module
  uses this to log in to Skribble and obtain an access token.
- **API key** — your Skribble API key.
- **Base URL** *(optional)* — an override for the Skribble API endpoint. Leave it
  blank to use the default (`https://api.skribble.com/v2`); set it only if you
  need to point at a different Skribble environment.
- **File delivery method** — choose how the document is handed to Skribble:
  - **Base64 upload** — the file is encoded and uploaded directly to Skribble.
  - **Protected download link** — instead of uploading, the module gives Skribble
    a URL to fetch the file from your server. This URL is HMAC-signed and
    time-limited, so it cannot be reused or guessed by anyone else.
- **Quality** — the signature quality level passed through to Skribble (for
  example SES, AES, or QES).
- **Legislation** — the legislation setting passed through to the signature
  request.
- **Email signers** — when enabled, signers are notified by email when a request
  is created. When disabled, per-signature notification is forced off.
- **Enable success callbacks** — when enabled, the module gives Skribble a
  callback URL so it can notify your site when signing completes. This callback is
  safe by design: it identifies the request by an unguessable ID and re-verifies
  the real status with an authenticated API call before treating anything as
  signed.

Save the form when you are done.

## Signing-request entities

Each signing request is stored as a `skribble_signing_request` entity. You can
manage the entity type and its settings at
`admin/structure/skribble-signing-request` (requires the *Administer
skribble_signing_request* permission), and the individual requests are listed
under **Content**. Grant the view/create/edit/delete permissions for these
entities to the roles that need them at **People → Permissions**.

## How the signing flow works

Once configured, a signing request is started from a file (for example via the
signing action link the module adds to content). The signer is redirected to
skribble.com to sign, and when they come back the module checks the status with
Skribble and, only when the document is fully signed, downloads the signed PDF
into `private://skribble/`. Every step — the signatures, the title and message,
the redirect URL, the post-download handling — can be customised from a custom
module using the hooks documented in the module's `skribble.api.php` file.
