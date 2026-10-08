# Configuration

IntelligenceBank DAM is configured by connecting Drupal to your IntelligenceBank
account, after which editors can browse and use DAM assets from the Media Library
and the rich‑text editor.

## Open the settings form

1. Log in as a user with the **administer intelligencebank configuration**
   permission (grant it under **People → Permissions** if needed — an
   administrator has it by default).
2. Open the IntelligenceBank settings form from **Configuration** in the admin
   menu.

## Connect your IntelligenceBank account

On the settings form, supply the details that identify and authenticate your
IntelligenceBank DAM connection (the platform URL/instance and the account
credentials IntelligenceBank provides). Save the form to establish the connection.

Once connected, decide how assets should come into Drupal:

- **Create a local copy** — the asset is imported into Drupal's own media storage,
  so it lives on your site.
- **Embed a public CDN link** — the asset is referenced from IntelligenceBank's
  CDN rather than copied, keeping the DAM as the single source.

## Keeping the credentials secure

The connection uses IntelligenceBank credentials that grant access to your DAM, so
keep them out of plain configuration:

- Don't commit credentials to version control or paste them into exported
  configuration.
- If you keep secrets in the environment, in **DDEV** you can store a value with
  `ddev dotenv set .ddev/.env --intelligencebank-secret=<value>` (keep
  `.ddev/.env` out of version control) and `ddev restart` so DDEV loads it, then
  reference it when populating configuration.
- Keep all traffic on HTTPS.

## Using it after setup

With the connection saved and the submodules enabled:

- **IB DAM Media** (`ib_dam_media`) — browse and pick DAM assets wherever the core
  **Media Library** appears.
- **IB DAM WYSIWYG** (`ib_dam_wysiwyg`) — insert DAM assets directly from the
  rich‑text editor.

## Verify it worked

As an editor, open the Media Library (or the editor's insert‑media control) and
confirm you can browse your IntelligenceBank assets and add one to a piece of
content — either as a local copy or as an embedded CDN link.
