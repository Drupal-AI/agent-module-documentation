# Configuration

Getting Edition Guard working is a sequence: **connect to EditionGuard** (in the
`editionguard_api` module), then **add books** and **create download
transactions**.

## Step 1 — configure the EditionGuard API credentials

The credentials live in the companion **EditionGuard API** (`editionguard_api`)
module, not in this one. Open its settings form and enter your EditionGuard
account's OAuth email/password and/or token — these are stored in
`editionguard_api.settings` and are sent to `https://app.editionguard.com` over
HTTPS.

Because these are secrets, keep them out of version control. Where the module lets
you source a value from the environment, prefer that over pasting the secret into a
field that ends up in configuration exports. With DDEV you can hold a secret in an
environment variable rather than in the database:

```bash
ddev dotenv set .ddev/.env --editionguard-token=<your-token>
ddev restart
```

The flag `--editionguard-token` becomes the environment variable
`EDITIONGUARD_TOKEN`. **Never commit `.ddev/.env`.** If your build uses the
[Key](https://www.drupal.org/project/key) module to reference secrets from the
environment, wire the credential through a Key entity so the value stays out of
config. Otherwise, treat the `editionguard_api` settings form as a trusted‑admin
surface and keep its exports private.

You can optionally set a **book prefix** in the EditionGuard book settings.

## Step 2 — add a book

1. Go to **Structure → EditionGuard books** (`/admin/structure/editionguard_book`).
   This requires the **"Administer editionguard_book"** permission (plus the
   granular add/edit/delete/view permissions as appropriate).
2. Click **Add EditionGuard book** and fill in the book: its title, the
   EditionGuard **resource id**, the **DRM type**, and the **source file** — which
   is stored in Drupal's **private** file scheme, not the public one.
3. Save.

## Step 3 — create a transaction

A transaction is a per‑user download grant.

1. From **Structure → EditionGuard books**, choose **Create Transaction**
   (`/admin/structure/editionguard_book/transaction/create`), which requires the
   **"Create editionguard_transaction"** permission.
2. Fill in the transaction. The module builds the request from the book's resource
   id and an external id, optionally a **uses‑remaining** limit, and — when the DRM
   type calls for it — **EditionMark watermark** fields carrying the buyer's name
   and email (placed at the start, end, or random locations).
3. Save. The module calls the EditionGuard API, and stores the returned
   **download link**, transaction id, and resource id on the transaction entity.

Other transaction operations:

- **Regenerate** — `/editionguard/transaction/{transaction}/regenerate`
  (permission **"Regenerate editionguard_transaction"**) deletes the old
  EditionGuard transaction and requests a fresh one, giving a new download link.
  Use it to repair a broken or expired link.
- **Change book** — `/admin/structure/editionguard_book/transaction/{transaction}/change_book`
  (permission **"Change book editionguard_transaction"**) reallocates a transaction
  to a different book.

## Permissions and privacy

- Every route and entity operation is permission‑gated: books use **"Administer
  editionguard_book"** plus granular add/edit/delete/view permissions; transactions
  use **create**, **regenerate**, and **change book** permissions. Grant them at
  **People → Permissions** according to who should manage your ebook catalog and
  downloads.
- **Privacy:** applying an EditionMark watermark sends the **buyer's name and
  email** to EditionGuard. Disclose this transfer of personal data in your privacy
  policy, and serve the site over HTTPS.

## Automating transactions

Creating transactions programmatically (for example from a store order) mirrors the
transaction create form. The companion
[Commerce EditionGuard](https://www.drupal.org/project/commerce_editionguard)
project shows how to bridge Drupal Commerce orders to EditionGuard by creating
transactions in code.
