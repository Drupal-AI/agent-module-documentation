# Configuration

Streamshield is configured through a few admin pages under **Configuration →
Streamshield**. All of them require the **Administer site configuration**
permission.

## 1. Register your site

Go to **Configuration → Streamshield → Registration**
(`/admin/config/streamshield/registration`) and enter the **domain access key** and
**secret** from your Streamshield platform account. These are stored in the
module's settings and are what authenticate the traffic between your site and
Streamshield.

- Treat the access key and secret as **secrets** — they authenticate both the
  outbound moderation requests and the inbound callbacks.
- Moderation does nothing until *both* the access key and secret are present, so
  this step must be completed first.

## 2. Choose which content types are moderated

Go to **Configuration → Streamshield → Content Types**
(`/admin/config/streamshield/content_types`) and select the node and comment types
you want moderated. Only content of the chosen types is sent to Streamshield; the
rest is left alone. System and base fields are excluded from what gets sent —
Streamshield receives the meaningful text (and image/file) fields of the content,
along with metadata (such as the node or comment id) so a callback can target the
right item later.

## 3. Scan existing content (optional)

Go to **Configuration → Streamshield → Scan** (`/admin/config/streamshield/scan`)
to re-process content that already exists on the site, rather than waiting for it to
be edited. This is useful for moderating a backlog after you first turn the module
on.

## How moderation actually flows

- When content of an enabled type is created or updated, the module gathers its
  moderatable fields, signs the payload with your secret key, and sends it to the
  Streamshield API.
- If Streamshield decides content should be removed, it calls back to
  `POST /streamshield/callback`. The module verifies the request's signature, and
  for an `unpublish` action loads the referenced node or comment and unpublishes
  it.
- A companion endpoint, `GET /streamshield/file`, lets the service retrieve file
  bytes for a given path after a signature/access-key check.
