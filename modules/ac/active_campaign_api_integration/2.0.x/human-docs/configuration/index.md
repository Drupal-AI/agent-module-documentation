# Configuration

Configuring this module has three parts: save your ActiveCampaign credentials,
map the forms you want to sync, and (optionally) map user registration. All of
it lives under **Configuration → Active Campaign**.

> Remember the access caveat from installation: the admin routes are gated by a
> permission named `administrator` (a role name, not a real permission), so in
> practice only user 1 can reach these pages unless you adjust the routing.

## 1. Save your API credentials

1. Sign in to ActiveCampaign and copy your **API URL** (your account URL) and
   **API token** from your ActiveCampaign account's developer settings.
2. In Drupal, go to the settings form at
   **`/admin/config/active-campaign/active-campaign-settings`**.
3. Enter the API URL and token and save. The module stores one or more
   URL + token pairs and uses the token as an `Api-Token` header on every call
   (over a normal TLS-verified connection).

Treat the token like a password — keep it out of version control. Prefer storing
it as an environment-backed secret rather than pasting a long-lived key into
plain exported configuration.

## 2. Reach the dashboard

Go to **Configuration → Active Campaign** (`/admin/config/active-campaign`). This
is the hub that links to every tool the module provides:

- **Lists** — create, view and delete lists, assign contacts, and manage group
  permissions.
- **Contacts** — import and list contacts, and unsubscribe contacts from lists.
- **Deals** — create deals across contacts (one deal per contact, or a single
  deal with secondary contacts).
- **Pipelines** and **Stages** — create pipelines (deal groups) and the stages
  within them.

## 3. Map a form to ActiveCampaign

1. Go to the form-mapping page at
   **`/admin/config/active-campaign/active-campaign-forms`**.
2. Choose the Drupal form you want to sync, then map each of its fields to the
   corresponding ActiveCampaign contact field.
3. Save. From then on, the module attaches a submit handler to that form so
   submissions create or update the matching ActiveCampaign contact.

## 4. Sync new user registrations

The module can push newly registered users to ActiveCampaign automatically. On
the registration-mapping page, map the user fields (and any custom fields) you
want to send, and **enable at least one mapping**. When a new account is created,
a user-insert hook builds the contact payload from your mapping and sends it to
ActiveCampaign.

## Verify it worked

After configuring a mapping, submit the mapped form (or register a test account)
and confirm the contact appears in ActiveCampaign. Contact IDs are numerically
validated before being used in API URLs, so only well-formed IDs are sent.
