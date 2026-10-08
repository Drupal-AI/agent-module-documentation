# SSO Bouncer — manual setup guide

**SSO Bouncer** (`sso_bouncer`) adds group-based authorization on top of OpenID
Connect single sign-on. When users log in through Keycloak SSO, it checks the
groups their account carries and **denies login to anyone whose group is not
authorized** for this Drupal site.

On its own, OpenID Connect will happily sign in any user your identity provider
authenticates. SSO Bouncer inserts a gate at exactly the right moment: it
implements Drupal's `hook_openid_connect_pre_authorize()` hook, which runs
*before* the account is authorized. It maps a configured client ID to a set of
allowed Keycloak groups (using OpenID Connect's role mappings), and if the user's
group is not in that mapping it returns access denied with the message *"Your
group is not authorized to access this Drupal instance."* Because the check runs
before authorization and can actively deny, it fails closed — unauthorized groups
do not get in.

This is a genuine authorization control, so the mapping is the security boundary:
a permissive mapping over-grants access, so configure the client ID and the
group-to-role mappings carefully and test that unauthorized groups really are
turned away. As with any OpenID Connect setup, keep the client secret stored as a
secret rather than in exportable configuration.

The module depends on the **OpenID Connect** module, provides a few Drush commands
for turning the gate on and off, and requires Drupal 11. Note that at the time of
writing it is an alpha release and is *not* covered by Drupal's security advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable the bouncer and point it at
   the OpenID Connect client whose group mappings should gate login.

## Where it lives in the admin menu

Its settings form is at **Administration → Configuration → People → SSO Bouncer
Settings** (`/admin/config/people/sso-bouncer`). Before it does anything useful
you also need a working Keycloak SSO client and OpenID Connect role mappings
defined at `/admin/config/people/openid-connect/settings`.

## How it works once configured

After setup, the module validates every SSO authentication automatically. When a
user signs in through Keycloak, it checks whether they hold a group that is
authorized for this instance; if not, access is denied and the login is refused.
