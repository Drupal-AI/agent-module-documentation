# Configuration

Setting up a file‑selling store is a few steps: turn a product variation type
into a downloadable‑file type, decide on download limits, and make sure customers
can reach their files.

## 1. Add the file trait to a product variation type

1. Go to **Commerce → Configuration → Product variation types**, and edit the
   type you want to sell as downloads.
2. Enable the **"Provides a file for download"** trait.
3. Save.

This adds a required, multi‑value **file** field to the variation type. Its
defaults are:

- **Private storage** — files use Drupal's private file scheme so they are not
  publicly reachable. Make sure your private file path is configured.
- **Description field** enabled — you can give each file a friendly description.
- A generous **allowed‑extensions** list covering common media and document
  types (`mp4 m4v flv wmv mp3 wav jpg jpeg png pdf doc docx ppt pptx xls xlsx`).

When you enable the file trait, the module **automatically** also enables the
**Commerce License** trait and sets the license type to *File* — because a File
license is what unlocks the download. You will see an on‑screen message confirming
this.

From then on, create products of this type and upload the file(s) to each
variation. Buying the variation issues the customer an active File license.

## 2. Global download‑limit settings

Open **Commerce → Configuration → License → File download settings**
(`/admin/commerce/config/licenses/file`); you need the **Administer
commerce_license** permission. Settings are stored in `commerce_file.settings`.

- **Enable download limit** (`enable_download_limit`, off by default) — the master
  switch for a site‑wide download cap. Leave off for unlimited downloads.
- **Download limit** (`download_limit`, default **100**) — when the switch above
  is on, this many downloads are allowed per licensed file.

### How the limit is decided

The effective limit follows this order of precedence: start unlimited; if the
global switch is on, apply the global **download limit**; and if an individual
license has its own **file download limit** value set, *that* wins. So you can set
a global default and still override it per product variation or per license (a
value of `0` means unlimited). Re‑granting a customer's license clears their
download log, which effectively resets their count.

## 3. Let customers reach their files

Two pieces are installed for you and just need placing / checking:

- **"Files download" checkout pane** — shows the order's licensed files on the
  checkout‑complete step. Enable or reorder it in the checkout flow settings if
  needed.
- **"My files" view** (`commerce_file_my_files`) — a page listing everything the
  current user is licensed to download. Link to it from your account menu.

You can also render a download link anywhere the file field appears using the
**download link** field formatter — its *use description as link text* option
swaps the filename for the file's description in the link.

## 4. Amazon S3 / Flysystem (optional)

If a file is stored on Amazon S3 (an `s3` stream wrapper, or a Flysystem scheme
whose driver is S3 with a public bucket), the download route — after verifying an
active license — redirects the customer straight to the file's external S3 URL
instead of streaming it through Drupal. Configure this via the `flysystem` key in
`settings.php`. Note that a public bucket URL is shareable once it has been
issued.

## Save

Save each form as you go. Once a variation type has the file trait and its
products carry files, purchases immediately grant download access under the limits
you configured.
