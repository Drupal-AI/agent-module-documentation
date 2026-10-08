# Configuration

Media Private Access does nothing until you assign an access mode to a media type.
Everything is configured on one settings page, per type.

## Open the settings form

1. Log in as a user with permission to administer media / site configuration.
2. Go to **Configuration → Media → Media Private Access Settings**, or navigate
   directly to `/admin/config/media/media-private-access`.

For each of your media types you can pick an **access mode**. Media types you leave
unconfigured are untouched — Drupal's standard media access handler continues to
apply — so remember to set the mode after creating a new media type, or it stays on
the default behaviour.

## Assumptions shared by every access mode

Whichever mode you choose, these always hold:

- **Only "view" operations are affected.** Update, delete, and other operations are
  left to Drupal's default access handler; this module does not alter them.
- **Administrators can always view.** Users with the **Administer media**
  permission always get view access, regardless of mode.
- **Owners can always view their own media**, regardless of mode.
- **Unconfigured media types are left alone** — the module does nothing to a type
  until you explicitly give it a mode.

## The access modes

### Permission‑based

View access is granted to any user with the **`view <type> media`** permission — a
new per‑type permission this module generates (find it on **People → Permissions**).
This permission is checked in **all** contexts where the media item is accessed:
its standalone page, when embedded in another entity, in Views results, and so on.
Choose this when access should follow a role/permission rather than page context.

### Inherited from top‑level route

Non‑owners and non‑administrators are **denied** view access to media in
"standalone" contexts — the media detail page (`/media/{media_id}`) and any
rendering context with no top‑level entity to defer to (Views results, for example,
will typically not show the item to them). When the media is used **inside another
entity** (say, referenced from a node field, or embedded in formatted text), the
module checks the **top‑level route** instead and grants access to the media if the
user can access that top‑level page. Choose this when media visibility should track
the page the media appears on.

### Inherited from immediate parent

The most flexible mode, designed to replicate Drupal's standard private‑filesystem
access handling: view access for non‑admins/non‑owners is inherited from the
**immediate parent** entity that references the media. Choose this when access
should follow whatever entity directly embeds the media.

## Save

Click **Save configuration**. The chosen modes take effect immediately for the
configured media types.

## Don't forget the files

Setting an access mode protects the media **entity**, but not the file behind it.
If your restricted media's files live in **`public://`** (the Drupal default), the
raw file URL is still directly downloadable and bypasses this module entirely. To
actually protect the file bytes:

1. Configure Drupal's **private file system** (set a `private://` path in
   `settings.php`).
2. Store the restricted media's source files in the **`private://`** scheme, where
   core's file access and `hook_file_download` enforce access.

Also keep the module's **limitation** in mind: list access control is not
implemented, so a forbidden item can still surface in a View whose filters don't
exclude it. Filter such Views deliberately rather than relying on this module to
hide items from listings.
