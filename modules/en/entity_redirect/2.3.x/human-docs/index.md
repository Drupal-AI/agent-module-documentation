# Entity Redirect — manual setup guide

**Entity Redirect** (`entity_redirect`) controls where a user lands *after* they
add, edit, or delete an entity. By default Drupal decides that for you — usually
by showing the saved entity — but that's often not what your workflow needs.
Entity Redirect lets you choose the destination yourself, and it lets you choose
it **per bundle** and **per action**, so a content type, a media type, a
vocabulary, a contact form, a paragraph type, a profile type, or a webform can
each send the user somewhere different after Add, after Edit, and after Delete.

Two classic use cases show why it's handy. First, fast data entry: set a content
type so that saving takes the editor straight back to a **fresh add form**, and
they can enter item after item without clicking around — an "add another"
workflow with no custom code. Second, contributor journeys: send someone who
submits a story or a webform to a **thank-you page** or a dashboard instead of the
raw saved entity.

The available destinations are generous. Besides "no change", you can go to a
fresh add form, back to the edit form, straight to the saved entity's page, to a
specific **local path**, back to the **previous page** the form was submitted
from, to the entity's **Layout Builder** page (when Layout Builder is enabled), or
even to a fully-qualified **external URL** (restricted to users with a dedicated
permission). You can also set a separate override just for **anonymous** users —
useful on a public submission form — and privileged users can set their own
personal redirect on their profile.

Everything is stored as settings on the bundle itself, so it travels with your
exported configuration and can differ per environment. There is **no global
settings page, no route, and no Drush command** — you configure each bundle on its
own edit form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per-bundle "Redirect after
   Entity Operations" settings, action by action and destination by destination.

## Where it lives in the admin menu

Entity Redirect has **no page of its own**. You configure it on the edit form of
whichever bundle you want to affect — for example a content type at **Structure →
Content types → *(your type)* → Edit → Workflow tab**
(`/admin/structure/types/manage/<bundle>`), inside the **Redirect after Entity
Operations** fieldset. The same fieldset appears on media types, vocabularies,
contact forms, paragraph types, profile types, and webform settings.

One permission, **Set external entity redirects** (`set external entity
redirects`), controls who may choose the external-URL destination.

## How to use it

1. Edit the bundle you want (for example a content type's **Edit** form).
2. Open the **Workflow** vertical tab and find **Redirect after Entity
   Operations**.
3. Expand the action you care about — **Add**, **Edit**, **Delete**, or the
   **anonymous** override — tick **Enable**, and choose a **Redirect
   Destination**. Fill in the local or external URL field if your chosen
   destination needs one.
4. Save the bundle.

See [Configuration](configuration/index.md) for what each action and each
destination does in detail.
