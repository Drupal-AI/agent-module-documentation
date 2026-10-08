# Configuration

Static Node Generator has a small settings page plus two permissions and an admin
file-management screen. None of it is complicated, but the module does nothing
until you enable at least one node type for static generation.

## Set permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant, to the
roles that should manage static pages:

- **generate static node** — allows creating a static copy of a node (the button
  on the edit form and the bulk action).
- **delete static node** — allows removing generated static files.

## Choose node types and the storage folder

Go to **Configuration → System → Static Node**
(`/admin/config/system/static-node`). Here you:

- **Select which node types support static generation.** Only the node types you
  tick here get the *Generate Static Page* button and participate in the bulk
  actions — everything else stays fully dynamic.
- **Set the static files folder.** This is where generated HTML and its assets are
  written. The default is `public://static`.

Save the form.

## Generate and manage static pages

- **From the node edit form:** enabled node types show a **Generate Static Page**
  button.
- **In bulk:** on the content listing (`/admin/content`), select nodes and use the
  **generate** or **delete** static-content actions.
- **Manage files:** the admin screen at **Content → Static files**
  (`/admin/content/static-files`) lists the generated static files so you can
  review or delete them.

## What happens automatically

- **Redirects:** when a static file exists for a node, anonymous visitors are
  redirected to the static copy, so they are served the fast pre-rendered page.
- **Assets:** CSS, JavaScript, images and other assets are included with the
  generated HTML.
- **Cache clearing:** the module clears the relevant caches for you whenever a
  static page is created or deleted, so you do not have to flush caches by hand.
