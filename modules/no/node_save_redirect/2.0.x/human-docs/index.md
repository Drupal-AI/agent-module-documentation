# Node Save Redirect — manual setup guide

**Node Save Redirect** (`node_save_redirect`) lets you choose, **per content
type**, where a user lands after they create or edit a node. Out of the box
Drupal drops you on the saved node's page; with this module you can instead send
the author back to the edit form, to the node view, to the `/admin/content`
overview, or to any custom Drupal path you like. Better still, you can set the
create case and the edit case independently — for example, return to the edit
form after creating, but go to the content overview after editing.

There is no central settings page. The options are added directly to each
content type's edit form, in the **Submission** section, as two small groups:
one for "after saving new content" and one for "after editing existing content".
For each, you pick a redirect type, optionally supply a custom path, and
optionally tell the module to ignore any incoming `?destination=` parameter so
your configured redirect wins. The choices are saved in the content type's
third-party settings, so they export and deploy with your configuration.

Because this is a per-content-type behaviour setting rather than a standalone
config UI, this guide folds the "how to use it" details into this page rather
than a separate configuration chapter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the exact
settings keys — read the sibling [`agent/`](../agent/start.md) docs, especially
[`agent/configure/settings.md`](../agent/configure/settings.md).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Go to **Structure → Content types** (`/admin/structure/types`) and edit the
   content type you want to change.
2. Open the **Submission** vertical tab. You'll find two new groups:
   **Redirect user after saving new content** and **Redirect user after editing
   existing content**.
3. In each group, pick a **redirect type**:
   - **Default** — keep Drupal's normal behaviour.
   - **Return to the editing page** — the node's `edit` form.
   - **View the content** — the node's page.
   - **Content overview** — `/admin/content`.
   - **Custom location** — a path you type into the **location** field, which
     appears only when this option is chosen. Any valid Drupal path works;
     invalid paths are simply ignored.
4. Optionally tick the **destination** checkbox to ignore an incoming
   `?destination=` URL parameter, so your configured redirect takes precedence
   over one another module or link tried to set.
5. Save the content type.

From then on, saving a node of that type redirects according to whether it was a
create or an edit, using the matching group's settings.

## Where it lives in the admin menu

There is no page of its own. The settings live on each content type's edit form
under **Structure → Content types → (edit a type) → Submission**.
