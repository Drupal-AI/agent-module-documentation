# Field IP address PostgreSQL — manual setup guide

**Field IP address PostgreSQL** (`field_ipaddress_pgsql`) provides an **IP
address field type** that is stored and processed using **PostgreSQL's native
network address types** (`inet` / `cidr`). By leaning on PostgreSQL's built‑in
network columns and operators, it enables efficient IP matching directly in the
database. Alongside the field type it provides a formatter and a Views **exposed
filter** that uses PostgreSQL's IP address operators.

The trade‑off is right there in the name: this module is **PostgreSQL‑specific**.
It relies on PostgreSQL network types and operators, so it will **not work on
MySQL or MariaDB**. If your site runs on PostgreSQL and you want IP data stored
in the database's own network types, this is the field for you; if you need a
database‑agnostic option, look at the related
[Field IP address](https://www.drupal.org/project/field_ipaddress) module
instead.

> **Privacy note.** IP addresses are considered **personal data** in many
> jurisdictions (for example under the GDPR). Store and handle values from this
> field in line with your site's privacy policy and applicable law. The field
> has no access‑control role of its own — it is storage and matching only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, confirm you're
   on PostgreSQL, and enable the module.

There is **no central configuration page** for this module — it has no site‑wide
settings form. The field is configured per field when you add it to an entity,
described in "How to use it" below.

## Where it lives in the admin menu

Field IP address PostgreSQL adds no admin page. You use it through the usual
Field UI: **Structure → Content types (or any fieldable entity) → *(bundle)* →
Manage fields → Add field**, where the **IP address** field type appears.

## How to use it

1. On an entity's **Manage fields**, add a new field and choose the **IP
   address** field type provided by this module.
2. Configure and save the field, then add it to your content.
3. To filter on the values in a listing, add the field to a **View** and use its
   **exposed filter**, which is backed by PostgreSQL's IP address operators for
   efficient network matching.

Values are stored in PostgreSQL's `inet`/`cidr` network columns, so range and
containment matching happens in the database itself.
