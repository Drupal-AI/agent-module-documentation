# Configuration

CRM Core is configured largely through the submodules you enable — each one adds its
own administration pages once turned on. There is no single settings form; instead,
you set up contact types, then layer on activities, matching, and user sync as your
project needs them. The CRM Core Handbook on drupal.org is the authoritative,
detailed reference; this page orients you to the main pieces.

## Contacts (`crm_core_contact`)

This is the foundation. Once enabled, you can define **contact types** and add
fields to them, then create and manage the contact records themselves from the CRM
Core contact administration area. Start here: model the kinds of contacts your
organization tracks before enabling the other pieces.

## Activities (`crm_core_activity`)

With the Activity submodule enabled, you can define **activity types** and log
interactions against contacts — a record of calls, meetings, emails, or any event
you want to track over time. Configure the activity types your workflow needs.

## Matching / deduplication (`crm_core_match`)

The Match submodule helps you avoid duplicate contacts. It provides matching rules
that identify when a contact being created or imported already exists, so records can
be merged or reused rather than duplicated. Configure the matching rules to reflect
which fields (name, email, and so on) should count as a match on your site.

## User Sync (`crm_core_user_sync`)

User Sync pairs Drupal **user accounts** with CRM contacts, so that a person's login
and their contact record stay associated. Configure its settings to control how and
when accounts and contacts are linked.

## Access and privacy

CRM Core stores personal data about real people. Grant CRM administration only to
trusted staff, and apply your usual privacy, retention, and consent safeguards to the
contact and activity data you keep here.

## A note on maintenance

This 3.x branch is mostly not maintained. If you are planning new work rather than
maintaining an existing CRM Core site, evaluate the modern
[CRM](https://www.drupal.org/project/crm) module — and note that Drupal 7 CRM Core
sites can migrate their contacts and relationships forward with the **CRM Migrate CRM
Core** module.
