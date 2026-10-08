# Configuration

Configuring Ray Enterprise Translation is a sequence: connect your account, tell
Drupal which languages and content are translatable, define one or more
translation profiles, and confirm the notification callback works. Everything is
reached from **`/admin/lingotek`**.

## Step 1 — Connect your account

1. Log in as a user with the **Administer Lingotek** permission (this permission is
   marked *restricted* because it grants control over the integration and its
   credentials — keep it to trusted administrators).
2. Go to **`/admin/lingotek`** and follow the connect/setup flow. You authorize
   the site against your Ray Enterprise account using the API/OAuth credentials you
   stored during [installation](../installation/index.md).
3. After connecting, the module knows your Lingotek **community, project, workflow,
   and vault** settings, which it uses when uploading documents.

## Step 2 — Set up languages and translatability

Because the module builds on Drupal's core multilingual system:

1. Add the languages you want under **Configuration → Regional and language →
   Languages**.
2. Enable translation for the content entity types, bundles, and fields you want
   to translate (Content Translation), and for configuration where relevant
   (Configuration Translation).

Ray Enterprise maps its own locales to your Drupal languages so uploaded documents
come back into the correct language.

## Step 3 — Create translation profiles

**Profiles** are the heart of the module. A profile decides, for the content it is
assigned to:

- **When content uploads** — automatically on save, or only when you request it.
- **How it is translated** — machine translation, professional/human translation,
  or a combination through a workflow.
- **Which target locales** apply.

Create the profiles you need on the Lingotek settings pages, then assign a profile
to each content type / bundle (and to configuration) so new and existing items
follow the right rules. Separating profile assignment from full administration is
supported through the **Assign Lingotek translation profiles** permission, so an
editor can manage what gets translated without holding the full admin permission.

## Step 4 — Manage translations day to day

- The **Manage Lingotek translations** permission lets a user upload documents,
  request translations, and pull completed translations back — the routine work —
  without the restricted admin permission.
- The Lingotek **dashboards** show the state of every document: uploaded, in
  progress, completed, or **drifted** (the source changed after translation).
  Use them to audit what is current and what is stale.
- **Jobs** group translation work so it can be sent to and tracked with a vendor.

## Step 5 — The notification callback

The integration is bidirectional. Ray Enterprise calls your site at
**`/lingotek/notify`** when a document changes state (for example, a translation
finishes), and the module pulls the result in. This endpoint authenticates the
incoming call against a shared secret configured with your account, so it only
accepts genuine callbacks. Make sure the endpoint is reachable from the internet
in production, and rotate the shared secret carefully if you ever need to change
it — a rotated or mismatched secret will cause legitimate callbacks to stop
authenticating.

## A reminder about data egress

Every upload sends content, configuration, or interface text to the Ray Enterprise
TMS and, where you use human translation, to a translation vendor. Choose profiles
and translatable fields with that in mind, and keep the **Administer Lingotek**
permission — which can see and change the account connection — restricted to people
you trust.
