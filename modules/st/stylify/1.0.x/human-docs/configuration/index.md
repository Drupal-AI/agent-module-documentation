# Configuration

Stylify has two sides: the **on-page editor**, where you actually write CSS, and
the **admin screens**, where you manage the saved stylesheets and release stale
locks. Which permission you hold decides what you can reach — see
[Installation](../installation/index.md) for the permission list.

## The on-page editing workflow

This is the main way you create and change CSS:

1. Open any page where you have permission to edit CSS.
2. Click **CSS Editor** in the bottom-right corner of the page.
3. Choose the **stylesheet scope** you want to work on — Global, Admin global, the
   current Route/View, an Entity type, a Content type, or the individual entity you
   are viewing (for example `node:123`).
4. Click **Edit**. This **acquires a lock** on that stylesheet so no one else can
   edit it at the same time.
5. Type your CSS. Changes **preview live** on the page as you write, with Ace
   syntax highlighting.
6. Click **Save** to store your changes.
7. Click **Save & close** to release the lock when you are done.

Because saving writes CSS that will be served to visitors, every save goes through
a login check, a CSRF token, basic CSS validation, and flood/rate control behind
the scenes — you do not configure these, but they are why a rapid burst of saves
may be throttled and why some CSS patterns are rejected.

### The scopes, in plain terms

- **Global** — CSS applied across the whole front end of the site.
- **Admin global** — CSS applied to the administrative interface.
- **Route / View** — CSS for just the current route or Views display.
- **Entity type** — CSS applied to all entities of a type (for example every node).
- **Content type** — CSS applied to one bundle (for example all Blog posts).
- **Individual entity** — CSS applied to a single node or entity only.

Whether admin CSS applies is decided by whether you are on an administrative route,
so front-end and admin CSS stay cleanly separated.

## Managing saved stylesheets

Users with **Manage stylify settings** get a central admin screen at
**Configuration → System → Stylify stylesheets**
(`/admin/config/system/stylify/stylesheets`), where you can:

- **View** every saved stylesheet in one list.
- **Edit** or **Delete** a stylesheet's CSS without opening the on-page editor.
- **Export** a single stylesheet, or **Export all** of them as JSON.
- **Import** stylesheets from JSON.

Export/import makes it practical to move a set of stylesheets between environments.

## Releasing a stuck edit lock

Because editing locks a stylesheet, a lock can occasionally be left dangling — for
example if a browser tab was closed mid-edit. Go to **Configuration → System →
Stylify Settings** (`/admin/config/system/stylify`) to release stale editor locks
so the stylesheet can be edited again.

## Security, in practice

- Every editor permission is *restrict access* — grant them only to trusted
  administrators, and prefer the narrowest one that fits the role.
- The CSS a user saves is served to **all** visitors of the matching page, so
  treat this power like the ability to deploy code.
- The built-in CSS validation blocks some dangerous patterns but does **not** make
  untrusted CSS safe — it is a safety net, not a boundary. Do not hand these
  permissions to users you would not trust with a code deploy.
- If you only need theme-level custom CSS with no route/entity scoping, a simpler
  module such as CSS Editor may be a better fit; Stylify's strength is
  context-aware, database-stored CSS.
