# Configuration

Configuration happens in two places: first you prepare things on the **Google
side**, then you fill in the **Drupal settings form** and choose which bundles to
index.

## Before you start — the Google side

The module authenticates to Google as a **service account**. Before configuring
Drupal you need:

1. A **Google Cloud project** with the **Indexing API** enabled.
2. A **service account** in that project, added as an **owner** of your site's
   property in **Google Search Console** (owner access is what lets the account
   submit URL notifications).
3. The service account's **JSON key file**, downloaded from Google Cloud. You
   will upload this file to Drupal.

Treat that JSON key like a password: it grants indexing rights to your property.
Keep it out of version control and out of any world-readable location.

## A note on permissions

Both the settings form and the bundle-assignment screen require the permission
**`administer google index api`**. Because of a known naming mismatch in this
release, the module *declares* a differently named permission
(`configure indexing api`), so until a role is explicitly granted the
`administer google index api` machine name, **only user 1** can open these pages.
This is a fail-closed situation (it locks the forms down rather than exposing
them), so if you cannot reach the form as an ordinary admin, log in as user 1 or
grant that machine name to a trusted role.

## Open the settings form

Go to **Configuration → Web services → Indexing API**
(`/admin/config/services/indexing-api`).

## Settings, field by field

- **Hostname** — the site host used to build the URLs that get sent to Google.
  It defaults to your current scheme and host, so you normally only change it if
  you need to notify a different canonical domain.
- **Endpoint** — the Google Indexing API URL. Defaults to
  `https://indexing.googleapis.com/v3/urlNotifications:publish`. Leave it as-is
  unless Google changes the endpoint.
- **Scope** — the OAuth scope requested for the API. Defaults to
  `https://www.googleapis.com/auth/indexing`. Leave it as-is under normal use.
- **Service-account key (JSON)** — upload the JSON key file you downloaded from
  Google Cloud. It is saved to the private file system
  (`private://indexing-api/`) and marked as a permanent, in-use file when you
  submit. This is why the private file system must be configured first.

Save the form.

## Choose which entities are indexed

On the settings page, the **Indexing options** table lists the content entity
types eligible for indexing. Only content entity types that have a canonical URL
and are not internal qualify; a few are always excluded (custom blocks, comments,
shortcuts, and custom tokens).

For each entity type, click **Select** to open a modal listing that type's
bundles, tick the bundles you want Google to be notified about, and save. Your
selections are stored per entity type.

## What happens next

From then on, whenever an indexed entity is **created or updated**, the module
sends Google a `URL_UPDATED` notification for that page; whenever one is
**deleted**, it sends `URL_DELETED`. Each request loads your uploaded key,
authorises against Google, and posts the notification for the page's URL
(hostname plus path alias). The outcome of each call — success or failure — is
written to the `indexing_api` log channel, so check **Reports → Recent log
messages** if pages are not being picked up.
