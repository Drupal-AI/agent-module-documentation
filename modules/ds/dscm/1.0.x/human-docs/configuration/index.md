# Configuration

Configuring Did Someone Clone Me is a two‑part task: generate a personal beacon
link on the external service, then paste it into the module's settings form.

## Step 1 — Generate your beacon link

1. Visit [didsomeoneclone.me](https://didsomeoneclone.me).
2. Generate a **personal link** for your site. This is the beacon that will be
   embedded in your pages and that reports back if a clone loads it.
3. During this step you associate the beacon with the **email address** where the
   service should send clone notifications (managed on the service, not in
   Drupal).

## Step 2 — Enter the link in Drupal

1. Log in as a user with the **administer didsomeonecloneme settings**
   permission.
2. Go to **Configuration → System → Did Someone Clone Me**
   (`/admin/config/system/did-someone-clone-me`).
3. Paste your personal beacon link into the settings form and save. The module
   then injects the beacon into your page output, referencing your canonical
   host.

Configuration is stored through Drupal's configuration system and is exportable
with the rest of your site config.

## Permissions

Access to this form is controlled by the dedicated **administer didsomeonecloneme
settings** permission. Grant it only to trusted administrators at **People →
Permissions** (`/admin/people/permissions`).

## After configuring

- **Confirm the beacon is present.** View your site's page source and check that
  the beacon markup appears.
- **Check your CSP.** If you run a Content Security Policy, make sure it allows
  the beacon's markup/callback.
- **Plan your response.** Detection only helps if someone acts on it — pair the
  notifications with a monitoring and takedown procedure.

Remember the limits: the beacon can be stripped by a determined attacker, so this
is an early‑warning aid rather than a guarantee.
