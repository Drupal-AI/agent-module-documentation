# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Search and metadata → Canto Connector**, or navigate directly to
   `/admin/config/search/connector_canto`.

## Select your Canto region

The main setting is the **Canto environment / region** — the Canto domain your account
lives on. Choose the one that matches your organisation's Canto tenant: `canto.com`,
`canto.global`, `canto.de`, or the Canadian/Australian variants. When left unset, the module
defaults to `canto.com`. This value is stored in the `connector_canto.settings` config
object.

## Connect an editor's Canto account

Authentication to Canto is **per user** over OAuth. An editor obtains an access token in the
browser (through the module's connect flow), and the token is stored against their Drupal
account. Until an editor has a valid Canto token, the picker dialog will not populate with
assets for them. Invalid or expired tokens are validated against Canto and purged
automatically.

## Using the picker

With the region configured and a token connected, an editor edits a rich‑text field, opens
the Canto picker from the CKEditor toolbar, and selects assets. On submit the server fetches
each chosen asset into the public files directory and creates a Drupal **File** and **Media**
entity, which is inserted into the content. The dialog enforces a client‑side limit of
128 MB per asset.
