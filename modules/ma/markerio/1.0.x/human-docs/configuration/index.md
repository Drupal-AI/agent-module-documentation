# Configuration

Two things have to be in place before the Marker.io widget will appear: a
**project key** on the settings form, and the **Access markerio** permission on
the roles that should see it. Both are required — set one without the other and
nothing loads.

## Enter your settings

1. Log in as a user with the **Administer markerio configuration** permission.
2. Go to **Configuration → System → Marker.io**
   (`/admin/config/system/markerio`).

Fill in the form:

- **Project key** *(required)* — your Marker.io project key, from your Marker.io
  project settings. The widget won't load without it.
- **Track node ID where possible** — when enabled, the current node's id is passed
  to the widget on node pages, so a report can be tied to the specific page it was
  filed from. Leave it off if you don't need per‑page tracking.

Click **Save configuration**.

You can also set these from the command line:

```bash
drush config:set markerio.settings project <YOUR_PROJECT_KEY>
drush config:set markerio.settings nid 1
```

## Grant the permissions

At **People → Permissions** (`/admin/people/permissions`), Marker.io provides two
permissions:

- **Administer markerio configuration** — access to the settings form above. Grant
  to administrators only.
- **Access markerio** — the permission that actually shows the widget. Grant it to
  the roles that should be able to report feedback — for example a *QA* or *staff*
  role on staging, or even the *anonymous* role if you want open public feedback.
  A user without this permission sees nothing, and no widget markup is added for
  them.

To turn the widget off for a group instantly, simply remove **Access markerio**
from that role.

## How the identity pre‑fill works

For authenticated users who have the **Access markerio** permission, the module
passes their account email and display name to Marker.io so the reporter's
identity is pre‑filled. Anonymous users (if you grant them access) get the widget
without a pre‑filled identity. Everything after that — the reporting UI, the
screenshot capture, and delivering the issue to your tracker — happens in the
Marker.io SaaS using your project key.
