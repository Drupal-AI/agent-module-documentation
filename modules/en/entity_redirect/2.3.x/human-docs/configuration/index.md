# Configuration

Entity Redirect has no global settings page. You configure it **per bundle**, on
that bundle's edit form. The same settings appear for content types, media types,
taxonomy vocabularies, contact forms, paragraph types, profile types, and
webforms — this page uses a content type as the running example, but the fieldset
is identical everywhere.

## Open the settings

1. Edit the bundle you want. For a content type that's **Structure → Content types
   → *(your type)* → Edit** (`/admin/structure/types/manage/<bundle>`).
2. Open the **Workflow** vertical tab.
3. Find the **Redirect after Entity Operations** fieldset.

Inside it you'll see a collapsible section for each **action**.

## The actions

Each action is configured independently, so you can send people to different
places depending on what they just did:

- **Add** — where to go after creating a new entity of this bundle.
- **Edit** — where to go after editing an existing entity.
- **Delete** — where to go after deleting an entity. (The "edit form" and "view
  the saved entity" destinations aren't offered here, since the entity is gone.)
- **Override for Anonymous** — a special override that applies **only to anonymous
  users**. It's checked first, so you can, for example, send logged-in editors
  back to the add form but send anonymous submitters to a thank-you page.

Expand an action and you'll find two things: an **Enable** checkbox and a
**Redirect Destination** selector. If you don't tick **Enable**, that action is
left alone and Drupal's normal behavior applies.

## The destinations

For an enabled action, pick one **Redirect Destination**:

| Destination | What happens after save |
|-------------|--------------------------|
| **Default** | No change — Drupal's normal post-save redirect (usually the saved entity). |
| **Add form** | A fresh, empty add form for the same bundle — ideal for entering many items in a row. |
| **Edit form** | The entity's own edit form, so the user stays on the thing they just saved. |
| **The created entity** | The saved entity's canonical page (its normal view). |
| **URL** | A **local** path you specify — see *Local Destination Url* below (e.g. `/thanks`). |
| **Previous page** | The page the form was submitted from, using the HTTP referrer. |
| **Layout Builder** | The entity's Layout Builder (`…/layout`) page. Only appears when core's Layout Builder module is enabled. |
| **External** | A fully-qualified external URL — see *External Destination Url* below. Only available to users with the **Set external entity redirects** permission. |

## The URL fields

Depending on the destination you choose, one of these fields becomes relevant:

- **Local Destination Url** — used when the destination is **URL**. Enter a path
  on your own site, such as `/thanks` or `/dashboard`.
- **External Destination Url** — used when the destination is **External**. Enter
  a full URL including the scheme, such as `https://example.com/welcome`. This
  field, and the External option itself, are only shown to users who hold the
  **Set external entity redirects** permission. The redirect is sent as a trusted
  external redirect.

## Save

Click **Save** on the bundle form. The redirect takes effect immediately for the
matching action on that bundle.

## Personal redirects

Beyond the per-bundle settings, the module allows privileged users to set their
**own** personal redirect on their user profile, overriding the bundle default
for just that user. This is an optional, per-user convenience — the per-bundle
configuration above is the main way to control behavior.

## Permission reference

| Permission | Controls |
|------------|----------|
| `set external entity redirects` | Whether the **External** destination (and its URL field) is available on the form. Grant it only to trusted roles — it lets a user redirect post-save traffic off-site. |

## Setting it from the command line

Because the settings live as third-party settings on the bundle config, you can
read and script them:

```bash
# Read the current redirect settings for the Article content type:
drush cget node.type.article third_party_settings.entity_redirect.redirect
```

They export with the rest of your configuration, so a redirect you set in one
environment deploys to the others like any other config change.
