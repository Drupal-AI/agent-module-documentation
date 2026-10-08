# Configuration

There is no settings page for this module. Setting it up means two things: adding
the buttons to a text format's CKEditor toolbar, and making sure IMCE core grants
your roles access to the right file scheme (which is where access is actually
enforced).

## 1. Add the buttons to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and click **Configure** on the format you
   want (for example *Full HTML*).
2. In the **CKEditor 5** toolbar configuration, drag the buttons you want from the
   list of available items into the active toolbar. The four buttons are:

   | Button | What it opens |
   |---|---|
   | **Imce Private Image** | the IMCE image picker against the private (`private://`) scheme |
   | **Imce Private Link** | the IMCE link picker against the private scheme |
   | **Imce Public Image** | the IMCE image picker against the public (`public://`) scheme |
   | **Imce Public Link** | the IMCE link picker against the public scheme |

   The public buttons are handy when your site's default scheme is private but you
   still want an explicit way to browse public files.
3. **Save** the text format.

The module also adds **IMCE public** and **IMCE private** tabs under **Content**
(`/admin/content`) that open the file manager for each scheme directly, and it wires
private‑file browsing into the core editor image/link dialogs where applicable.

## 2. Grant scheme access in IMCE (this is the real access control)

The buttons only surface the file browser — they do **not** grant anyone access.
Whether a user can actually browse or read a scheme is decided entirely by IMCE
core, based on whether the user's role has an IMCE **profile** assigned for that
scheme:

1. Go to **Configuration → Media → IMCE** (`/admin/config/media/imce`).
2. Make sure there is an IMCE **configuration profile** suitable for the private
   scheme (create one if needed, setting its allowed directories and operations).
3. In the **Role‑Profile assignments**, assign that profile to the relevant roles
   **for the private scheme**. Do the same for the public scheme if you use the
   public buttons.

If a role has no private‑scheme profile, its users will see the private button but
will not be able to browse or read private files — IMCE core blocks them
server‑side.

## 3. Private file downloads

Even after browsing, downloading a private file goes through Drupal's private‑file
delivery pipeline. To control who may actually download the private files your
editors reference, install and configure the *Private files download permission*
module (recommended by this module's maintainers).

## Verify it worked

Log in as a user in a role that has a private‑scheme IMCE profile, open a content
form using the text format you configured, and click one of the private buttons in
the editor toolbar — the IMCE file manager should open against `private://`. A user
in a role without that profile should be denied access by IMCE.
