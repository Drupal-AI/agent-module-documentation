# Configuration

Configuring Collabora Online is mostly about three things: telling Drupal **where
your Collabora server is**, giving it the **shared secret** used to sign WOPI
access tokens, and granting the right **view/edit permissions**.

## 1. Store the connection secret as a Key

Collabora Online uses the **Key** module to hold the shared secret that signs the
WOPI tokens (and, depending on your setup, other connection secrets). Rather than
pasting the secret into plain configuration:

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`).
2. Add a key for the Collabora shared secret, using an environment-backed or file
   provider so the raw value stays out of exported configuration.

> **Using DDEV?** Put the secret in DDEV's dotenv file
> (`ddev dotenv set .ddev/.env --collabora-secret=<value>`, keep `.ddev/.env` out
> of version control, then `ddev restart`), confirm the container sees it with
> `ddev exec 'test -n "$COLLABORA_SECRET"'`, then create a Key with the environment
> provider pointing at that variable.

## 2. Point Drupal at the Collabora server

Open the module's settings form and enter:

- the **Collabora Online server URL** (your CODE or licensed server), and
- the **Key** you created above for signing WOPI access tokens.

Make sure the connection between Drupal and the Collabora server runs over
**HTTPS**, since documents and tokens travel over it.

## 3. Grant the permissions

The module provides its own permissions that gate **who may view and who may edit**
documents. Set these on **People → Permissions** (`/admin/people/permissions`),
granting edit only to the roles that genuinely need it.

Because Drupal is the WOPI *host*, these permissions are what ultimately protect
your documents: the module issues access tokens based on the requesting user's
access, so the Collabora server can only open a document the user is allowed to
see. Keep the permission grants tight, and if you enabled
`collabora_online_group`, remember that group membership can also influence who
reaches a document.

## 4. Set up document media

Documents are Drupal **Media**. Ensure you have a media type for the office file
types you want to edit, and that your editors have permission to create and manage
that media. Once a document exists as media and the server connection is in place,
opening it renders the Collabora viewer/editor inline.

## Security checklist

- Store the server URL and signing secret via the **Key** module — never in
  exported config as plain text.
- Use **HTTPS** between Drupal and the Collabora server.
- Confirm access tokens are bound to both the **document and the user's access**,
  so no one can open a document they lack permission for.
- Grant the edit permission narrowly.
