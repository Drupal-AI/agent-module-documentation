# Configuration

Media Directories needs one thing to come alive: a taxonomy vocabulary to act as the folder
tree. Until you choose one, the *Directory* field has nothing to point at and the media
browser has no folders.

## Open the settings form

1. Log in as a user with the core **Administer site configuration** permission.
2. Go to **Configuration → Media → Media directories**, or navigate directly to
   `/admin/config/media/media_directories`.

## The fields

- **Taxonomy** — a select listing every vocabulary on the site plus a *- None -* option.
  Choose the vocabulary whose terms should be your folders. You can use an existing
  vocabulary (e.g. "Assets") or create a dedicated one.
- **Create new vocabulary** — an AJAX toggle that reveals a *New vocabulary name* field and
  a **Create** button. Enter a name and click **Create** to build a fresh vocabulary and
  point the module at it in a single step — the machine name is derived from the label
  automatically. This is the easiest way to start clean.
- **Show all files in Root directory** — a checkbox controlling what the top-level **Root**
  folder shows:
  - **unticked** (default) — Root behaves as an "unfiled inbox", showing only media that
    has not been placed in any folder.
  - **ticked** — Root shows *every* media item on the site.

  This choice also affects the label of the exposed Views filter's "all" option (*Root
  directory* vs *All directories*).

Click **Save configuration**.

> **Choosing or changing the vocabulary triggers a full cache rebuild.** The *Directory*
> field's definition depends on which vocabulary is configured, so the form flushes all
> caches whenever the vocabulary changes. This is expected — give it a moment. (If you ever
> change the vocabulary with Drush instead of this form, remember to run `drush cr`
> yourself.)

## Creating folders

Folders *are* taxonomy terms in the chosen vocabulary. To add or rearrange folders, manage
that vocabulary the normal way at **Structure → Taxonomy** — add a term for a folder, nest
terms to nest folders. Renaming or re-parenting a term renames or moves the folder, and all
the media inside it follows automatically. If you enabled the **Browser** submodule, you can
also create and drag folders directly in the media browser at
`/admin/content/media-browser`.

## Using directories on media

Once a vocabulary is set, every media item's edit form gains a **Directory** select where
the editor chooses the folder (the top option is labelled *Root directory* for "unfiled").
You can hide that select on a particular media type from its *Manage form display* if
editors should not set it there.

## Good to know

- The exposed *Directory* filter is added to core's Media Library and the admin media
  overview when you install the module. If you later rebuild those Views from scratch you
  lose the filter — re-add it or reinstall the module.
- The same indented folder-tree selection handler (`media_directory:default`) can be reused
  on your own taxonomy reference fields if you want the same nested widget elsewhere.
