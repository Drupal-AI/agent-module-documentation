# Configuration

Send Emails is configured by defining **email templates** in its admin UI. Each
template is a reusable email that your code can later trigger. This page walks
through the settings form and the fields on an email definition.

## Open the settings form

1. Log in as a user with permission to administer Send Emails.
2. Go to **Configuration → Send Emails Configuration**, or navigate directly to
   `/admin/config/send_emails/emails`.

To create a template, define a new email — give it a machine name (for example
`director_private_notes`) and a short description of when it should be used — then
click **Save**. The page then lets you edit the new email's fields.

## Email definition fields

Each email you define has these fields:

- **Subject** — the subject line of the email. Supports Twig variables (see
  below), so you can personalise it.
- **Reply To Email** — the address used when a recipient replies. (Drupal forces
  the *from* address to be the site's email, so this is how you route replies
  elsewhere.)
- **Body** — the HTML body of the email. Also supports Twig variables.
- **Url for Auto Login Link** — the URL used for the `{{ auto_login_link }}` Twig
  variable, which lets the recipient follow a link that automatically logs them in.

### Twig variables you can use

In the subject and body you can reference:

- `{{ name }}` — the username of the recipient, or the name provided.
- `{{ auto_login_link }}` — a URL that automatically logs the user in.
- `{{ site_name }}` — the site name from Basic site settings.
- `{{ site_front }}` — the URL of the site's front page.
- `{{ misc.time-raw }}` — the current UNIX timestamp.
- `{{ misc.userEntity }}` — the Drupal user entity, if one exists.
- Plus any custom Twig variables your calling code passes in.

### A simpler editing screen

If you want to let an editor change only the subject and body of an existing
template (nothing else), point them at the "minimal" edit URL:
`/admin/config/send_emails/emails/minimal/[email_template_machine_name]`.

## Sending the emails

Defining a template does not send anything on its own. Emails are sent when your
code calls the `send_emails.mail` service — for example
`\Drupal::service('send_emails.mail')->notifyUsersByRole($role, $template)` to
email everyone in a role, or `notifyUser($user, $template, $autoLoginLinkUrl,
$replyToEmail, $twigVariables)` to email one user with extra Twig variables. See
the module's `src/EmailApi.php` for the full set of functions.

If you enable the **Send Emails - Manual** submodule, you can instead trigger a
send from the UI at `/admin/config/send_emails/manual/[template_machine_name]`,
which sends the chosen template to everyone in a role. Treat this as a powerful
action and restrict who can reach it.

## Save

Click **Save** on the definition form to store your template. Remember to flush
caches after wiring up new triggering code so the template is available.
