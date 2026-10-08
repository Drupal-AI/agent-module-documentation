# Configuration

Setting up Dual Path Image Save is a two‑part job: first you tell the module *which*
image fields to mirror, then you tell each of those fields *where* the extra copy
should go. Both parts are required — listing a field without giving it a destination
path (or the other way round) means nothing gets copied.

## Step 1 — List the fields to mirror

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Dual Path Image Save**, or navigate directly to
   `/admin/config/media/dual-path-image-save`.
3. In the fields list, enter the **machine names** of the image fields you want to
   mirror — **one per line**. For example, an article's image field is often
   `field_image`.
4. Click **Save**. Your list is stored in the module's configuration
   (`dual_path_image_save.settings`), so it exports cleanly between environments.

Only the fields you list here are ever mirrored; every other image field behaves
normally.

## Step 2 — Set each field's custom destination path

For every field you listed above, open that field's own settings form and tell it
where the extra copy belongs:

1. Go to **Structure → Content types → *(your content type)* → Manage fields**.
2. Click **Edit** on the image field you listed in Step 1.
3. Find the **Dual Path Settings** section that Dual Path Image Save adds to the
   form, and enter the **custom destination path** — a Drupal stream wrapper URI.
   New fields default to `public://`. Use `public://…` for a publicly reachable
   copy, or `private://…` for an alternate private copy.
4. Save the field settings.

A common pattern is a field whose primary storage is `private://` with a Dual Path
destination of `public://` — that keeps the managed original private while a public
mirror stays reachable by the web server.

## How the copy is made

On node save, the module reads each configured field's file and copies it into the
destination directory, creating that directory automatically if it does not yet
exist. The copy keeps the **original filename**, and if a copy with that name is
already there it is **overwritten** (replace‑on‑re‑save). The original upload is
never touched.

> **Note on writability:** the destination directory must be writable by the web
> server user, or the copy will fail. If copies aren't appearing, check the folder
> permissions first.

Because the destination path comes entirely from admin configuration (never from
anything a visitor submits) and the filename is reduced to its base name, there is
no visitor‑controlled path involved in where files land.
