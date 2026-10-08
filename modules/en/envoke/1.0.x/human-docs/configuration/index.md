# Configuration

Configuring Envoke comes down to giving Drupal your Envoke API credentials so it can
authenticate, choosing which of your site's mail should go through Envoke, and
setting the sender defaults for outgoing messages.

## Open the settings form

Go to **Configuration → Services → Envoke**
(`/admin/config/services/envoke`). The form is provided by the module and is
protected by the **Administer Envoke** permission, so only roles you grant that
permission can reach it.

## Enter the credentials

The form has these fields (all filled in from your Envoke account):

- **Envoke API ID** and **Envoke API KEY** — the credential pair used for sending
  mail and for the default contact operations.
- **Envoke API ID for Subscription** and **Envoke API KEY for Subscription** — an
  optional second credential pair used for newsletter/subscription operations. Leave
  these blank if you only send transactional mail.

Get these values from your Envoke account (see the
[Envoke API documentation](https://support.envoke.com/en/collections/545624-api)).

## Set the sender defaults

- **Campaign name** — the Envoke campaign to tag mail with. If left blank, the site
  name is used.
- **From email** and **From name** — the default sender for outgoing mail. Individual
  messages can still override these.
- **Reply to email** — the default reply-to address.
- **Input format** — an optional Drupal text format applied to the message body
  before it is sent.

## Route mail through Envoke

Entering credentials does not by itself change how Drupal sends mail. To actually
send through Envoke, select the **Envoke mailer** as the mail backend using Drupal's
mail-system configuration (for example via the
[Mail System](https://www.drupal.org/project/mailsystem) module, or by setting the
`system.mail` interface). You can route all mail through it, or only specific
modules/keys.

## Control who can use it

The module provides the **Administer Envoke** permission. At **People → Permissions**
(`/admin/people/permissions`), grant it only to the roles that should be allowed to
configure the integration.

## Save and test

Save the settings form, then send a test message and confirm it is delivered through
Envoke before routing production mail through the module.
