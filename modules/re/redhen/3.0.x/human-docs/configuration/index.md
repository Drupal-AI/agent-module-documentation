# Configuration

RedHen has a global settings form, but most of the work of turning it into a
working CRM happens elsewhere — in the entity types, fields, and access rules you
build. This page covers the settings form and then points you at where the real
modelling lives.

## Open the settings form

1. Log in as an administrator.
2. Open the RedHen settings form (route `redhen.config`).

These are the base module's **global** options that apply across RedHen. Review
them once when you set the site up; day-to-day CRM work does not happen here.

## Where the real configuration happens

Because RedHen entities are Drupal entities, you configure them the same way you
configure any Drupal content:

- **Contact types and organisation types** — with `redhen_contact` and
  `redhen_org` enabled, define the bundles (types) your CRM needs, then add
  fields to each with the standard Field UI (**Manage fields**) and arrange them
  with **Manage form display** and **Manage display**.
- **Connecting contacts to users** — `redhen_contact` lets a contact record be
  linked to a Drupal user account. Decide whether and how contacts map to logins;
  this is what allows a signed-in contact to maintain their own details.
- **Connections** — with `redhen_connection` enabled, define connection types
  (the kinds of relationship you want to record between two CRM objects) and
  their fields, and set up any Connection Roles that should grant access based on
  a relationship.
- **Deduplication** — with `redhen_dedupe` enabled, use its find-and-merge
  interface to locate and combine duplicate contacts. Choose which fields the
  match is based on.

## Design access before you import — this is not optional

RedHen respects Drupal's permission and entity-access systems, and the RedHen
permissions are on **People → Permissions** (`/admin/people/permissions`). A CRM
holds people's personal data, so the defaults that are fine for website content
are the wrong defaults here:

- Do **not** leave contact records viewable by "authenticated users" or, worse,
  anonymous users. A contact record can hold a home address; decide precisely
  which roles may view, edit, and delete contacts and organisations.
- Plan **retention** up front. Personal data carries deletion and anonymisation
  obligations that ordinary content does not. Make sure you can remove or
  anonymise a contact's data before you import real records — not after someone
  asks you to.

## Save

Save the settings form after any changes. Then do the substantive work — types,
fields, connections, and access — through the admin sections above, and test with
a small set of records before importing at scale.
