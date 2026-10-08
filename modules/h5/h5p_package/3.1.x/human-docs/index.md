# HTML5 Package (h5p_package) — manual setup guide

**HTML5 Package** (`h5p_package`) lets your site upload, author, and display
interactive **H5P** content — quizzes, interactive video, drag-and-drop
questions, question sets, presentations, flashcards, board games, and more. All
of it is HTML5, so it works well on phones, tablets, and desktops, and it's
created and edited right in the browser like any other Drupal content.

This module is a **fork of the original H5P Drupal module**, maintained to keep
H5P working on **Drupal 11** and to continue applying patches. It behaves the way
Drupal 8+ H5P has always worked: H5P is implemented as a **field**, not a
content type. You add an H5P field to a content type, choose the H5P Editor as
its form widget, and authors then create interactive content in that field.

Beyond authoring, H5P lets you **import and export `.h5p` files** — self-contained
packages of HTML5 content that you can move between sites. When you upload a new
*type* of content, the editor learns how to build more of that type, which is what
makes H5P such a flexible authoring tool. An administration page at
`/admin/content/H5P` lists all installed H5P libraries and lets you add
libraries-only packages, delete unused libraries, and see which nodes use a given
library.

**Please read this before giving anyone the upload permission.** An H5P package
bundles JavaScript, CSS, and HTML that **executes in the browser of everyone who
views it**. Uploading an H5P package is therefore effectively uploading active
client-side code — a malicious or compromised package could run arbitrary
JavaScript (cross-site scripting) against your visitors. So treat H5P authoring
as a **privileged capability**, comparable to allowing raw HTML/JS: grant the
H5P upload/create permission only to **trusted authors**, and only obtain H5P
libraries and content from sources you trust.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its editor, and restrict the upload permission.

This module has no single settings form; you configure it through Drupal's
**Permissions**, **Field UI**, and the **H5P library administration** page at
`/admin/content/H5P`, all described below.

## Where it lives in the admin menu

- **H5P library administration:** `/admin/content/H5P` — list, add, and remove
  H5P libraries and see which content uses them.
- **Permissions:** **People → Permissions** — restrict who can upload/create H5P
  content (see the security note above).
- **Field setup:** **Structure → Content types → *(your type)* → Manage fields**
  and **Manage form display** — add the H5P field and choose the H5P Editor
  widget.

## How to use it

1. Enable the module (and its H5P Editor component) — see
   [Installation](installation/index.md).
2. Add an **H5P field** to a content type at **Structure → Content types →
   *(your type)* → Manage fields**.
3. Go to **Manage form display** for that content type and choose **H5P Editor**
   as the widget for the H5P field.
4. Create content of that type. Authors can now build H5P interactives directly,
   or upload an existing `.h5p` file.
5. Restrict the H5P upload/create permission to trusted roles under **People →
   Permissions**.

For deeper H5P authoring documentation and GDPR-compliance guidance, see
[h5p.org](https://h5p.org).
