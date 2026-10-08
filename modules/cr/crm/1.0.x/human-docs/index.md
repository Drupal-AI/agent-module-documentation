# CRM — manual setup guide

**CRM** (`crm`) — full name Contact Relationship Management — is a native
contact-management system for Drupal. Rather than bolting on an external CRM or
stitching together a handful of contributed modules, it models contacts and their
relationships directly as Drupal entities, fully adopting Drupal's entity
architecture, configuration system, and field API. If your organization needs to
manage people — members, donors, customers, leads, households, or whole
organizations — alongside the rest of your Drupal site, this gives you a place to do
it that feels like the rest of Drupal.

At its core the module defines three content entity types. **Contact** comes with
three bundles out of the box — Person, Household, and Organization — and holds the
people and organizations you track. **Contact Method** stores structured, fieldable
contact information such as an address, email, or telephone number. **Relationship**
maps one contact to another through a configurable, fieldable Relationship Type
(head of household, spouse, employee, member, and so on). You configure the contact
types and their fields to match your data, then manage the actual contacts from the
CRM portal.

Because it builds on well-established field modules, CRM depends on **Address**,
**Name**, **Telephone**, **Image**, core **Datetime**, **Inline Entity Form**, and
**Primary Entity Reference** — Composer and Drush will pull these in for you. The
module provides its own permissions and Drush commands, and requires Drupal 11.1 or
newer. (This is a beta release under active, community-first development.)

One point deserves real attention: CRM data is **personal data (PII)** — names,
contact details, and relationships between people. Access to contact entities must be
carefully permission-gated so that only appropriate staff can view or edit contacts,
and privacy, retention, and consent obligations (such as GDPR) apply to storing this
data. Before going live, verify that the contact access model matches your
data-protection requirements.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (with its field-module dependencies).
2. [Configuration](configuration/index.md) — configure contact types and fields, and
   find where contacts live in the admin.

## Where it lives in the admin menu

Contact types are configured at **Structure → CRM → Contact types**
(`entity.crm_contact_type.collection`). You will also find CRM settings under
`/admin/config/crm`, structure under `/admin/structure/crm`, and the contact portal
at `/crm/contact`.
