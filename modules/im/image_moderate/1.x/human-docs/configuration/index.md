# Configuration

Setting up Automatic Image Moderation is a matter of connecting it to the Azure
moderation API, deciding who reviews flagged images, and understanding the
publish‑blocking workflow it enforces.

## Connect the moderation API

1. Log in as an administrator.
2. Go to **Configuration → Media → Image Moderate**
   (`/admin/config/media/image_moderate`).
3. Enter the details for your **Azure Cognitive Services** image‑moderation
   endpoint and credential. (The module ships a `readme.txt` describing the exact
   fields for the version you have installed — follow it for the endpoint/region and
   key.) For security, supply the key from an environment variable rather than
   pasting a secret into committed configuration, as described in
   [Installation](../installation/index.md).
4. Save the form. From this point on, **all newly uploaded images are checked**.

## Reviewer permissions

Reviewing flagged uploads is gated by permissions. On **People → Permissions**
(`/admin/people/permissions`), assign to your moderator/administrator roles the
image‑moderate entity permissions, which cover the CRUD operations on moderation
results:

- **View image moderate entity**
- **Add image moderate entity**
- **Edit image moderate entity**
- **Delete image moderate entity**
- **Administer image moderate entity** — the overarching permission a moderator
  needs to review flagged content and change its review status.

Grant only what each role needs; the *Administer* permission is the one that lets
someone approve or reject a flagged image.

## The moderation workflow

Once configured, the flow for a flagged upload is:

1. A user uploads an image; the module sends it to the API for screening.
2. If offensive content is detected, a **warning** is shown. The user may still save
   the content, but the module **blocks publishing** and sets the item to
   **unpublished**.
3. A moderator/administrator (holding *Administer image moderate entity*) reviews the
   flagged content and decides whether to allow the image.
4. When the moderator changes the review status to **Reviewed, can be published**,
   the block is lifted (provided no *other* image on the same content is still
   flagged). The content can then be published — the publish status is set
   **manually**.

## Privacy and cost

Because every uploaded image is sent to an external API, plan for the API's per‑image
cost on a high‑upload site, and make sure sending user‑uploaded imagery to a
third‑party service is compatible with your site's privacy policy.
