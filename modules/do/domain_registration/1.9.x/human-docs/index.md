# Domain Registration — manual setup guide

**Domain Registration** (`domain_registration`) restricts who can create an
account on your site by checking the **domain of their email address** against a
list you control. You can run it as an **allowlist** — only people with an email
at an approved domain may register — or as a **blocklist** — anyone *except* the
listed domains may register. Both modes support `*` and `?` wildcards, so
`*.company.com` covers every subdomain and `*.edu` covers every university.

It's a simple, effective gate for common situations: limiting an intranet or
member site to your organization's email domain, restricting a SaaS sign-up to
partner/customer domains, or cutting spam sign-ups by blocking known throwaway
email providers. When someone tries to register with a disallowed domain, they see
a custom, translatable error message you configure.

The module adds a validation step to Drupal's standard user registration form and
provides one small settings page for the mode, the domain list, and the error
message. It adds one permission (*administer domain registration*) so you can
delegate managing the list. If you leave the domain list empty, no restriction is
applied and registration stays open.

This guide is written for a **human** configuring the site through the admin UI. If
you want terse, token-cheap references for an AI coding agent (the matching logic
and the reusable service), read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose allow vs deny, enter the
   domain list and wildcards, and set the rejection message.

## Where it lives in the admin menu

Its settings form is at **Configuration → System → Domain registration**
(`/admin/config/system/domain_register`), gated by the **Administer domain
registration** permission.

## How to use it

Enable the module, open its settings page, pick **Allow** or **Deny**, list your
domains (one per line, wildcards allowed), write the error message, and save. From
then on, the standard `/user/register` form enforces the rule. See
[Configuration](configuration/index.md) for the details of each field.

> **Scope to keep in mind.** Enforcement runs **only** on the standard user
> registration form. Accounts created by an administrator via *Add user*, by
> migrations, or programmatically are **not** checked. And because of how the
> domain list is split on line endings, a list deployed via config import using
> Unix (`\n`) newlines can fail to apply. When you deploy this module's config across
> environments, verify the restriction still works. See the sibling `agent/` docs
> for the technical detail.
