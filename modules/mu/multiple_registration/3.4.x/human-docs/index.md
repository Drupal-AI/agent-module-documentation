# Multiple Registration — manual setup guide

**Multiple Registration** (`multiple_registration`) lets you create a **separate
user-registration page for each role**. Instead of everyone signing up through
the single `/user/register` form, you can offer a dedicated page per role —
vendors, students, partners — each at its own friendly URL, and each one grants
the matching role when someone registers there.

For every non-locked role you can spin up a registration page at
`/user/register/{role}`. When you create one you can give it a clean **path
alias** (e.g. `/vendor-signup`), a **redirect** to send new registrants somewhere
specific after submitting, the **form modes** used to render the register and
edit forms (so different roles can show different fields), and a **hidden** flag
that keeps the page reachable only by its direct URL with no visible tab.

Two global settings pages round it out. One holds site-wide options — disable the
default `/user/register` page, redirect already-logged-in users to their profile,
and add per-role "Add user" buttons on the admin People page. The other controls
which registration pages anonymous visitors are allowed to reach. You can even
show or require specific profile fields only on certain roles' registration
forms. It requires core's **Path alias** module and adds one permission,
`administer multiple_registration`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create and manage per-role
   registration pages, the global and access settings, and per-field visibility.

## Where it lives in the admin menu

Everything is managed under **Configuration → People → Multiple registration
pages** (`/admin/config/people/multiple_registration`). From there you list,
create and delete per-role pages, and reach the global **Settings** and **Access
settings** sub-pages.

## How to use it

Go to *Configuration → People → Multiple registration pages*, pick the role you
want a signup page for, and add one — setting its path alias, optional redirect,
form modes, and whether to hide its tab. Save, and the page is live at
`/user/register/{role}` (aliased to your friendly path); anyone who registers
there is granted that role. Repeat for each audience, then use the global and
access settings to fine-tune the default registration page and anonymous access.
See [Configuration](configuration/index.md) for the details.
