# Configuration

All of Move File's configuration lives under **`/admin/config/media/move-file`**
(route `move_file.settings`), and every screen is gated by the
`administer move_file` permission. There are three parts: choosing which content
types the behaviour applies to, telling it which vocabulary and file fields to
read on each, and defining the term-to-directory mappings.

## Who can configure it

Grant the **`administer move_file`** permission only to trusted administrator
roles. It controls where uploaded files are moved, so treat it as a privileged
permission.

## 1. Choose the content types

On the content-types form, enable Move File for the content types whose files you
want managed. The behaviour runs only for the content types you enable here, so
leave others untouched.

## 2. Set the vocabulary and fields (settings form)

On the settings form, tell Move File, per enabled content type:

- **Which taxonomy field** on the node holds the term that decides the
  destination.
- **Which file/image field(s)** contain the files to move. You can select more
  than one field; all their files are moved to the destination for the chosen
  term.

## 3. Define the directory mappings

Using the directory CRUD UI, create one **directory entity** per term you want to
route. Each mapping specifies:

- **The taxonomy term** it applies to.
- **The destination path** — the folder the files should live in.
- **The scheme** — **public** or **private**. Choosing private (with Drupal's
  private file system configured) is how you use this module to restrict who can
  download the files, especially in combination with the *Private files download
  permission* module.

When a node is saved, Move File looks up the selected term, finds its directory
entity, and builds the destination as `<scheme>://<path>/<filename>`, moving each
file there — but only when that destination differs from the file's current
location, so re-saving an already-filed node does no unnecessary work.

## Try it

1. Create the taxonomy terms and matching directory mappings.
2. Enable a content type and point it at the right taxonomy and file fields.
3. Create or edit a node of that type, pick a term, attach a file, and save.
4. Confirm the file now lives in the mapped directory (and, if you used the
   private scheme, that access is restricted as intended).

To **re-file existing content** after setting things up, simply re-save the
nodes (or change a node's term and save) — the move happens on save.
