# Configuration

All of SAML Rules' screens live under **Configuration → People → SAML Rules**
(`/admin/config/people/saml-rules`) and require the **Administer SAML Rules**
(`administer saml rules`) permission. There are two kinds of rule plus a general
settings form.

## Authentication rules

An authentication rule watches a single SAML attribute and, when it matches a
value you specify, performs an action on the account logging in. You manage these
in a matrix view and add, edit or delete them with the accompanying forms. Each
rule has:

- **SAML attribute** — the name of the attribute coming from your IdP that you
  want to test (for example a group or department attribute).
- **SAML value** — the value that attribute must equal for the rule to fire.
- **Action** — either **set the email** (copy a SAML value into the user's email
  address, useful when the IdP sends a duplicated or empty address) or **add
  roles** (assign one or more Drupal roles to the account).

Use these to grant tiered roles based on IdP group membership, or to keep each
account's email unique and in sync with the directory.

## User‑field rules

A user‑field rule maps SAML attribute data into a **custom field on the user
profile**. These are also managed in a matrix view with add/edit/delete forms.
Each rule maps a SAML value into a chosen Drupal user field and can optionally be
guarded by a **condition** (for example, only apply when another attribute is
equal, or not equal, to a value). Field values support `[attribute]`‑style
placeholders, which the module expands from the incoming SAML data — so you can
compose a stored value out of one or more attributes.

Use these to auto‑populate profile fields for new SAML users and to keep those
fields refreshed from the IdP on every login.

## Settings form

The settings form holds a couple of general options:

- **Require authentication** (`require_auth`) — when enabled, anonymous visitors
  are pushed to the login page, effectively forcing SAML sign‑in before they can
  browse the site.
- **SAML account‑management URL** (`saml_account_management_url`) — a URL where
  users can manage their SAML account, used for redirecting them to the IdP's
  own account tools.

Rules and settings are stored in configuration, so they can be exported and
synced between environments like any other Drupal config.

