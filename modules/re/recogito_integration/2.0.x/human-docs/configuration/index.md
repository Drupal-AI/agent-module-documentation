# Configuration

Recogito Integration needs to be told **which part of each page** visitors can
annotate before anything appears on the front end. That is the main job of the
settings form; an optional section wires annotation tags into a taxonomy
vocabulary.

## Open the settings form

1. Log in as an administrator.
2. Go to `/admin/config/development/recogito_integration`.

## Point the module at the annotatable element

The module attaches the annotation tools to a single DOM element on the page,
which you identify by its type and name. The right values depend on your theme's
markup — inspect a content page in your browser to find a suitable wrapper.

- **Element type** — how you are identifying the target element: by **class**,
  **id**, or **tag**.
- **Element name** — the actual class name, id, or tag to match. For example, to
  make all content inside `<div class="content">` annotatable, set the element
  type to **class** and the element name to **content**.

Choose a target element that wraps **as little non-text markup as possible**. The
fewer surrounding elements it contains, the less annotation positions can drift
between page reloads — the module's documentation calls this out as the main way
to keep annotations stable.

## Optional: store tags as taxonomy terms

- **Annotation vocabulary name** — set this to the machine/name of a taxonomy
  vocabulary and the module will store annotation tags as terms in it, with
  autocomplete from the vocabulary's existing terms.

> **Important:** when this feature is on, the module **deletes** any term in that
> vocabulary that is not attached to an annotation. Always create a **new, empty
> vocabulary dedicated to annotations** and point this setting at it — never at a
> vocabulary that holds terms you want to keep.

## Save

Click **Save configuration**.

## Grant annotation permissions

Annotations are stored as nodes and respect Drupal's permission system, so decide
who may work with them on **People → Permissions** (`/admin/people/permissions`).
The module provides create, read, update, and delete permissions for annotations
— grant them to the roles that should be able to add and manage annotations, and
grant read access to whoever should see them.

## A note on editing annotated content

Annotation positions are anchored to the text as it existed when the annotation
was made. If you later change that text, existing highlights may no longer line
up. Keep edits to annotated content to a minimum, and prefer annotating content
that is not actively being revised.
