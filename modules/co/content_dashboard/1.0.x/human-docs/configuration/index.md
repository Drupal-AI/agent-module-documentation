# Configuration

Content Dashboard has **no settings form**. Its behavior is controlled entirely
by permissions and by the access each role already has to your content, media,
and admin pages. The one required setup step after installing is granting the
dashboard permission.

## Grant the "access content dashboard" permission

1. Log in as a user with the **Administer permissions** right (an administrator by
   default).
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Find the **access content dashboard** permission and tick it for every role
   that should be able to open **My Dashboard** — typically your editor and
   content‑manager roles.
4. Click **Save permissions**.

Users in those roles will now see the **My Dashboard** item in the administration
menu.

## How role access shapes the dashboard

The dashboard is personalized: its sections appear according to what each role can
access, so you do not configure the page contents directly — you configure them
indirectly through your existing roles and permissions.

- **Content section** — lists the content types the user can create, each with a
  link to that type's filtered content list.
- **Media section** — lists the media types the user can work with (audio,
  documents, images, video, and so on), each linking to that type's media list.
- **Configuration section** — shows administrative links (users list, webforms,
  taxonomies, site settings, and similar) to users whose roles can reach them.

Because every list and link honors Drupal's normal access checks, a role only ever
sees the parts of the dashboard it is entitled to use. To change what an editor
sees on the dashboard, adjust that role's content, media, and administration
permissions in the usual places rather than looking for a dashboard‑specific
option.
