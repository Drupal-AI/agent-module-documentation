# Sites shield — manual setup guide

**Sites shield** (`sites_shield`) puts an HTTP Basic-Auth prompt in front of an
entire site, configured per site through the [Sites](https://www.drupal.org/project/sites)
module. It is the per-site equivalent of the well-known Shield module: a visitor
has to type a username and password before *any* page is served — including 403
and 404 error pages — which makes it a tidy way to hide a staging or pre-launch
site from search engines and casual passers-by.

The gate runs early in Drupal's request pipeline, before routing, so there is no
client-side trick that lets someone slip past it. The password you set is stored
as a hash (not plaintext) using Drupal's password service, and shielded requests
are deliberately kept out of the page cache so a protected page can never be
served to someone who did not authenticate. Each site defines its own username
and password, and leaving the username empty simply switches the shield off for
that site.

The module does its job the moment you configure a username and password on a
site — there is no separate settings page to visit. It depends only on the Sites
module. It also adds a **Skip sites_shield auth** permission (`skip sites_shield
auth`) so you can let trusted roles through without a prompt. Note that this
project has no official security-advisory coverage from the Drupal security team.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Sites module.

## Where it lives in the admin menu

Sites shield has no settings page of its own. Instead, you configure it directly
on each site provided by the Sites module: edit a site, open the **Sites shield**
section of the site edit form, and set a username and password. Leave the
username empty to disable the shield for that particular site. Once a username is
set, visitors to that site are challenged for those credentials before they see
anything.
