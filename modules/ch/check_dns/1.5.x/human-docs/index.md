# Check DNS — manual setup guide

**Check DNS** (`check_dns`) is a tiny, zero-configuration guard for your user
registration form. When someone signs up, it looks at the domain part of the
email address they entered (the bit after the `@`) and checks whether that domain
actually exists in DNS. If the domain has no DNS record — because it was mistyped
(`user@gmial.com`) or is a throwaway/placeholder that never resolves — the
registration is rejected with the inline error *"Your email domain is not
recognised. Please enter a valid email id."*

The module solves a common signup problem: bots and careless users register with
email domains that can never receive mail, which leaves you with dead accounts and
bounced activation emails. Check DNS screens those out at the form, before an
account is ever created. It only checks that the *domain* resolves (it looks for an
MX/DNS record) — it does not verify that the specific mailbox exists, so pair it
with Drupal's normal email verification if you need that too.

It works the moment you enable it — there is nothing to configure. There is no
settings page, no permission, and no dependencies beyond Drupal core. The only
extra thing it offers developers is a reusable service, `check_dns.service`, whose
`validateEmail($mail)` and `validateHost($host)` methods you can call from your own
code (a webform handler, a REST registration endpoint, a batch that screens
imported users). Note that the check needs working outbound DNS from your web
server; if DNS is unreachable, every domain will fail the check.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. That is the entire setup.

## Where it lives in the admin menu

Nowhere — Check DNS has no admin pages, no settings form, and no permission of its
own. Once enabled it simply hooks into the core user registration form and does its
work silently.

## How to use it

There is nothing to switch on beyond enabling the module. To see it in action, make
sure self-registration is allowed (**Configuration → People → Account settings**),
then visit the registration form (`/user/register`) and try signing up with an
address at a domain that does not resolve, such as `someone@example.invalid`. The
form will refuse it and show the domain error on the email field. A real address
like `someone@gmail.com` goes through as normal.

Developers who want to reuse the same check elsewhere can call the service:

```php
$svc = \Drupal::service('check_dns.service');
$svc->validateEmail('user@drupal.org'); // TRUE only if valid AND the domain resolves
$svc->validateHost('drupal.org');       // TRUE if the bare domain has a DNS record
```
