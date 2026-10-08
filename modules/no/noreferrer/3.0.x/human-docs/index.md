# No Referrer — manual setup guide

**No Referrer** (`noreferrer`) hardens your site's outbound links by adding the
`rel="noreferrer"`, `rel="noopener"`, and `referrerpolicy="no-referrer"`
attributes to external links and embedded resources. This protects visitor
privacy (the browser stops leaking your page's URL as the "referrer" when someone
clicks out) and security (it blocks the `window.opener` trick that lets a linked
page hijack the tab it was opened from, a.k.a. reverse tab-nabbing).

It works in two places. For links Drupal generates itself — menus, link fields,
and so on — the module adds the attributes automatically: `noopener` goes on any
link that opens in a new window (`target`), and `noreferrer` on any external link
whose host isn't on your allow-list. For links and embedded images/iframes inside
**user-generated content** (body fields, comments), you enable a **text-format
filter** on the formats where you want the protection; the filter rewrites the
markup as it renders and, as a bonus, also cleans up faulty or chopped-off HTML.

Three independent toggles let you choose exactly which attributes are applied (all
on by default), and an **allowed-domains** list exempts trusted partner hosts
(matching a domain also matches its subdomains). For networks of sites, one site
can **publish** its allow-list as a JSON file and others can **subscribe** to it,
refreshing automatically on cron. No Referrer has no third-party dependencies or
submodules and adds no permission of its own (its settings form uses *Administer
site configuration*).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the allow-list
services and the `hook_link_alter` behavior — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the three attribute toggles, the
   allow-list, enabling the text-format filter, and publish/subscribe.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring → No
Referrer** (`/admin/config/content/noreferrer`).

## How to use it

Enabling the module immediately starts protecting the links Drupal generates. To
also protect links inside body fields and comments, go to your text formats and
turn on the **No Referrer** filter. Then, if you have trusted partner sites you'd
rather not strip the referrer from, add them to the allowed-domains list. See
[Configuration](configuration/index.md) for the details.
