# Configuration

Getting Disqus working takes three things: entering your shortname, attaching the
comments field to a bundle, and granting the *view* permission. The rest is
optional.

## 1. Enter your shortname

1. Log in as a user with the **Administer disqus** permission.
2. Go to **Configuration → Web services → Disqus**
   (`/admin/config/services/disqus`).
3. In **Disqus domain** enter your Disqus site **shortname** — the identifier from
   your Disqus account (for `example.disqus.com`, enter `example`). This is the one
   strictly required value; without it, no threads render.
4. Save.

## 2. Attach a Disqus comments field to a content type

There is no per-content-type checkbox — a thread appears on a bundle only when it
has a **Disqus comments** field.

1. Go to the bundle's **Manage fields** page (for example
   `/admin/structure/types/manage/article/fields`).
2. **Add field → Disqus comments**, give it a label such as "Comments", and save.
3. On **Manage display**, make sure the field's format is **Disqus comments** so
   the thread is shown when the entity is viewed.

Each entity then gets its own thread. You can attach the field to non-node
entities too (users, media, taxonomy terms).

## 3. Grant the view permission

Under **People → Permissions**, the module defines four permissions:

- **View disqus comments** — whether a role may *see* threads. This is the one
  most sites forget: without it, the thread does not display even when the field
  and shortname are set. Grant it to Anonymous and Authenticated for public
  comments.
- **Administer disqus** — access to the settings form; trusted users only.
- **Toggle disqus comments** — lets users turn comments on or off on individual
  nodes.
- **Display disqus comments on profile** — show threads on the profiles of users
  in this role.

## Optional behavior settings

Back on the settings form, a **Behavior** section offers:

- **Localization** — override the Disqus embed language with the site's language.
- **Inherit login** — pre-fill Disqus's "Post as Guest" with the current user's
  name and email.
- **Track new comments in Google Analytics** — send new-comment events (requires
  the Google Analytics module).
- **Notify on new comment** — email the content author when a new comment is
  posted (requires a secret key, below).

## Optional API and SSO settings (advanced)

These appear once the `disqus/disqus-php` library is present and, for SSO, once
both keys are filled in. You get the credentials from your Disqus application
settings.

- **User access token** — enables the module to update, close, or remove Disqus
  threads as content is saved or deleted.
- **API: update thread** — automatically update a thread's title/URL when its
  entity is edited.
- **API: on delete** — when an entity is deleted, do nothing, close its thread, or
  remove it.
- **Public key** and **Secret key** — your Disqus application keys, needed for
  Single Sign-On.
- **Single Sign-On (SSO)** — when enabled, logged-in Drupal users authenticate to
  Disqus as their site identity. You can brand the login button with the site logo
  or a custom 143×32 image.

## Display blocks

Under **Structure → Block layout** you can place any of these Disqus blocks (each
needs the shortname to be set):

- **Recent comments** (`disqus_recent_comments`)
- **Popular threads** (`disqus_popular_threads`)
- **Top commenters** (`disqus_top_commenters`)
- **Combination widget** (`disqus_combination_widget`) — recent, popular, and top
  together.

There is also a Views field exposing the Disqus comment count, useful in listings.
