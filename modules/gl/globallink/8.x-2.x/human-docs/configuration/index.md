# Configuration

GlobalLink Connect is configured as a **TMGMT translator (provider)**, not through
a settings page of its own. Everything below happens on TMGMT's provider form.

## Add GlobalLink as a translation provider

1. Log in as a user who can administer TMGMT.
2. Go to **Configuration → Regional and language → Translation Management →
   Providers** (`/admin/tmgmt/translators`).
3. Click **Add Translator** (provider), give it a readable **label** such as
   "GlobalLink", and choose **GlobalLink** as the **Provider plugin**.

The form then shows the GlobalLink-specific settings.

## Vendor credentials

The plugin needs the connection details for your translations.com / GlobalLink
account — typically the API endpoint (URL), a username, a password or API token,
and the GlobalLink project identifier your content should be submitted to. These
are supplied to you by translations.com when your account is set up. Enter the
values exactly as provided; a wrong endpoint or project id is the most common
cause of jobs failing to submit.

## Keep the credentials out of version control

TMGMT translators are **configuration entities**. That means the values you type
here can end up in an exported configuration file — and you do not want vendor
credentials sitting in a Git repository. Before you commit any configuration
export, check what it contains, and prefer supplying the secret parts through the
environment rather than typing them into the form directly:

- Store the secret with DDEV's dotenv helper so it lives only in the container's
  environment, never in Git:

  ```bash
  ddev dotenv set .ddev/.env --globallink-password=<value>
  ddev restart
  ```

  The flag `--globallink-password` becomes the environment variable
  `GLOBALLINK_PASSWORD`. Keep `.ddev/.env` out of version control.
- Where the deployment allows it, reference that variable rather than storing the
  raw secret in the translator configuration.

Because the module reaches out to translations.com's servers, make sure your
hosting allows **outbound HTTPS** to the GlobalLink endpoint; a locked-down egress
firewall will otherwise block job submission.

## Check the field mapping

When a job is submitted, the module maps TMGMT's job settings onto GlobalLink
project fields:

- **Due** / **required by** → the GlobalLink due date fields.
- **Urgent** → the GlobalLink urgent/priority flag.
- **Comment** → the note attached to the GlobalLink submission.
- **Submitter** → who raised the request.

The GlobalLink project on the vendor side must be configured to accept and
understand these fields. If submissions are rejected or arrive with missing
information, this mapping — not the Drupal form — is almost always where the
problem is. Confirm the vendor-side project matches before going live.

## Save and test

Save the provider, then create a small test translation job from a node's
**Translate** tab, choose your GlobalLink provider at checkout, and submit it.
Watch that the job reaches GlobalLink and that a completed translation comes back
into TMGMT for review and acceptance.
