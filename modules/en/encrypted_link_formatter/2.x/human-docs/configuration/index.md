# Configuration

Setting this module up is two jobs: choose the encryption mode and key on the
**Crypt settings** form, then apply the **Encrypted file download** formatter to
a private file or image field.

## Open the Crypt settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Crypt settings**, or navigate directly to
   `/admin/config/system/crypt-settings`.

The form requires the site's **private file system** to be configured; if it is
not, set that up first.

## The settings, field by field

- **Private key / seed** — the secret used to encrypt the URL path. This is
  **required**, and when AES mode is selected it must be at least **16
  characters**. The module ships with the placeholder default
  `your_private_key_here` — **change it** to a strong, random value (a 32-character
  secret is a good choice). Do not commit the real value to version control.

- **Encryption type** — choose one of:
  - **Base 64** — the URL path is only base64-encoded. This hides the filename
    but is reversible by anyone, so treat it purely as tidying.
  - **Base 64 + AES-128-CBC** — the path is additionally encrypted with your
    seed. Selecting this writes a random initialization vector to
    `private://iv/iv.bin` and starts the cron-based IV rotation.

- **Link lifetime** — how long an encrypted link stays valid before it is
  regenerated, chosen from **1, 3, 6, 12, or 24 hours**. This is only meaningful
  in AES mode: on cron, once the current IV is older than this lifetime, the
  module rotates it and the previously issued links stop resolving.

Click **Save configuration** to apply.

## Apply the formatter to a field

1. Go to the **Manage display** tab of the content type (or other entity bundle)
   that has your private file or image field — for example **Structure → Content
   types → *(your type)* → Manage display**.
2. For the field, set the **Format** to **Encrypted file download**.

   This option only appears for fields whose storage uses the **private** file
   scheme — if you do not see it, the field is not a private-scheme file/image
   field.
3. In the formatter's settings (the gear icon) you can optionally set:
   - **Link text** — custom text for the link, with token support when the Token
     module is installed.
   - **Title attribute** — a tooltip for the link.
   - **Open in a new tab** and the HTML5 **download** attribute (to force a
     download rather than opening in the browser).
   - **Additional query parameters** — extra URL parameters, token-replaced.
   - **CSS classes** — custom classes on the rendered link.
4. Save the display.

## A note on secret handling

Because the seed is the key for AES mode, keep it out of version control. With
DDEV you can store it as an environment variable
(`ddev dotenv set .ddev/.env --encrypted-link-seed=<value>`, then
`ddev restart`) and set it from `settings.php` via config override rather than
typing it into the form. And remember: this protects the *appearance* of the URL,
not access to the file — your private-file access rules still do the real
gatekeeping.
