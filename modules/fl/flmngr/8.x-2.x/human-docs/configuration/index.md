# Configuration

Setting up Flmngr happens in two distinct places: inside Drupal, where you add the
Flmngr buttons to a text format's CKEditor toolbar; and in the **external Flmngr
backend**, where the file-manager's real security settings live.

## Add the Flmngr buttons to a text format

Flmngr attaches to file-choose fields automatically, but for the in-editor file
manager you enable its buttons per text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the text format you want (for example **Full HTML**).
3. In the CKEditor toolbar configuration, drag the **Flmngr** button(s) into the
   active toolbar.
   - **CKEditor 5 users:** be sure to add the Flmngr buttons to the toolbar inside
     the **Full HTML** text format specifically — this is a common step to miss.
4. Save the text format.

You configure this **individually per text format**, so you can offer Flmngr only
where you want it.

## Connect the Flmngr backend

Because the file-manager backend is external, Drupal needs to know how to reach it.
This is done by connecting Drupal to the Flmngr service (its hosted service or your
own installed Flmngr server). The connection detail — the API key / service URL —
is a **credential**: keep it out of configuration exports and version control.

Where a key or token is involved, store it as an environment variable rather than
pasting it into a form. On a DDEV site:

```bash
ddev dotenv set .ddev/.env --flmngr-api-key=YOUR_KEY   # never commit .ddev/.env
ddev restart
ddev exec 'test -n "$FLMNGR_API_KEY"'   # exit status 0 means it is set
```

Then reference that variable rather than hard-coding the secret.

## Where the real upload restrictions live

This is the most important point on the page. The Drupal module does **not** expose
a file-manager endpoint — it ships no controller and an empty routing file. All
uploading and browsing is handled by the **external Flmngr backend**, so the
security-critical settings are configured there, not in Drupal:

- **Who may upload** and general access control.
- **Which file extensions** are permitted.
- **Path handling** and **where uploaded files are stored** (your own server
  storage for free, or S3 / Azure Blob with the optional paid feature — a
  data-location decision, especially if you use Flmngr's hosted service, where
  uploaded files may reside on that service).

Configure the backend's restrictions carefully. By default Flmngr denies file
modification to site visitors and allows it for administrators, but confirm the
extension whitelist and access rules on the backend match your site's policy before
letting editors use it.

## Verify

Edit a piece of content using a text format where you added the Flmngr buttons.
Clicking a Flmngr button should open the file manager, let you upload and browse,
and insert an image or file into the content.
