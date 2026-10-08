# Configuration

Configuring H5P has two parts: managing the **interactive content types**
(libraries) that authors can use, and the **global settings** that control how
content displays and where files are stored. A set of permissions then decides who
can do what.

## Installing content types (libraries)

Interactive content types — MultiChoice, Interactive Video, Course Presentation,
and so on — are called *libraries*, and they are not shipped with the module. You
install them at **Content → H5P Content** (`/admin/content/h5p`), which requires the
**Administer H5P libraries** permission. From there you can:

- **Upload** a `.h5p` package (which bundles its libraries), or
- **Install from the H5P Hub** — available when the **H5P Editor** submodule is
  enabled.
- **Restrict** a content type so only certain roles may create it, **upgrade**
  existing content to a newer library version, **delete** a library, and **rebuild
  the content‑type cache** at `/admin/content/h5p/rebuild-cache`.

Libraries live in the database and filesystem, not in exported configuration, so
they are managed per environment rather than deployed as config.

## Global settings

Go to **Configuration → System → H5P** (`/admin/config/system/h5p`). This form is
gated by the core **Administer site configuration** permission (not an H5P
permission). The main options:

### Display options

These control the action bar shown around a piece of content:

- **Show the H5P frame** — the toolbar that carries the buttons below.
- **Download (export) button** — lets viewers download the `.h5p` package.
- **Embed button** — lets viewers grab an embed snippet.
- **Copyright button** and **About H5P button** — show the rights and info dialogs.

Turning a button off here hides it globally, regardless of the per‑user
copy/download/embed permissions.

### Storage and revisions

- **Default path** — the directory (under the files folder) where H5P stores
  content and libraries. Defaults to `h5p`.
- **Save content per revision** — keep a separate copy of content files for each
  node revision. Turning it off saves disk space.

### Learner state and xAPI

- **Save content state / autosave frequency** — let learners resume interactive
  content where they left off, and how often (in seconds) their state is saved.
- **Enable LRS‑dependent content types** — turn on content types that require a
  Learning Record Store (xAPI).

### Hub, statistics, and development

- **Use the H5P Hub** — fetch content types from the central Hub.
- **Send usage statistics** — contribute anonymous usage data to the H5P project.
- **Development mode** — disables some caching while you build custom libraries.

There are also file‑extension whitelists controlling which file types are allowed
inside H5P content and libraries.

## Permissions

H5P defines a rich permission set (most are marked security‑sensitive):

- **Administer H5P libraries** — upload, update, delete, and restrict libraries on
  the H5P Content page.
- **Update H5P libraries** — update existing libraries.
- **Access all H5P results** / **Access own H5P results** — view result data for
  everyone, or just for oneself.
- **Create restricted H5P content types** — create content of types marked
  "restricted".
- **Copy all / own H5Ps**, **Download all / own H5Ps**, **Embed all / own H5Ps** —
  show the corresponding buttons for all content or only content the user can edit.
  (These have no effect if the button is globally disabled in the display options.)

With the **H5P Editor** submodule enabled you also get **Access H5P editor** (use
the authoring widget) and **Install recommended H5P libraries** (install only
Hub‑recommended types).

Grant these at **People → Permissions**.
