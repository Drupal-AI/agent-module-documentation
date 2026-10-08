# Configuration

Setting up Preview Link is three small steps: choose which content can have
preview links, grant the permission to create them, and let editors generate a
link from the content itself.

## 1. Settings form

Open **Configuration → Content authoring → Preview Link**
(`/admin/config/content/preview_link`). You need the **Administer preview link
settings** permission. The form has four settings:

- **Enabled entity types** — a table of the entity types and bundles that can have
  preview links. **Nothing is enabled by default**, so this is the setting that
  actually turns the feature on. Tick a whole entity type to allow all its
  bundles, or tick individual bundles (for example only the Article bundle of
  Node). Enabling a type is what makes the **Preview Link** tab appear on that
  content and lets a valid token unlock it. Only entity types the module supports
  are listed.
- **Expiry** — how long a link stays valid, in seconds. The default is **604800**
  (7 days). Set it shorter for tighter control (e.g. `3600` for one hour).
- **Allow multiple entities per link** — on by default. When on, a single preview
  link can unlock several related entities at once; turn it off to keep one link
  to one entity.
- **Display message** — when editors see the "link created" confirmation message:
  **Always**, only on **Subsequent** visits (the default), or **Never**.

Click **Save configuration**.

## 2. Permissions

Preview Link ships two permissions (set them on *People → Permissions*):

- **Generate preview links** — lets a role create and reset preview links (this is
  what shows the **Preview Link** tab and generate form on content). Grant it to
  your editorial roles.
- **Administer preview link settings** — lets a role open this settings form and
  change which entity types are enabled, the expiry, and the message behavior.
  This is an administrative permission — keep it to trusted roles.

Importantly, **viewing** a previewed page needs *no* permission: a valid preview
token in the URL grants view access on its own, which is exactly why an anonymous
reviewer can open a shared link.

## 3. Editors generate a link

Once a content type is enabled and a role has the create permission, an editor:

1. Opens the (unpublished or draft) piece of content.
2. Clicks its **Preview Link** tab (the content's URL plus
   `/generate-preview-link`).
3. Generates the link and copies the tokenised URL to share — for example by email
   or in a review tool.

To revoke a shared link, reset it (which issues a new token, breaking the old URL)
or let it reach its expiry. Expired links are cleaned up automatically on cron.
