# Configuration

All of Instagram Nodes' settings live on one configuration form. It controls the
access token, when imports run, and how many posts to keep.

## Open the configuration form

Go to `/instagram-nodes-configuration`. Access is gated by the module's own
permission, so use an account that has it.

## The settings

- **Access Token** — your Instagram API access token. This is the credential that
  lets the module read your posts. Generate it by adding an Instagram test user to
  your Meta app (see the [installation guide](../installation/index.md)).

  > **Treat the token as a secret.** It authenticates to your Instagram account,
  > so keep it out of version control and exported configuration. On this project's
  > DDEV convention, prefer an environment variable (`ddev dotenv set …`) for
  > sensitive values.

- **Contact emails** — the email address(es) that should be notified when the
  access token expires.

- **Maximum posts to keep** — the cap on stored `instagram_post` nodes. When more
  than this number exist, the oldest posts are purged automatically, so the content
  type doesn't grow without limit.

- **Cron execution interval** — the minimum time that must pass between cron-driven
  imports. This throttles how often the module calls the Instagram API during cron.

- **Send email on expiration** — enable this to receive an email (at the contact
  addresses above) when the token expires, so you can renew it before the import
  quietly stops.

- **Update Posts on Save** — when enabled, posts are (re)imported when the
  configuration form is saved, which is handy for triggering an immediate import
  rather than waiting for the next cron run.

## Save and run an import

Save the form. Posts import on cron according to your interval, or immediately if
you enabled **Update Posts on Save**. After an import, check **Content**
(`/admin/content`) for the new **Instagram post** nodes.

## Displaying the imported posts

Because the posts are ordinary nodes, show them however you like — most commonly a
View listing the `instagram_post` content type, or a custom block. This reads from
your database rather than calling Instagram on each page view, which is the main
reason to import posts as content in the first place.
